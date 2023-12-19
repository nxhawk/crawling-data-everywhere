import json
import os
import random

from fieldName import DISH_TYPE_NAME

index = 0


def writeLine(f, data='\n'):
    f.write(data)
    if data != '\n':
        f.write(';\n')


def writefile(sql: str, idx: int):
    with open(f'sql/sql{idx}.txt', 'a', encoding='utf-8') as f:
        writeLine(f, sql)
    with open(f'sql/sql.txt', 'a', encoding='utf-8') as f:
        writeLine(f, sql)


def customPrice(price, _type: str):
    # dont need in menu
    if price <= 20000 and _type != 'Đồ uống':
        return [-1, -1, -1, -1]

    # cost < price
    price = random.randint(25, 35) * 1000
    cost = random.randint(10, 30) * 1000
    if _type == 'Đồ uống':
        price = random.randint(15, 30) * 1000
        cost = random.randint(10, 20) * 1000
    discount = 0
    if random.randint(1, 10) % 2 != 0:
        discount = random.randint(5, 50)

    if cost >= price:
        cost = price - 1
    while roundedPrice(price * (100 - discount) // 100) <= cost:
        discount -= 1
    salePrice = roundedPrice(price * (100 - discount) // 100)

    return [cost, price, salePrice, discount]


def roundedPrice(price: int):
    abc = price % 1000
    if abc >= 500:
        return price // 1000 * 1000 + 1000
    return price // 1000 * 1000


def readDataFromFile(filename: str, idx: int):
    global index
    with open(f"data/{filename}", encoding='utf-8') as f:
        data = json.load(f)
    data = data['reply']['menu_infos']
    for dish_type in data:
        if dish_type['dish_type_name'] in list(DISH_TYPE_NAME.keys()):
            dishes = dish_type['dishes']
            _type = DISH_TYPE_NAME[dish_type['dish_type_name']]
            for dish in dishes:
                image = dish["photos"][3]["value"]
                if image == ('https://images.foody.vn/res/g64/638675/s570x570/778326de-464e-4a25-a331-fae38458'
                             '-1c5ac644-221110152241.jpeg'):
                    continue
                if image == 'https://images.foody.vn/default/s560x560/shopeefood-deli-dish-no-image.png':
                    continue

                name = dish["name"]
                quantity = random.randint(100, 300)
                [cost, price, salePrice, discount] = customPrice(int(dish["price"]["value"]), _type)
                if price == -1:
                    continue

                index += 1
                strSql = (f"INSERT INTO \"Item\"(\"ID_item\",\"Name\",\"Price\",\"Discount\",\"Quantity\","
                          f"\"Saleprice\",\"Cost\",\"Image\",\"Type\") VALUES ('{index}',N'{name}',{price},"
                          f"{discount},{quantity},{salePrice},{cost},'{image}',N'{_type}')")

                writefile(strSql, idx)


def run():
    files = os.listdir('data')
    open(f'sql/sql.txt', 'w').close()

    for idx, file in enumerate(files):
        open(f'sql/sql{idx + 1}.txt', 'w').close()
        readDataFromFile(file, idx + 1)


if __name__ == "__main__":
    run()
