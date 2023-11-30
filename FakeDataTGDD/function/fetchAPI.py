import requests
import json


def fetchAPI(API):
    listMaSP = []
    res = requests.get(API)
    response = json.loads(res.text)
    for product in response['product']:
        listMaSP.append(product)
    return listMaSP
