import requests
import json


def fetchAPI(API):
    res = requests.get(API)
    response = json.loads(res.text)
    return response


if __name__ == '__main__':
    fetchAPI('http://localhost:3001/product/all')
