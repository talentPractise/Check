def find_max_score_value( result):
    max_score = None
    for row in result:
        pbg_score = row["pbg_score"]
        if pbg_score is None:
            continue
        if max_score is None:
            max_score = pbg_score
        else:
            max_score = max(max_score, pbg_score)
    return max_score
        
def get_pbg_with_highest_pbg_score(result):
    max_score_value = find_max_score_value(result)
    if max_score_value is None:
        return result
    filtered = [row for row in data if row["pbg_score"]==max_score_value]
    return filtered

data = [
    # Group 1: pin=5465454
    {"pin": 5465454, "network_id": 454545, "pbg_location": 545645, "pbg_number": 65465454, "pbg_score": 54},
    {"pin": 5465454, "network_id": 454545, "pbg_location": 545645, "pbg_number": 76576576, "pbg_score": 62},
    {"pin": 5465454, "network_id": 454545, "pbg_location": 545645, "pbg_number": 87878787, "pbg_score": 48},
    # Group 2: pin=1111111
    {"pin": 1111111, "network_id": 222222, "pbg_location": 333333, "pbg_number": 44444444, "pbg_score": 72},
    {"pin": 1111111, "network_id": 222222, "pbg_location": 333333, "pbg_number": 55555555, "pbg_score": 68},
    {"pin": 1111111, "network_id": 222222, "pbg_location": 333333, "pbg_number": 66666666, "pbg_score": 72},  # tie
    # Group 3: pin=2222222
    {"pin": 2222222, "network_id": 333333, "pbg_location": 444444, "pbg_number": 77777777, "pbg_score": None},
    {"pin": 2222222, "network_id": 333333, "pbg_location": 444444, "pbg_number": 88888888, "pbg_score": None},  # highest
    {"pin": 2222222, "network_id": 333333, "pbg_location": 444444, "pbg_number": 99999999, "pbg_score": None},
]
 
 
# Example: find best for pin=2222222
pin = 2222222
network_id = 333333
pbg_location = 444444
 
filtered = [
    obj for obj in data
    if obj["pin"] == pin and obj["network_id"] == network_id and obj["pbg_location"] == pbg_location
]
 
pbg = get_pbg_with_highest_pbg_score(filtered)
print(pbg)
