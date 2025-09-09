
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

    
    # Scenario 1: N-N with different service_grouping_priority_nbr
    payment_methods_1 = [
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 1, "rate": 150.00},
        {"payment_method_cd": "PERBIL", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 2, "rate": 120.00},
        {"payment_method_cd": "PERCNT", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 1, "rate": 130.00},
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 3, "rate": 110.00}
    ]
    result1 = await repo._select_payment_method(payment_methods_1)
    assert result1["payment_method_cd"] == "FIXED"
    assert result1["rate"] == 110.00
    assert result1["service_group_changed_ind"] == "N"
    assert result1["service_grouping_priority_nbr"] == 3

    # Scenario 2: N-N with same service_grouping_priority_nbr but different rate
    payment_methods_2 = [
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 1, "rate": 150.00},
        {"payment_method_cd": "PERBIL", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 2, "rate": 120.00},
        {"payment_method_cd": "PERCNT", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 1, "rate": 130.00},
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 1, "rate": 110.00}
    ]
    result2 = await repo._select_payment_method(payment_methods_2)
    assert result2["payment_method_cd"] == "FIXED"
    assert result2["rate"] == 150.00
    assert result2["service_group_changed_ind"] == "N"
    assert result2["service_grouping_priority_nbr"] == 1
    
    # Scenario 3: Y-Y with different rate
    payment_methods_3 = [
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 4, "rate": 100.00},
        {"payment_method_cd": "PERBIL", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 5, "rate": 110.00},
        {"payment_method_cd": "PERCNT", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 1, "rate": 120.00},
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 2, "rate": 130.00}
    ]
    result3 = await repo._select_payment_method(payment_methods_3)
    assert result3["payment_method_cd"] == "FIXED"
    assert result3["rate"] == 130.00
    assert result3["service_group_changed_ind"] == "Y"
    assert result3["service_grouping_priority_nbr"] == 2

    # Scenario 4: Y-N
    payment_methods_4 = [
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 3, "rate": 140.00},
        {"payment_method_cd": "PERBIL", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 2, "rate": 150.00},
        {"payment_method_cd": "PERCNT", "service_group_changed_ind": "Y", "service_grouping_priority_nbr": 1, "rate": 160.00},
        {"payment_method_cd": "FIXED", "service_group_changed_ind": "N", "service_grouping_priority_nbr": 4, "rate": 170.00}
    ]
    result4 = await repo._select_payment_method(payment_methods_4)
    assert result4["payment_method_cd"] == "FIXED"
    assert result4["rate"] == 140.00
    assert result4["service_group_changed_ind"] == "Y"
    assert result4["service_grouping_priority_nbr"] == 3
