"""
OOPMAX Test Suite - Using Only Benefit and Accumulator Responses

This approach tests scenarios using only benefit_response.json and accumulator_response.json
without requiring scenario_config.json files.
"""

import json
import pytest
from pathlib import Path
from typing import Dict, Any, List, Optional
from unittest.mock import patch, MagicMock
from fastapi.testclient import TestClient

from app.main import app
from app.schemas.benefit_response import BenefitApiResponse
from app.schemas.accumulator_response import AccumulatorResponse
from app.schemas.cost_estimator_request import CostEstimatorRequest
from app.schemas.cost_estimator_response import CostEstimatorResponse


class OOPMAXTestFramework:
    """Framework for managing OOPMAX test scenarios with synthetic data - NO CONFIG FILES!"""
    
    def __init__(self, base_path: Optional[Path] = None):
        """Initialize the test framework."""
        if base_path is None:
            self.base_path = Path(__file__).parent.parent / "mock-data" / "mock-api-test-data" / "oop_max"
        else:
            self.base_path = Path(base_path)
    
    def load_test_data(self, scenario_name: str, data_type: str) -> Dict[str, Any]:
        """Load specific test data file for a scenario."""
        data_file = f"{data_type}.json"
        data_path = self.base_path / scenario_name / data_file
        
        if not data_path.exists():
            raise FileNotFoundError(f"Test data file not found: {data_path}")
        
        with open(data_path, 'r') as f:
            return json.load(f)
    
    def get_available_scenarios(self) -> List[str]:
        """Get list of available scenario directories."""
        scenarios = []
        for item in self.base_path.iterdir():
            if item.is_dir() and item.name.startswith("scenario_"):
                scenarios.append(item.name)
        return sorted(scenarios)
    
    def create_mock_benefit_response(self, scenario_name: str) -> BenefitApiResponse:
        """Create a mock BenefitApiResponse from scenario data."""
        benefit_data = self.load_test_data(scenario_name, "benefit_response")
        return BenefitApiResponse(**benefit_data)
    
    def create_mock_accumulator_response(self, scenario_name: str) -> AccumulatorResponse:
        """Create a mock AccumulatorResponse from scenario data."""
        accumulator_data = self.load_test_data(scenario_name, "accumulator_response")
        return AccumulatorResponse(**accumulator_data)
    
    def create_mock_cost_request(self, scenario_name: str) -> CostEstimatorRequest:
        """Create a mock CostEstimatorRequest from scenario data."""
        cost_data = self.load_test_data(scenario_name, "cost_request")
        return CostEstimatorRequest(**cost_data)
    
    def create_mock_cost_response(self, scenario_name: str) -> CostEstimatorResponse:
        """Create a mock CostEstimatorResponse from scenario data."""
        cost_data = self.load_test_data(scenario_name, "cost_response")
        
        # Parse the nested structure properly
        cost_estimate_response = cost_data["costEstimateResponse"]
        service_data = cost_estimate_response["service"]
        cost_estimate_response_info_data = cost_estimate_response["costEstimateResponseInfo"][0]
        
        # Create the service object
        from app.schemas.cost_estimator_request import Service, SupportingService, Modifier, PlaceOfService
        service = Service(**service_data)
        
        # Create the cost estimate response info object
        from app.schemas.cost_estimator_response import (
            CostEstimateResponseInfo, Coverage, Cost, HealthClaimLine, 
            AccumulatorInfo, Accumulator, AccumulatorCalculation
        )
        from app.schemas.cost_estimator_request import ProviderInfo, Speciality, ProviderNetworks, ProviderNetworkParticipation
        
        # Create provider info
        provider_data = cost_estimate_response_info_data["providerInfo"]
        provider_info = ProviderInfo(
            serviceLocation=provider_data["serviceLocation"],
            providerType=provider_data["providerType"],
            speciality=Speciality(code=provider_data["speciality"]["code"]),
            taxIdentificationNumber=provider_data["taxIdentificationNumber"],
            taxIdQualifier=provider_data["taxIdQualifier"],
            providerNetworks=ProviderNetworks(networkID=provider_data["providerNetworks"]["networkID"]),
            providerIdentificationNumber=provider_data["providerIdentificationNumber"],
            nationalProviderId=provider_data["nationalProviderId"],
            providerNetworkParticipation=ProviderNetworkParticipation(providerTier=provider_data["providerNetworkParticipation"]["providerTier"])
        )
        
        # Create coverage
        coverage_data = cost_estimate_response_info_data["coverage"]
        coverage = Coverage(**coverage_data)
        
        # Create cost
        cost_data = cost_estimate_response_info_data["cost"]
        cost = Cost(**cost_data)
        
        # Create health claim line
        health_claim_data = cost_estimate_response_info_data["healthClaimLine"]
        health_claim_line = HealthClaimLine(**health_claim_data)
        
        # Create accumulators
        accumulators = []
        for acc_data in cost_estimate_response_info_data.get("accumulators", []):
            accumulator = Accumulator(**acc_data["accumulator"])
            accumulator_calc = AccumulatorCalculation(**acc_data["accumulatorCalculation"])
            accumulators.append(AccumulatorInfo(accumulator=accumulator, accumulatorCalculation=accumulator_calc))
        
        # Create cost estimate response info
        cost_estimate_response_info = CostEstimateResponseInfo(
            providerInfo=provider_info,
            coverage=coverage,
            cost=cost,
            healthClaimLine=health_claim_line,
            accumulators=accumulators
        )
        
        # Create cost estimate response
        from app.schemas.cost_estimator_response import CostEstimateResponse
        cost_estimate_response_obj = CostEstimateResponse(
            service=service,
            costEstimateResponseInfo=[cost_estimate_response_info]
        )
        
        # Create final response
        return CostEstimatorResponse(costEstimateResponse=cost_estimate_response_obj)
    
    def extract_benefit_values(self, benefit_response: BenefitApiResponse) -> Dict[str, Any]:
        """Extract key values from benefit response for validation."""
        benefit = benefit_response.getBenefit()
        if not benefit or not benefit.coverages:
            return {}
        
        coverage = benefit.coverages[0]
        return {
            "isServiceCovered": coverage.isServiceCovered == "Y",
            "code": coverage.relatedAccumulators[0].code if coverage.relatedAccumulators else None,
            "costShareCopay": coverage.costShareCopay,
            "costShareCoinsurance": coverage.costShareCoinsurance,
            "copayAppliesOutOfPocket": coverage.copayAppliesOutOfPocket == "Y",
            "coinsAppliesOutOfPocket": coverage.coinsAppliesOutOfPocket == "Y",
            "deductibleAppliesOutOfPocket": coverage.deductibleAppliesOutOfPocket == "Y",
            "copayCountToDeductibleIndicator": coverage.copayCountToDeductibleIndicator == "Y",
            "copayContinueWhenDeductibleMetIndicator": coverage.copayContinueWhenDeductibleMetIndicator == "Y",
            "copayContinueWhenOutOfPocketMaxMetIndicator": coverage.copayContinueWhenOutOfPocketMaxMetIndicator == "Y",
            "isDeductibleBeforeCopay": coverage.isDeductibleBeforeCopay == "Y"
        }
    
    def extract_accumulator_values(self, accumulator_response: AccumulatorResponse) -> Dict[str, Any]:
        """Extract key values from accumulator response for validation."""
        values = {}
        
        # Get all accumulators by network
        accumulators = accumulator_response.get_accumulators_by_network("InNetwork")
        
        # Extract deductible values by level
        for acc in accumulators:
            if acc.code == "Deductible":
                if acc.level == "Individual":
                    values["DIcalculatedValue"] = acc.calculatedValue
                elif acc.level == "Family":
                    values["DFcalculatedValue"] = acc.calculatedValue
            elif acc.code == "OOP Max":
                if acc.level == "Individual":
                    values["OOPMAXIcalculatedValue"] = acc.calculatedValue
                elif acc.level == "Family":
                    values["OOPMAXFcalculatedValue"] = acc.calculatedValue
        
        return values


