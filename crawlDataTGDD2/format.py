import random
import time


def FormatPrice(price: str) -> str:
    price = price.replace('.', '').replace('₫', '').replace(' ', '')
    return price


def randomCost(price: str) -> str:
    price = int(price)

    if price <= 4000000:
        price -= price // 3
    else:
        price -= random.randint(1, 4) * 1000000
    return str(price)


def FormatDiscount(discount: str, price: str, cost: str) -> int:
    price = int(price)
    cost = int(cost)

    discount = discount.replace('%', '').replace('-', '')
    discount = int(discount)
    while price * (100 - discount) / 100 < cost:
        discount -= 1
    return discount


def str_time_prop(start, end, time_format, prop):
    stime = time.mktime(time.strptime(start, time_format))
    etime = time.mktime(time.strptime(end, time_format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(time_format, time.localtime(ptime))


def random_date(start, end, prop):
    date_time = str_time_prop(start, end, '%Y/%m/%d %I:%M %p', prop)
    return date_time.split(" ")[0].replace('/', '-')


def formatInfo(info: str) -> str:
    info = info.replace('\n', ', ').strip().replace(', , ', '').replace(', Màn hình:', '').replace(', ,', '')
    return info
