# Crawling phone data from thegioididong.com

## Set up

`Bước 1:` Clone this repository
```bash
git clone https://github.com/nxhawk/crawling-data-thegioididong.git
```

`Bước 2:` Mở thư mục cùng cấp với file `main.py`

`Bước 3:` Cài đặt thư viện cần thiết, với lệnh sau:
```bash
pip install -r requirements.txt
```

## Run
```bash
python main.py
```

## Result
Sau khi chạy chương trình sẽ tạo ra một thư mục mới là `images` thư mục này sẽ chứa tất cả hình ảnh của điện thoại (được phân theo loại), và một file `data.xlsx` sẽ chứa thông tin cần thiết của tất cả điện thoại trên.
