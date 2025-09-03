Message for Kiran:
I'm currently working on the story that we discussed earlier. I have written the complete logic (code). The only work left is testing for which I need to prepare payloads, but I'm finding it difficult to query and search for such data.
I want such rows from CET_RATES that have multiple payment methods and each payment method has the same score in the payment_heirarchy table.
After this, I want to test scenarios like:

Scenario - 1:
service_type_change_ind
Y - pick this
Y - pick this
Y - pick this
Y - pick this
N
N
N

Scenario-2:
service_type_change_ind  service_type_priority_nbr
N                                       200 - pick this
N                                       200 - pick this
N                                       200 - pick this
N                                       200 - pick this

Scenario - 3
service_type_change_ind 
Y - pick this
N

Scenario - 4
service_type_change_ind
N - pick this
