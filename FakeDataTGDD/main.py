import random

from vn_fullname_generator import generator
import json

from function.fetchAPI import fetchAPI
from function.randomCTHD import randomCTHD
from function.randomEmail import randomEmail
from function.randomMaKH import randomMaKH
from function.randomPhoneNumber import randomPhoneNumber
from function.randomDate import random_date
from function.randomSohd import randomSohd

listMaKH = []
listMaHD = []
listAddress = []
listCTHD = []
listHoaDon = []
sql_customer = []
listSP = fetchAPI('http://localhost:5000/product/getall')


def createKhachHang(num: int):
    randomAddress()
    for _ in range(num):
        hoten = generator.generate(random.randint(0, 1))
        makh = randomMaKH()
        diachi = listAddress[random.randint(0, len(listAddress) - 1)]
        while makh in listMaKH:
            makh = randomMaKH()
        sodt = randomPhoneNumber()
        email = randomEmail(hoten)
        ngsinh = random_date("1980/1/1 1:30 PM", "2005/1/1 4:50 AM", random.random())
        ngdk = random_date("2010/1/1 1:30 PM", "2019/1/1 4:50 AM", random.random())
        listMaKH.append(makh)
        strSQL = (f"INSERT INTO `khachhang` (`makh`, `hoten`, `dchi`, `sodt`, `ngsinh`, `email`, `ngdk`)"
                  f" VALUES ('{makh}', N'{hoten}', N'{diachi}', '{sodt}', '{ngsinh}', '{email}', '{ngdk}')")
        sql_customer.append(strSQL)


def randomAddress():
    global listAddress
    with open('xa_phuong.json', encoding='utf-8') as fh:
        data = json.load(fh)

    for address in data:
        listAddress.append(data[address]['path_with_type'])


def random_Hoa_don():
    for makh in listMaKH:
        sohd = randomSohd()
        while sohd in listMaHD:
            sohd = randomSohd()
        listMaHD.append(sohd)
        sql_insert, sql_insert_hd = randomCTHD(makh, sohd, listSP)
        for x in sql_insert:
            listCTHD.append(x)
        listHoaDon.append(sql_insert_hd)


def writeLine(f, data='\n'):
    f.write(data)
    f.write(';\n')


def writeFile():
    with open('sql.txt', 'w', encoding='utf-8') as f:
        for kh in sql_customer:
            writeLine(f, kh)
        writeLine(f)

        for hd in listHoaDon:
            writeLine(f, hd)
        writeLine(f)

        for cthd in listCTHD:
            writeLine(f, cthd)
        writeLine(f)


if __name__ == '__main__':
    createKhachHang(300)
    random_Hoa_don()
    writeFile()
