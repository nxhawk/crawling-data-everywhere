import random


def randomPhoneNumber():
    res = "0"
    res += str(random.randint(1, 9))
    for _ in range(8):
        res += str(random.randint(0, 9))
    return res
