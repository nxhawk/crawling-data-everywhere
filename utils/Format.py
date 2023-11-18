import random


def FormatPrice(price: str) -> str:
    price = price.replace('.', '').replace('₫', '').replace(' ', '')
    return price


def FormatName(name: str) -> str:
    for i in range(6, 10):
        gb = str(pow(2, i)) + 'GB'
        name = name.replace(' ' + gb, '')
        name = name.replace(gb, '')
    name = name.replace(' 4G', '').replace(' 5G', '')
    name = name.replace('4G', '').replace('5G', '')
    name = name.replace('1TB', '')
    return name


def FormatDiscount(discount: str) -> str:
    discount = discount.replace('%', '').replace('-', '')
    return discount


def randomCost(price: str) -> str:
    price = int(price)

    if price <= 4000000:
        price -= price // 3
    else:
        price -= random.randint(1, 4) * 1000000
    return str(price)


if __name__ == '__main__':
    print(
        FormatName("Iphone 15 pro max 128GB")
    )
