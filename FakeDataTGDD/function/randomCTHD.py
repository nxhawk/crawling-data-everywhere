import random

from function.randomDate import random_date


def randomCTHD(makh, mahd, listSP):
    sql_insert = []
    trigia = 0
    listMasp = []
    for _ in range(random.randint(1, 4)):
        sl = random.randint(1, 3)
        product = listSP[random.randint(0, len(listSP) - 1)]
        while product['masp'] in listMasp:
            product = listSP[random.randint(0, len(listSP) - 1)]
        masp = product['masp']
        listMasp.append(masp)
        trigia += sl * int(product['gia']) * (100 - int(product['giamgia']))//100

        nghd = random_date("2019/1/1 1:30 PM", "2023/12/1 4:50 AM", random.random())
        sql = f"INSERT INTO `cthd` (`sohd`, `masp`, `sl`) VALUES ({mahd}, '{masp}', {sl})"
        sql_insert.append(sql)

    sql_insert_hd = f"INSERT INTO `hoadon` (`sohd`, `nghd`, `makh`, `trigia`) VALUES({mahd}, '{nghd}', '{makh}', {trigia})"

    return sql_insert, sql_insert_hd

