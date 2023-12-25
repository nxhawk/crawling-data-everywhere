import random

from vn_fullname_generator import generator
import json

from helpers.fetchProduct import fetchAPI
from helpers.randomDate import random_date_time, random_time_add_to_cart
from helpers.randomEmail import randomEmail
from helpers.randomPassword import get_random_password, random_string
from helpers.randomPhoneNumber import randomPhoneNumber

listAddress = []
sql_customer = []
sql_order = []
sql_order_detail = []
listProduct = []
orderId = 0


def randomAddress():
    global listAddress
    with open('data/xa_phuong.json', encoding='utf-8') as fh:
        data = json.load(fh)

    for address in data:
        listAddress.append(data[address]['path_with_type'])


def fake_order(userId: int, name: str, phoneNumber: str):
    global listAddress, listProduct, orderId, sql_order, sql_order_detail
    address = listAddress[random.randint(0, len(listAddress) - 1)].replace('\'', '')
    for _ in range(random.randint(1, 4)):
        orderId += 1
        isPayment = 'true' if random.randint(0, 10) % 2 == 0 else 'false'
        status = 'None'
        timeOrder = random_date_time("2019/1/1 1:30 PM", "2023/12/30 4:50 AM", random.random())
        totalCost = 0
        listIdProduct = []

        # fake order detail
        for _ in range(random.randint(2, 5)):
            index_product = random.randint(0, len(listProduct) - 1)
            productId = int(listProduct[index_product]['productId'])
            while productId in listIdProduct:
                index_product = random.randint(0, len(listProduct) - 1)
                productId = int(listProduct[index_product]['productId'])
            listIdProduct.append(productId)
            quantity = random.randint(1, 4)
            totalCost += int(listProduct[index_product]['giagiam']) * quantity
            timeAddToCart = random_time_add_to_cart(timeOrder, random.random())
            sqlDetail = (
                f'INSERT INTO "OrderDetail"("orderId","productId","timeAddToCart","quantity") VALUES ({orderId},'
                f'{productId},\'{timeAddToCart}\',{quantity});')
            sql_order_detail.append(sqlDetail)

        sqlCustom = (f'INSERT INTO "Order"("orderId","userId","address","reciverName","phoneNumber","totalCost",'
                     f'"isPayment","status","timeOrder") VALUES({orderId},{userId},\'{address}\','
                     f'\'{name}\',\'{phoneNumber}\',{totalCost},{isPayment},\'{status}\',\'{timeOrder}\');')
        sql_order.append(sqlCustom)


def writeFile():
    with open('sql/sql.txt', 'w', encoding='utf-8') as f:
        for customer in sql_customer:
            f.write(customer)
            f.write('\n')
        f.write('\n')

        for order in sql_order:
            f.write(order)
            f.write('\n')
        f.write('\n')

        for order_detail in sql_order_detail:
            f.write(order_detail)
            f.write('\n')
        f.write('\n')


def run(num: int):
    global listProduct
    randomAddress()
    listProduct = fetchAPI('http://localhost:3001/product/all')
    for userId in range(1, num + 1):
        gender = random.randint(0, 1)
        name = generator.generate(gender)
        phoneNumber = randomPhoneNumber()
        email = randomEmail(name)
        password = get_random_password()
        avatar = f'https://robohash.org/{random_string(30)}.png?set=set4'
        gender = 'true' if gender else 'false'
        sqlCustom = (f'INSERT INTO "User"("userId","name","phoneNumber","email","password","avatar","gender","active") '
                     f'VALUES({userId},\'{name}\',\'{phoneNumber}\',\'{email}\',\'{password}\',\'{avatar}\','
                     f'{gender},true);')
        sql_customer.append(sqlCustom)

        # fake data order for this customer
        fake_order(userId, name, phoneNumber)
    writeFile()


if __name__ == '__main__':
    run(100)
