
@pytest.mark.asyncio
@patch("app.repository.impl.cost_estimator_repository_impl.SpannerClient")
@patch("app.repository.impl.cost_estimator_repository_impl.spanner_config")
async def test_get_provider_info_when_multiple_record_with_highest_scores(
    mock_config, mock_client_class, sample_rate_criteria
):
    mock_config.is_valid.return_value = True
    mock_client = AsyncMock()
    mock_client.execute_query.return_value = [
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG001",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 5,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD1",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS1",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA1"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG002",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 10,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD2",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS2",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA2"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG003",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 10,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD2",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS2",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA2"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG004",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 7,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD3",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS3",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA3"
        }
    ]
    mock_client_class.return_value = mock_client

    repo = CostEstimatorRepositoryImpl()
    params = {

    }
    result = await repo._get_provider_info(params)

    assert isinstance(result, list)
    assert len(result) == 2
    assert {r["PROVIDER_BUSINESS_GROUP_NBR"] for r in result} == {"PBG002", "PBG003"}
    assert all(r["PROVIDER_BUSINESS_GROUP_SCORE_NBR"] == 10 for r in result)

