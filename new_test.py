import pytest
from unittest.mock import AsyncMock, Mock

from app.services.impl.cost_estimation_service_impl import CostEstimationServiceImpl
from app.schemas.cost_estimator_request import (
    CostEstimatorRequest,
    Service,
    SupportingService,
    Modifier,
    PlaceOfService,
    ProviderInfo,
    Speciality,
    ProviderNetworks,
    ProviderNetworkParticipation,
)
from app.models.rate_criteria import NegotiatedRate
from app.schemas.benefit_response import (
    BenefitApiResponse,
    ServiceInfoItem,
    ServiceCodeInfoItem,
    PlaceOfServiceItem,
    ProviderTypeItem,
    ProviderSpecialtyItem,
    Benefit,
    BenefitTier,
    Prerequisite,
    ServiceProviderItem,
    Coverage,
)
from app.schemas.accumulator_response import (
    AccumulatorResponse,
    ReadAccumulatorsResponse,
    Memberships,
    Member,
    MembershipIdentifier,
)
from app.models.selected_benefit import SelectedBenefit, SelectedCoverage
from app.core.base import InsuranceContext
import json
from pathlib import Path


def _build_min_request() -> CostEstimatorRequest:
    service = Service(
        code="99214",
        type="CPT4",
        description="Office visit",
        supportingService=SupportingService(code="", type=""),
        modifier=Modifier(modifierCode=""),
        diagnosisCode="Z00.00",
        placeOfService=PlaceOfService(code="11"),
    )

    provider = ProviderInfo(
        serviceLocation="001",
        providerType="Physician",
        speciality=Speciality(code=""),
        taxIdentificationNumber="123456789",
        taxIdQualifier="TIN",
        providerNetworks=ProviderNetworks(networkID="NET1"),
        providerIdentificationNumber="PRV123",
        nationalProviderId="1111111111",
        providerNetworkParticipation=ProviderNetworkParticipation(providerTier="Tier1"),
    )

    return CostEstimatorRequest(
        membershipId="MEM1",
        zipCode="02115",
        benefitProductType="Commercial",
        languageCode="EN",
        service=service,
        providerInfo=[provider],
    )


def _build_benefit_api_response() -> BenefitApiResponse:
    service_info_item = ServiceInfoItem(
        serviceCodeInfo=[ServiceCodeInfoItem(code="99214", type="CPT4")],
        placeOfService=[PlaceOfServiceItem(code="11")],
        providerType=[ProviderTypeItem(code="Physician")],
        providerSpecialty=[ProviderSpecialtyItem(code="")],
        benefit=[
            Benefit(
                benefitName="Office Visit",
                benefitCode=1001,
                isInitialBenefit="N",
                benefitTier=BenefitTier(benefitTierName="Tier1"),
                networkCategory="InNetwork",
                prerequisites=[Prerequisite()],
                benefitProvider="GEN",
                serviceProvider=[ServiceProviderItem()],
                coverages=[
                    Coverage(
                        sequenceNumber=1,
                        benefitDescription="Office visit",
                        costShareCopay=20.0,
                        costShareCoinsurance=0.0,
                        copayAppliesOutOfPocket="Y",
                        coinsAppliesOutOfPocket="N",
                        deductibleAppliesOutOfPocket="N",
                        deductibleAppliesOutOfPocketOtherIndicator="N",
                        copayCountToDeductibleIndicator="N",
                        copayContinueWhenDeductibleMetIndicator="N",
                        copayContinueWhenOutOfPocketMaxMetIndicator="N",
                        coinsuranceToOutOfPocketOtherIndicator="N",
                        copayToOutofPocketOtherIndicator="N",
                        isDeductibleBeforeCopay="N",
                        benefitLimitation="N",
                        isServiceCovered="Y",
                        relatedAccumulators=[],
                    )
                ],
            )
        ],
    )
    return BenefitApiResponse(serviceInfo=[service_info_item])


