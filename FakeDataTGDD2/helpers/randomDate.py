import random
import time


def str_time_prop(start, end, time_format, prop):
    stime = time.mktime(time.strptime(start, time_format))
    etime = time.mktime(time.strptime(end, time_format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(time_format, time.localtime(ptime))


def random_date(start, end, prop):
    date_time = str_time_prop(start, end, '%Y/%m/%d %I:%M %p', prop)
    return date_time.split(" ")[0].replace('/', '-')


def random_date_time(start, end, prop):
    date_time = str_time_prop(start, end, '%Y/%m/%d %I:%M %p', prop)
    return date_time.replace('/', '-').replace(' AM', ':00').replace(' PM', ':00')


def random_time_add_to_cart(timeOrder: str, prop):
    import datetime
    end = timeOrder.split(':')[0] + ":" + timeOrder.split(':')[1] + ' AM'
    d = datetime.date(int(end.split('-')[0]), int(end.split('-')[1]), int(end.split('-')[2].split(' ')[0]))
    start = d - datetime.timedelta(days=random.randint(0, 3))
    start = str(start).replace('-', '/') + ' 01:01 AM'
    return random_date_time(start, end.replace('-', '/'), prop)


if __name__ == '__main__':
    print(random_time_add_to_cart("2020-10-28 02:04:00", random.random()))
