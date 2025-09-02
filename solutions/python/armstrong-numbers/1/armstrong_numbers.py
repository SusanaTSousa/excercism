def is_armstrong_number(number):
    list_numbers = list(map(int, str(number)))
    res = 0
    for n in list_numbers:
        res += n ** len(list_numbers)
    return res == number