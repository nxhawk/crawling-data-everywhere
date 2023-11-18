import os
import random
import shutil
import urllib.request

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from bs4 import BeautifulSoup
import pandas as pd

from utils.Constrants import LINK_PHONE_MANUFACTURE, TYPE_ID

from utils.Format import FormatPrice, FormatName, FormatDiscount, randomCost

# initial data
link_list = []
names = []
prices = []
discounts = []
types = []
trademarks = []  # Thương hiệu
images = []
driver: webdriver = None
costs = []
manufactures = []
counts = []


def initialData():
    global names, prices, discounts, types, trademarks, images, costs, manufactures, counts, link_list
    names = []
    counts = []
    prices = []
    manufactures = []
    discounts = []
    types = []
    trademarks = []  # Thương hiệu
    images = []
    costs = []
    link_list = []
    clearFolderImage()


def getURL(str_url: str, name_folder: str):
    global driver
    url = 'https://www.thegioididong.com/' + str_url

    print(f'\nLoading page {url}')

    s = Service('.\\chrome\\chromedriver.exe')

    driver = webdriver.Chrome(service=s)
    driver.get(url)
    print('Loading page done!')
    page_source = BeautifulSoup(driver.page_source, "html.parser")
    getPhoneList(page_source, name_folder)


def getPhoneList(page_source, name_folder):
    print(f"Crawling data phone {name_folder}")
    # get link to page detail product
    phone_list = page_source.find_all('li', attrs={'class': 'item', 'data-issetup': '0'})

    # get all image title product
    os.mkdir(os.path.join(os.getcwd(), f'images\\{name_folder}'))

    for phone in phone_list:
        phone_image_str = phone.find_all('div', attrs={'class': 'item-img'})[0]
        phone_image_urls = phone_image_str.find_all('img')

        phone_image_url = phone_image_urls[0].get('src')
        if phone_image_url is None:
            phone_image_url = phone_image_urls[0].get('data-src')

        # random name image
        sample_string = 'qwertyuiopasdfghj'
        random_name = ''.join((random.choice(sample_string)) for _ in range(len(sample_string)))
        img_name = f"images\\{name_folder}\\img_{random_name}.png"

        path_to_save = os.path.join(os.getcwd(), img_name)

        phone_tmp = f"{phone_image_url}"
        phone_tmp = (phone_tmp.replace(' ', '%20').replace('ă', '%C4%83')
                     .replace('đ', '%C4%91'))
        # save image
        urllib.request.urlretrieve(phone_tmp, path_to_save)

        # get name
        name = FormatName(phone.find('h3').get_text().strip())

        # get price
        price = phone.find('p', attrs={'class': 'price-old'})
        price = phone.find('strong', attrs={'class': 'price'}).get_text().strip() if price is None \
            else price.get_text().strip()

        price = FormatPrice(price)
        cost = randomCost(price)

        discount = phone.find('span', attrs={'class': 'percent'})
        discount = '0' if discount is None else discount.get_text().strip()
        discount = FormatDiscount(discount)

        discounts.append(discount)
        prices.append(price)
        costs.append(cost)
        images.append(path_to_save)
        names.append(name)
        counts.append(random.randint(1, 100))
        types.append(TYPE_ID[name_folder])
        if name_folder == 'iPhone':
            manufactures.append('Apple')
        else:
            manufactures.append(name_folder)

    print(f"Crawl data phone {name_folder} success!")
    print('-'*60)


def clearFolderImage():
    # remove folder image current
    dirpath = os.path.join(os.getcwd(), 'images')
    if os.path.exists(dirpath) and os.path.isdir(dirpath):
        shutil.rmtree(dirpath)

    # create folder
    os.mkdir(os.path.join(os.getcwd(), 'images'))


def main():
    global link_list, driver
    for key, value in LINK_PHONE_MANUFACTURE.items():
        getURL(value, key)


def randomMaSP() -> str:
    rng = random.randint(1, 9999)
    if rng < 10:
        return '000' + str(rng)
    if rng < 100:
        return '00' + str(rng)
    if rng < 1000:
        return '0' + str(rng)
    return str(rng)


def writeExcel():
    filename = 'data.xlsx'
    _dict = {'masp': [], 'anh': [], 'tensp': [], 'hangsx': [], 'gia_goc': [], 'gia': [], 'sl': [], 'maloai': [],
             'giamgia': []}

    for i in range(min(len(images), len(names))):
        rng = randomMaSP()
        while rng in _dict['masp']:
            rng = randomMaSP()
        _dict['masp'].append(rng)
        _dict['anh'].append(images[i])
        _dict['tensp'].append(names[i])
        _dict['hangsx'].append(manufactures[i])
        _dict['gia'].append(prices[i])
        _dict['gia_goc'].append(costs[i])
        _dict['sl'].append(counts[i])
        _dict['maloai'].append(types[i])
        _dict['giamgia'].append(discounts[i])

    df = pd.DataFrame(_dict)
    try:
        df.to_excel(filename, sheet_name='Product', index=False)
    except NameError:
        print(NameError)


if __name__ == '__main__':
    initialData()
    main()
    writeExcel()
    print('All good, Crawl all data successfully!!!')
