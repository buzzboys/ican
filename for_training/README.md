# 從Google API的Open Images上下載已完成框選的圖片資料
1. 進入Open Images Dataset V6 (https://storage.googleapis.com/openimages/web/download.html)
2. 下載Boxes的Train (https://storage.googleapis.com/openimages/v6/oidv6-train-annotations-bbox.csv)
3. 下載Metadata的Class Names (https://storage.googleapis.com/openimages/v5/class-descriptions-boxable.csv)
4. pip install aswcli
5. 執行getDataFromOpenImages.py
