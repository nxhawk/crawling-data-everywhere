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
