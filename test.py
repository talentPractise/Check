import json
from pathlib import Path
from typing import Dict, Any
from unittest.mock import patch

import pytest
from fastapi.testclient import TestClient

from app.main import app
from app.schemas.cost_estimator_response import CostEstimatorResponse


class TestOOPMaxMockAPI:
    """Test class for OOPMAX-related API mock testing."""
    
    @pytest.fixture(autouse=True)
    def setup_method(self):
        """Setup method to initialize test data paths."""
        self.base_path = Path(__file__).parent.parent / "mock-data" / "mock-api-test-data" / "oop_max"
        self.test_data_files = {
            "no_oopmax_applies": str(Path("no_oop_max_applies") / "cost_api_request.json"),
            # "family_met_no_copay_after": str(Path("family_met_no_copay_after") / "cost_api_request.json"),
            # "individual_met_family_not": str(Path("individual_met_family_not") / "cost_api_request.json"),
            # "copay_after_met": str(Path("copay_after_met") / "cost_api_request.json"),
            # "coinsurance_after_met": str(Path("coinsurance_after_met") / "cost_api_request.json"),
            # "oopmax_met": str(Path("oopmax_met") / "cost_api_request.json"),
        }
    
    def load_test_data(self, scenario: str) -> Dict[str, Any]:
        """Load test data from JSON file for given scenario."""
        file_path = self.base_path / self.test_data_files[scenario]
        with open(file_path, 'r') as f:
            return json.load(f)

    @pytest.fixture
    def mock_external_services(self):
        """Mock external services and dependencies."""
        with patch('app.services.impl.cost_estimation_service_impl.CostEstimationServiceImpl.estimate_cost') as mock_estimate, \
             patch('app.services.token_service.TokenService.get_new_token') as mock_token, \
             patch('app.database.spanner_client.SpannerClient') as mock_spanner:
            
            # Mock token service
            mock_token.return_value = {
                "access_token": "mock_token_123",
                "expires_in": 3600,
                "token_type": "Bearer"
            }

            # Build a minimal but complete CostEstimatorResponse like in deductible tests
            from app.schemas.cost_estimator_response import (
                CostEstimateResponse, 
                CostEstimateResponseInfo,
                Coverage,
                Cost,
                HealthClaimLine
            )
            from app.schemas.cost_estimator_request import (
                ProviderInfo, Speciality, ProviderNetworks, ProviderNetworkParticipation,
                Service, SupportingService, Modifier, PlaceOfService
            )

            mock_provider = ProviderInfo(
                serviceLocation="000761071",
                providerType="PH",
                speciality=Speciality(code="91017"),
                taxIdentificationNumber="0000431173518",
                taxIdQualifier="SN",
                providerNetworks=ProviderNetworks(networkID="58921"),
                providerIdentificationNumber="0004000317",
                nationalProviderId="1386660504",
                providerNetworkParticipation=ProviderNetworkParticipation(providerTier="1")
            )

            mock_cost_info = CostEstimateResponseInfo(
            providerInfo=mock_provider,
            coverage=Coverage(
                isServiceCovered="Y",
                maxCoverageAmount="500.0",  # <-- FIXED: use string
                costShareCopay=100.0,
                costShareCoinsurance=20
            ),
            cost=Cost(
                inNetworkCosts=900.0,
                outOfNetworkCosts=0.0,
                inNetworkCostsType="Amount"
            ),
            healthClaimLine=HealthClaimLine(
                amountCopay="100.00",
                amountCoinsurance="160.00",
                amountResponsibility="900.00",
                percentResponsibility="20",
                amountpayable="800.00"
            ),
            accumulators=[]
        )

            mock_service = Service(
                code="99214",
                type="CPT4",
                description="Office visit - established patient (complex)",
                supportingService=SupportingService(code="470", type="DRG"),
                modifier=Modifier(modifierCode="25"),
                diagnosisCode="Z00.00",
                placeOfService=PlaceOfService(code="11")
            )

            mock_response = CostEstimatorResponse(
                costEstimateResponse=CostEstimateResponse(
                    service=mock_service,
                    costEstimateResponseInfo=[mock_cost_info]
                )
            )
            mock_estimate.return_value = mock_response

            yield {
                'estimate': mock_estimate,
                'token': mock_token,
                'spanner': mock_spanner
            }

    @pytest.mark.parametrize("scenario,transaction_id", [
        ("no_oopmax_applies", "oopmax-3-1"),
        ("family_met_no_copay_after", "oopmax-3-2"),
        ("individual_met_family_not", "oopmax-3-3"),
        ("copay_after_met", "oopmax-3-4"),
        ("coinsurance_after_met", "oopmax-3-5"),
        ("oopmax_met", "oopmax-3-6"),
    ])
    @pytest.mark.api
    @pytest.mark.asyncio
    async def test_oopmax_scenarios(self, client: TestClient, mock_external_services, scenario, transaction_id):
        """Test all OOPMAX scenarios using cost_api_request.json."""
        test_data = self.load_test_data(scenario)
        headers = {
            "Content-Type": "application/json",
            "x-global-transaction-id": transaction_id,
            "x-clientrefid": "oopmax-client",
        }
        response = client.post(
            "/costestimator/v1/rate",
            json=test_data,
            headers=headers,
        )
        assert response.status_code == 200
        body = response.json()
        assert "costEstimateResponse" in body
        info = body["costEstimateResponse"]["costEstimateResponseInfo"][0]

        # Validate that coverage elements reflect expectations
        assert info["coverage"]["isServiceCovered"] == "Y"
        assert info["coverage"]["costShareCopay"] == test_data["expectedCoverage"]["costShareCopay"]
        assert info["coverage"]["costShareCoinsurance"] == test_data["expectedCoverage"]["costShareCoinsurance"]

        # Validate the in-network cost mirrors expected service amount
        assert info["cost"]["inNetworkCosts"] == test_data["expectedServiceAmount"]

        # Echoed back service
        assert body["costEstimateResponse"]["service"]["code"] == test_data["service"]["code"]

        # Verify service was called with correct data
        mock_external_services['estimate'].assert_called_once()
        call_args = mock_external_services['estimate'].call_args
        request_obj = call_args[0][0]
        assert request_obj.membershipId == test_data["membershipId"]
        assert request_obj.service.code == test_data["service"]["code"]
        assert request_obj.zipCode == test_data["zipCode"]

    @pytest.mark.api
    @pytest.mark.asyncio
    async def test_invalid_request_validation(self, client: TestClient):
        """Test API validation with invalid request data."""
        invalid_data = {
            "membershipId": "",
            "zipCode": "12345",
        }

        headers = {
            "Content-Type": "application/json",
            "x-global-transaction-id": "oopmax-invalid-001"
        }

        response = client.post(
            "/costestimator/v1/rate",
            json=invalid_data,
            headers=headers
        )

        assert response.status_code in [400, 422]
        error_data = response.json()
        assert "detail" in error_data

    @pytest.mark.api
    @pytest.mark.asyncio
    async def test_missing_headers_handling(self, client: TestClient, mock_external_services):
        """Test API behavior with missing optional headers."""
        test_data = self.load_test_data("no_oopmax_applies")

        headers = {
            "Content-Type": "application/json"
        }

        response = client.post(
            "/costestimator/v1/rate",
            json=test_data,
            headers=headers
        )

        assert response.status_code == 200
        body = response.json()
        assert "costEstimateResponse" in body

    @pytest.mark.api
    @pytest.mark.asyncio
    async def test_service_error_handling(self, client: TestClient):
        """Test API error handling when service throws exception."""
        with patch('app.services.impl.cost_estimation_service_impl.CostEstimationServiceImpl.estimate_cost') as mock_estimate:
            mock_estimate.side_effect = Exception("Service unavailable")

            test_data = {
                "membershipId": "M-ERR-1",
                "zipCode": "85305",
                "benefitProductType": "HMO",
                "service": {
                    "code": "99214",
                    "type": "CPT4",
                    "placeOfService": {"code": "11"}
                },
                "providerInfo": [
                    {"providerType": "PH"}
                ]
            }

            headers = {
                "Content-Type": "application/json",
                "x-global-transaction-id": "oopmax-error-001"
            }

            try:
                response = client.post(
                    "/costestimator/v1/rate",
                    json=test_data,
                    headers=headers
                )
                assert response.status_code in [500, 422, 400]
            except Exception as e:
                assert "Service unavailable" in str(e)


@pytest.mark.api
class TestOOPMaxMockAPIUtils:
    """Utility tests for OOPMAX mock API testing."""
    
    def test_mock_data_file_exists(self):
        base_path = Path(__file__).parent.parent / "mock-data" / "mock-api-test-data" / "oop_max" / "no_oop_max_applies"
        file_path = base_path / "benefit_request.json"
        assert file_path.exists(), "Scenario file not found"