def _build_selected_benefit() -> SelectedBenefit:
    coverage = SelectedCoverage(
        sequenceNumber=1,
        benefitDescription="Office visit",
        costShareCopay=20.0,
        costShareCoinsurance=0.0,
        copayAppliesOutOfPocket="Y",
        coinsAppliesOutOfPocket="N",
        deductibleAppliesOutOfPocket="N",
        deductibleAppliesOutOfPocketOtherIndicator="N",
        copayCountToDeductibleIndicator="N",
        copayContinueWhenDeductibleMetIndicator="N",
        copayContinueWhenOutOfPocketMaxMetIndicator="N",
        coinsuranceToOutOfPocketOtherIndicator="N",
        copayToOutofPocketOtherIndicator="N",
        isDeductibleBeforeCopay="N",
        benefitLimitation="N",
        isServiceCovered="Y",
        matchedAccumulators=[],
    )
    return SelectedBenefit(
        benefitName="Office Visit",
        benefitCode=1001,
        isInitialBenefit="N",
        benefitTier=BenefitTier(benefitTierName="Tier1"),
        networkCategory="InNetwork",
        prerequisites=[Prerequisite()],
        benefitProvider="GEN",
        serviceProvider=[ServiceProviderItem()],
        coverage=coverage,
    )


def _build_min_accumulator_response() -> AccumulatorResponse:
    subscriber = Member(
        privacyRestriction="N",
        membershipIdentifier=MembershipIdentifier(
            idSource="HSQ", idValue="MEM1", idType="MBR", resourceId="MEM1"
        ),
        Status="Active",
        accumulators=[],
    )
    memberships = Memberships(subscriber=subscriber, dependents=[])
    return AccumulatorResponse(
        readAccumulatorsResponse=ReadAccumulatorsResponse(memberships=memberships)
    )


@pytest.mark.asyncio
async def test_estimate_cost_with_mocks():
    # Arrange: request
    request = _build_min_request()

    # Arrange: mocks
    repo_mock = Mock()
    # get_rate called once for one provider
    repo_mock.get_rate = AsyncMock(
        return_value=NegotiatedRate(
            paymentMethod="AMT",
            rate=120.0,
            rateType="AMOUNT",
            isRateFound=True,
            isProviderInfoFound=True,
        )
    )
    repo_mock.get_cached_pcp_specialty_codes = Mock(return_value=[])

    benefit_mock = Mock()
    benefit_mock.get_benefit = AsyncMock(return_value=_build_benefit_api_response())

    accumulator_mock = Mock()
    accumulator_mock.get_accumulator = AsyncMock(
        return_value=_build_min_accumulator_response()
    )

    matcher_mock = Mock()
    matcher_mock.get_selected_benefits = Mock(return_value=[_build_selected_benefit()])

    calc_context = InsuranceContext()
    calc_context.member_pays = 30.0
    calc_context.amount_copay = 20.0
    calc_context.amount_coinsurance = 10.0

    calculation_mock = Mock()
    calculation_mock.find_highest_member_pay = Mock(return_value=calc_context)

    service = CostEstimationServiceImpl(
        repository=repo_mock,
        matcher_service=matcher_mock,
        benefit_service=benefit_mock,
        accumulator_service=accumulator_mock,
        calculation_service=calculation_mock,
    )

    # Act
    response = await service.estimate_cost(request)

    # Assert: structure
    assert response is not None
    info_list = response.costEstimateResponse.costEstimateResponseInfo
    assert len(info_list) == 1

    info = info_list[0]
    # Verify key fields from mocks flow through
    assert info.cost.inNetworkCosts == 120.0
    assert info.coverage.costShareCopay == 20.0
    assert info.healthClaimLine.amountResponsibility == pytest.approx(30.0)
    assert info.healthClaimLine.amountpayable == pytest.approx(90.0)


