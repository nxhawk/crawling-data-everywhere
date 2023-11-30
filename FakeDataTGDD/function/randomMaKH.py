import random


def randomMaKH() -> str:
    rng = random.randint(1, 9999)
    if rng < 10:
        return '000' + str(rng)
    if rng < 100:
        return '00' + str(rng)
    if rng < 1000:
        return '0' + str(rng)
    return str(rng)
