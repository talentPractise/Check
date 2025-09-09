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
        {"payment_method_cd": "PERCNT", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 1, "rate": 130.00},
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 1, "rate": 110.00}
    ]
    result = await repo._select_payment_method(rows_obtained_from_cet_rates)
    assert result["payment_method_cd"] == "FIXED"
    assert result["rate"] == 110.00
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