@pytest.mark.asyncio
async def test_estimate_cost_with_json_fixtures():
    base_dir = Path(__file__).parent.parent / "mock-data" / "mock-api-test-data" / "oop_max" / "scenario_3_1_no_oopmax_applies"

    # Load JSON fixtures
    cost_request_data = json.loads((base_dir / "cost_request.json").read_text())
    benefit_response_data = json.loads((base_dir / "benefit_response.json").read_text())
    accumulator_response_data = json.loads((base_dir / "accumulator_response.json").read_text())

    # Build models from fixtures
    request = CostEstimatorRequest(**cost_request_data)
    benefit_api_response = BenefitApiResponse(**benefit_response_data)
    accumulator_response = AccumulatorResponse(**accumulator_response_data)

    # Mocks
    repo_mock = Mock()
    repo_mock.get_rate = AsyncMock(
        return_value=NegotiatedRate(
            paymentMethod="AMT",
            rate=900.0,
            rateType="AMOUNT",
            isRateFound=True,
            isProviderInfoFound=True,
        )
    )
    repo_mock.get_cached_pcp_specialty_codes = Mock(return_value=[])

    benefit_mock = Mock()
    benefit_mock.get_benefit = AsyncMock(return_value=benefit_api_response)

    accumulator_mock = Mock()
    accumulator_mock.get_accumulator = AsyncMock(return_value=accumulator_response)

    # Use real matcher to exercise accumulator matching with fixture data
    from app.services.impl.benefit_accumulator_matcher_service_impl import (
        BenefitAccumulatorMatcherServiceImpl,
    )
    matcher_real = BenefitAccumulatorMatcherServiceImpl()

    # Stub calculation to a deterministic context consistent with fixtures
    calc_context = InsuranceContext()
    calc_context.member_pays = 260.0  # arbitrary deterministic example
    calc_context.amount_copay = 100.0
    calc_context.amount_coinsurance = 160.0
    # Ensure remaining values align with build_accumulator logic
    calc_context.deductible_individual_calculated = 500.0
    calc_context.deductible_family_calculated = 1500.0

    calculation_mock = Mock()
    calculation_mock.find_highest_member_pay = Mock(return_value=calc_context)

    service = CostEstimationServiceImpl(
        repository=repo_mock,
        matcher_service=matcher_real,
        benefit_service=benefit_mock,
        accumulator_service=accumulator_mock,
        calculation_service=calculation_mock,
    )

    # Act
    response = await service.estimate_cost(request)

    # Assert minimal shape and key values from fixtures
    assert response.costEstimateResponse.service.code == cost_request_data["service"]["code"]
    info_list = response.costEstimateResponse.costEstimateResponseInfo
    assert len(info_list) == 1

    info = info_list[0]
    # Scenario 3.1: No OOPMAX Applies (Family AND Individual)
    # Assert applicable (non-N/A) fields only
    assert info.coverage.isServiceCovered == "Y"
    assert info.coverage.costShareCopay == 100.0
    assert info.coverage.costShareCoinsurance == 20
    assert info.cost.inNetworkCosts == 900.0
    # assert info.healthClaimLine.amountCopay == pytest.approx(100.0)
    # assert info.healthClaimLine.amountCoinsurance == pytest.approx(160.0)
    # # in our model, amountpayable = rate - member_pays
    # assert info.healthClaimLine.amountpayable == pytest.approx(900.0 - 260.0)
    # Accumulators present and mapped
    assert len(info.accumulators) >= 2
    codes = {(a.accumulator.code, a.accumulator.level) for a in info.accumulators}
    assert ("Deductible", "Individual") in codes
    assert ("Deductible", "Family") in codes
    # No Limit accumulator expected for this scenario
    assert all(a.accumulator.code.lower() != "limit" for a in info.accumulators)
    # Verify deductible remaining values (DI=500, DF=1500) in an easy-to-read way
    ind_remaining = None
    fam_remaining = None
    for a in info.accumulators:
        code = a.accumulator.code.lower()
        level = a.accumulator.level.lower()
        if code == "deductible" and level == "individual":
            ind_remaining = a.accumulatorCalculation.remainingValue
        elif code == "deductible" and level == "family":
            fam_remaining = a.accumulatorCalculation.remainingValue

    assert ind_remaining is not None, "Deductible (Individual) not found in accumulators"
    assert fam_remaining is not None, "Deductible (Family) not found in accumulators"
    assert ind_remaining == 500.0
    assert fam_remaining == 1500.0
