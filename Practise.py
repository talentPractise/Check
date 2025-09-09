
@pytest.mark.asyncio
@patch("app.repository.impl.cost_estimator_repository_impl.SpannerClient")
@patch("app.repository.impl.cost_estimator_repository_impl.spanner_config")
async def test_get_provider_info(
    mock_config, mock_client_class, sample_rate_criteria
):
    mock_config.is_valid.return_value = True
    mock_client = AsyncMock()

    # Scenario 1: Different PROVIDER_BUSINESS_GROUP_SCORE_NBR values
    mock_client.execute_query.return_value = [
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG001",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 100,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD1",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS1",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA1"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG002",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 200,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD2",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS2",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA2"
        }
    ]
    mock_client_class.return_value = mock_client

    repo = CostEstimatorRepositoryImpl()
    params = {

    }
    result = await repo._get_provider_info(params)
    assert isinstance(result, list)
    assert len(result) == 1
    assert result[0]["PROVIDER_BUSINESS_GROUP_NBR"] == "PBG002"
    assert result[0]["PROVIDER_BUSINESS_GROUP_SCORE_NBR"] == 200


    # Scenario 2: Multiple records share the highest PROVIDER_BUSINESS_GROUP_SCORE_NBR
    mock_client.execute_query.return_value = [
        {       
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG001",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 100,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD1",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS1",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA1"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG002",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 100,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD2",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS2",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA2"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG003",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 200,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD2",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS2",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA2"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG004",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 200,
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
    assert {r["PROVIDER_BUSINESS_GROUP_NBR"] for r in result} == {"PBG003", "PBG004"}
    assert all(r["PROVIDER_BUSINESS_GROUP_SCORE_NBR"] == 200 for r in result)


    # Scenario 3: All have the same PROVIDER_BUSINESS_GROUP_SCORE_NBR
    mock_client.execute_query.return_value = [
        {       
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG001",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 100,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD1",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS1",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA1"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG002",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 100,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD2",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS2",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA2"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG003",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 100,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD2",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS2",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA2"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG004",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": 100,
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
    assert len(result) == 4
    assert {r["PROVIDER_BUSINESS_GROUP_NBR"] for r in result} == {"PBG001", "PBG002", "PBG003", "PBG004"}
    assert all(r["PROVIDER_BUSINESS_GROUP_SCORE_NBR"] == 100 for r in result)




    # Scenario 4: Some records have PROVIDER_BUSINESS_GROUP_SCORE_NBR as None
    mock_client.execute_query.return_value = [
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG001",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": None,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD1",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS1",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA1"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG002",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": None,
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
    assert len(result) == 1
    assert result[0]["PROVIDER_BUSINESS_GROUP_NBR"] == "PBG003"
    assert result[0]["PROVIDER_BUSINESS_GROUP_SCORE_NBR"] == 10


    # Scenario 5:  All records have PROVIDER_BUSINESS_GROUP_SCORE_NBR as None
    mock_client.execute_query.return_value = [
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG001",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": None,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD1",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS1",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA1"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG002",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": None,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD2",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS2",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA2"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG003",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": None,
            "PROVIDER_IDENTIFICATION_NBR": "0004000317",
            "PRODUCT_CD": "PROD2",
            "SERVICE_LOCATION_NBR": "000761071",
            "NETWORK_ID": "58921",
            "RATING_SYSTEM_CD": "RS2",
            "EPDB_GEOGRAPHIC_AREA_CD": "GA2"
        },
        {
            "PROVIDER_BUSINESS_GROUP_NBR": "PBG004",
            "PROVIDER_BUSINESS_GROUP_SCORE_NBR": None,
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
    assert len(result) == 4
    assert {r["PROVIDER_BUSINESS_GROUP_NBR"] for r in result} == {"PBG001", "PBG002", "PBG003", "PBG004"}
    assert all(r["PROVIDER_BUSINESS_GROUP_SCORE_NBR"] is None for r in result)


@pytest.mark.asyncio
@patch("app.repository.impl.cost_estimator_repository_impl.SpannerClient")
@patch("app.repository.impl.cost_estimator_repository_impl.spanner_config")
async def test_select_payment_method(
    mock_config, mock_client_class
):
    mock_config.is_valid.return_value = True
    mock_client = AsyncMock()

    mock_client.execute_query.return_value = [
        {"payment_method_cd": "FIXED", "score": 10},
        {"payment_method_cd": "PERBIL", "score": 8},
        {"payment_method_cd": "PERCNT", "score": 6},
        {"payment_method_cd": "OTHER", "score": 4}
    ]
    mock_client_class.return_value = mock_client
    repo = CostEstimatorRepositoryImpl()
    repo.db = mock_client
    repo._cache = {}

    # Scenario 1: Only one record with service_group_changed_ind = N
    rows_obtained_from_cet_rates = [
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 5, "rate": 80.00}
    ]
    result = await repo._select_payment_method(rows_obtained_from_cet_rates)
    assert result["payment_method_cd"] == "FIXED"
    assert result["rate"] == 80.00
    assert result["service_group_changed_ind"] == "N"
    assert result["service_grouping_priority_nbr"] == 5

    # Scenario 2: Only one record with service_group_changed_ind = Y
    rows_obtained_from_cet_rates = [
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 3, "rate": 90.00}
    ]
    result = await repo._select_payment_method(rows_obtained_from_cet_rates)
    assert result["payment_method_cd"] == "FIXED"
    assert result["rate"] == 90.00
    assert result["service_group_changed_ind"] == "Y"
    assert result["service_grouping_priority_nbr"] == 3


    # Scenario 3: N-N with different service_grouping_priority_nbr
    rows_obtained_from_cet_rates = [
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 1, "rate": 150.00},
        {"payment_method_cd": "PERBIL", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 2, "rate": 120.00},
        {"payment_method_cd": "PERCNT", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 1, "rate": 130.00},
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 3, "rate": 110.00}
    ]
    result = await repo._select_payment_method(rows_obtained_from_cet_rates)
    assert result["payment_method_cd"] == "FIXED"
    assert result["rate"] == 110.00
    assert result["service_group_changed_ind"] == "N"
    assert result["service_grouping_priority_nbr"] == 3

    # Scenario 4: N-N with same service_grouping_priority_nbr but different rate
    rows_obtained_from_cet_rates = [
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 1, "rate": 150.00},
        {"payment_method_cd": "PERBIL", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 2, "rate": 120.00},
        {"payment_method_cd": "PERCNT", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 1, "rate": 130.00},
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 1, "rate": 110.00}
    ]
    result = await repo._select_payment_method(rows_obtained_from_cet_rates)
    assert result["payment_method_cd"] == "FIXED"
    assert result["rate"] == 150.00
    assert result["service_group_changed_ind"] == "N"
    assert result["service_grouping_priority_nbr"] == 1

    # Scenario 5: Y-Y with different rate
    rows_obtained_from_cet_rates = [
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 4, "rate": 100.00},
        {"payment_method_cd": "PERBIL", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 5, "rate": 110.00},
        {"payment_method_cd": "PERCNT", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 1, "rate": 120.00},
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 2, "rate": 130.00}
    ]
    result = await repo._select_payment_method(rows_obtained_from_cet_rates)
    assert result["payment_method_cd"] == "FIXED"
    assert result["rate"] == 130.00
    assert result["service_group_changed_ind"] == "Y"
    assert result["service_grouping_priority_nbr"] == 2

    # Scenario 6: Y-N
    rows_obtained_from_cet_rates = [
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 3, "rate": 140.00},
        {"payment_method_cd": "PERBIL", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 2, "rate": 150.00},
        {"payment_method_cd": "PERCNT", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 1, "rate": 160.00},
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 4, "rate": 170.00}
    ]
    result = await repo._select_payment_method(rows_obtained_from_cet_rates)
    assert result["payment_method_cd"] == "FIXED"
    assert result["rate"] == 140.00
    assert result["service_group_changed_ind"] == "Y"
    assert result["service_grouping_priority_nbr"] == 3





# @pytest.mark.asyncio
# @patch("app.repository.impl.cost_estimator_repository_impl.SpannerClient")
# @patch("app.repository.impl.cost_estimator_repository_impl.spanner_config")
# async def test_get_provider_info_handles_exception(
#     mock_config, mock_client_class, sample_rate_criteria
# ):
#     mock_config.is_valid.return_value = True
#     mock_client = AsyncMock()
#     # Simulate an exception when execute_query is called
#     mock_client.execute_query.side_effect = Exception("Database error")
#     mock_client_class.return_value = mock_client

#     repo = CostEstimatorRepositoryImpl()
#     params = {
#         "provideridentificationnumber": "0004000317",
#         "networkid": "58921",
#         "servicelocationnumber": "000761071"
#     }
#     result = await repo._get_provider_info(params)

#     assert result == []
