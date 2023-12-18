from constants import LINK_PHONE_MANUFACTURE, TYPE_ID
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
import os
import random
import shutil
import urllib.request
from bs4 import BeautifulSoup
import pandas as pd

from format import FormatPrice, randomCost, FormatDiscount, random_date, formatInfo

s = Service('.\\chrome\\chromedriver.exe')


def clearFolderImage():
    # remove folder image current
    dirpath = os.path.join(os.getcwd(), 'images')
    if os.path.exists(dirpath) and os.path.isdir(dirpath):
        shutil.rmtree(dirpath)

    # create folder
    os.mkdir(os.path.join(os.getcwd(), 'images'))
    open('sql.txt', 'w').close()


def writeLine(f, data='\n'):
    f.write(data)
    if data != '\n':
        f.write(';\n')


def writefile(sql1, sql2):
    with open('sql.txt', 'a', encoding='utf-8') as f:
        writeLine(f, sql1)
        writeLine(f, sql2)
        writeLine(f)


clearFolderImage()
productId = 0
for key, value in LINK_PHONE_MANUFACTURE.items():
    # get all image title product

    url = 'https://www.thegioididong.com/' + value
    print(f'\nLoading page {url}')
    driver = webdriver.Chrome(service=s)
    driver.get(url)
    print('Loading page done!')
    page_source = BeautifulSoup(driver.page_source, "html.parser")
    url_detail_phones = page_source.find_all('a', attrs={'class': 'main-contain'})
    for url_detail_phone in url_detail_phones:
        url_detail = url_detail_phone.get('href')
        image_link = url_detail_phone.find('div', attrs={'class': 'item-img'})
        image_link = image_link.find('img').get('src') or image_link.find('img').get('data-src')
        image_link = (image_link.replace(' ', '%20').replace('ă', '%C4%83')
                      .replace('đ', '%C4%91'))

        driver.get('https://www.thegioididong.com' + url_detail)
        page_source = BeautifulSoup(driver.page_source, "html.parser")

        # get data
        typeId = int(TYPE_ID[key])

        # get image
        try:
            # giao dien cu cua tgdd
            name = page_source.find('section', attrs={'class': 'detail'}).find('h1').get_text()
            price = page_source.find('p', attrs={'class': 'box-price-old'}).get_text()
            discount = page_source.find('p', attrs={'class': 'box-price-percent'}).get_text()

            # detail product
            detail = page_source.find('ul', attrs={'class': 'parameter__list'}).find_all('li')
            screen = formatInfo(detail[0].get_text())
            _os = detail[1].find('span').get_text()
            cameraBehind = detail[2].find('span').get_text()
            cameraFront = detail[3].find('span').get_text()
            cpu = detail[4].find('span').get_text()
            ram = detail[5].find('span').get_text()
            rom = detail[6].find('span').get_text()
            battery = detail[8].find('span').get_text()
            sim = detail[7].find('span').get_text()
            ### save image

            sample_string = 'qwertyuiopasdfghj'
            random_name = ''.join((random.choice(sample_string)) for _ in range(len(sample_string)))
            img_name = f"images\\img_{random_name}.png"
            path_to_save = os.path.join(os.getcwd(), img_name)
            urllib.request.urlretrieve(image_link, path_to_save)
            # save price
            price = FormatPrice(price)
            cost = randomCost(price)
            discount = FormatDiscount(discount, price, cost)
            rate = random.randint(0, 5)
            releaseDate = random_date("2019/1/1 1:30 PM", "2023/1/1 4:50 AM", random.random())
            total = random.randint(50, 200)
            # detail product
            productId += 1
            strSqlProduct = (f"INSERT INTO \"Product\" (\"productId\",\"total\",\"typeId\",\"image\",\"cost\","
                             f"\"price\",\"discount\",\"rate\",\"releaseDate\",\"name\") VALUES ({productId}, {total}, {typeId},'{img_name}',{cost},{price},{discount},{rate},'{releaseDate}', N'{name}')")
            strSqlProductDetail = (f"INSERT INTO \"ProductDetail\" (\"productId\",\"screen\",\"os\",\"cameraBehind\","
                                   f"\"cameraFront\",\"cpu\",\"ram\",\"rom\",\"battery\",\"sim\") VALUES ({productId},N'{screen}',N'{_os}',N'{cameraBehind}',N'{cameraFront}',N'{cpu}', N'{ram}',N'{rom}',N'{battery}',N'{sim}')")
            writefile(strSqlProduct, strSqlProductDetail)
        except:
            # giao dien moi
            pass

print('DONE!')