class TestOOPMAXMockAPI:
    """Test class using only benefit and accumulator responses - NO CONFIG FILES!"""
    
    @pytest.fixture(autouse=True)
    def setup_method(self):
        """Setup method to initialize test framework."""
        self.framework = OOPMAXTestFramework()
        self.available_scenarios = self.framework.get_available_scenarios()
    
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
            
            # Mock spanner client
            mock_spanner.return_value = MagicMock()
            
            yield {
                'estimate': mock_estimate,
                'token': mock_token,
                'spanner': mock_spanner
            }
    
    def setup_mock_responses(self, scenario_name: str, mock_estimate):
        """Setup mock responses for a specific scenario."""
        try:
            expected_cost_response = self.framework.create_mock_cost_response(scenario_name)
            mock_estimate.return_value = expected_cost_response
        except FileNotFoundError:
            # Create basic mock response if specific one doesn't exist
            from app.schemas.cost_estimator_response import (
                CostEstimatorResponse, 
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
                serviceLocation="0003543634",
                providerType="HO",
                speciality=Speciality(code=""),
                taxIdentificationNumber="",
                taxIdQualifier="",
                providerNetworks=ProviderNetworks(networkID="00387"),
                providerIdentificationNumber="0006170130",
                nationalProviderId="",
                providerNetworkParticipation=ProviderNetworkParticipation(providerTier="")
            )
            
            mock_cost_info = CostEstimateResponseInfo(
                providerInfo=mock_provider,
                coverage=Coverage(
                    isServiceCovered="Y",
                    maxCoverageAmount="",
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
                    amountpayable="640.00"
                ),
                accumulators=[]
            )
            
            mock_service = Service(
                code="21137",
                type="CPT4",
                description="",
                supportingService=SupportingService(code="", type=""),
                modifier=Modifier(modifierCode=""),
                diagnosisCode="",
                placeOfService=PlaceOfService(code="22")
            )
            
            mock_response = CostEstimatorResponse(
                costEstimateResponse=CostEstimateResponse(
                    service=mock_service,
                    costEstimateResponseInfo=[mock_cost_info]
                )
            )
            mock_estimate.return_value = mock_response
    
    # ============================================================================
    # SCENARIO 3.1: No OOPMAX Applies - Using Only Benefit and Accumulator Responses
    # ============================================================================
    
    @pytest.mark.api
    @pytest.mark.asyncio
    async def test_scenario_3_1_api_call(self, client: TestClient, mock_external_services):
        """Test Scenario 3.1: No OOPMAX Applies - API call with synthetic data."""
        scenario_name = "scenario_3_1_no_oopmax_applies"
        
        # Load test data 
        cost_request = self.framework.load_test_data(scenario_name, "cost_request")
        
        # Setup mock responses
        self.setup_mock_responses(scenario_name, mock_external_services['estimate'])
        
        # Make API request
        headers = {
            "Content-Type": "application/json",
            "x-global-transaction-id": "oopmax-3.1",
            "x-clientrefid": "oopmax-client-3.1",
        }
        
        response = client.post(
            "/costestimator/v1/rate",
            json=cost_request,
            headers=headers,
        )
        
        # Validate response
        assert response.status_code == 200
        body = response.json()
        assert "costEstimateResponse" in body
    
    @pytest.mark.api
    def test_scenario_3_1_benefit_response_validation(self):
        """Test Scenario 3.1: Validate benefit response - NO CONFIG FILE NEEDED!"""
        scenario_name = "scenario_3_1_no_oopmax_applies"
        
        # Load and create benefit response
        benefit_response = self.framework.create_mock_benefit_response(scenario_name)
        benefit_values = self.framework.extract_benefit_values(benefit_response)
        
        assert benefit_values["code"] == "Deductible"
        assert benefit_values["isServiceCovered"] == True
        assert benefit_values["costShareCopay"] == 100
        assert benefit_values["costShareCoinsurance"] == 20
        assert benefit_values["copayAppliesOutOfPocket"] == False  
        assert benefit_values["coinsAppliesOutOfPocket"] == False  
        assert benefit_values["deductibleAppliesOutOfPocket"] == False  
        assert benefit_values["isDeductibleBeforeCopay"] == True
    
    @pytest.mark.api
    def test_scenario_3_1_accumulator_response_validation(self):
        """Test Scenario 3.1: Validate accumulator response """
        scenario_name = "scenario_3_1_no_oopmax_applies"
        
        # Load and create accumulator response
        accumulator_response = self.framework.create_mock_accumulator_response(scenario_name)
        accumulator_values = self.framework.extract_accumulator_values(accumulator_response)
        
        # Should have deductible values but no OOPMAX values
        assert "DIcalculatedValue" in accumulator_values
        assert "DFcalculatedValue" in accumulator_values
        assert accumulator_values["DIcalculatedValue"] == 500.0
        assert accumulator_values["DFcalculatedValue"] == 1500.0
        
        # Should not have OOPMAX values (or they should be None/0)
        # This validates the "No OOPMAX Applies" scenario
        oopmax_individual = accumulator_response.get_accumulator_by_code("OOP Max", "InNetwork")
        oopmax_family = accumulator_response.get_accumulator_by_code("OOP Max", "InNetwork")
        
        # Either no OOPMAX accumulators exist, or they have null/zero values
        if oopmax_individual:
            assert oopmax_individual.calculatedValue is None or oopmax_individual.calculatedValue == 0
        if oopmax_family:
            assert oopmax_family.calculatedValue is None or oopmax_family.calculatedValue == 0
    
    @pytest.mark.api
    def test_scenario_3_1_benefit_accumulator_consistency(self):
        """Test Scenario 3.1: Validate benefit and accumulator responses are consistent."""
        scenario_name = "scenario_3_1_no_oopmax_applies"
        
        # Load both responses
        benefit_response = self.framework.create_mock_benefit_response(scenario_name)
        accumulator_response = self.framework.create_mock_accumulator_response(scenario_name)
        
        # Extract values
        benefit_values = self.framework.extract_benefit_values(benefit_response)
        accumulator_values = self.framework.extract_accumulator_values(accumulator_response)
        
        # Validate consistency
        # If deductible applies to out-of-pocket, we should have deductible accumulators
        if benefit_values["deductibleAppliesOutOfPocket"]:
            assert "DIcalculatedValue" in accumulator_values
            assert "DFcalculatedValue" in accumulator_values
        
        # If OOPMAX doesn't apply, we shouldn't have meaningful OOPMAX values
        oopmax_individual = accumulator_response.get_accumulator_by_code("OOP Max", "InNetwork")
        oopmax_family = accumulator_response.get_accumulator_by_code("OOP Max", "InNetwork")
        
        # For "No OOPMAX Applies" scenario, OOPMAX accumulators should be minimal or absent
        if oopmax_individual:
            assert oopmax_individual.calculatedValue is None or oopmax_individual.calculatedValue == 0
        if oopmax_family:
            assert oopmax_family.calculatedValue is None or oopmax_family.calculatedValue == 0
    
    @pytest.mark.api
    def test_scenario_3_1_data_completeness(self):
        """Test that all required test data files exist for Scenario 3.1."""
        scenario_name = "scenario_3_1_no_oopmax_applies"
        required_files = ["cost_request", "benefit_request", "benefit_response", "accumulator_response", "cost_response"]
        
        for file_type in required_files:
            data = self.framework.load_test_data(scenario_name, file_type)
            assert data is not None, f"Failed to load {file_type} for scenario {scenario_name}"
    
    # ============================================================================
    # PLACEHOLDER FOR OTHER SCENARIOS - NO CONFIG FILES NEEDED!
    # ============================================================================
    
    @pytest.mark.skip(reason="Scenario 3.2 not yet implemented")
    @pytest.mark.api
    def test_scenario_3_2_family_met_no_copay_after(self):
        """Test Scenario 3.2: OOPMAX Family is met, No Copay after OOPMAX met."""
        # This would test with HARDCODED business logic:
        # - Family OOPMAX calculatedValue = 0 (met)
        # - Individual OOPMAX calculatedValue > 0 (not met)
        # - copayContinueWhenOutOfPocketMaxMetIndicator = False
        pass
    
    @pytest.mark.skip(reason="Scenario 3.3 not yet implemented")
    @pytest.mark.api
    def test_scenario_3_3_individual_met_family_not(self):
        """Test Scenario 3.3: OOPMAX Individual is met, No Copay after OOPMAX met."""
        # This would test with HARDCODED business logic:
        # - Individual OOPMAX calculatedValue = 0 (met)
        # - Family OOPMAX calculatedValue > 0 (not met)
        # - copayContinueWhenOutOfPocketMaxMetIndicator = False
        pass
    
    @pytest.mark.skip(reason="Scenario 3.6 not yet implemented")
    @pytest.mark.api
    def test_scenario_3_6_oopmax_not_met(self):
        """Test Scenario 3.6: OOPMAX not met (Individual and Family)."""
        # This would test with HARDCODED business logic:
        # - Both Individual and Family OOPMAX calculatedValue > 0 (not met)
        # - limitType = "Counter"
        # - LimitcalculatedValue = 10
        pass
