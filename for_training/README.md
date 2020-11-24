## 從Google API的Open Images上下載已完成框選的圖片資料
1. 進入Open Images Dataset V6 (https://storage.googleapis.com/openimages/web/download.html)
2. 下載Boxes的Train (https://storage.googleapis.com/openimages/v6/oidv6-train-annotations-bbox.csv)
3. 下載Metadata的Class Names (https://storage.googleapis.com/openimages/v5/class-descriptions-boxable.csv)
4. pip install awscli
5. 把.py檔和下載下來的csv檔放到一個新的資料夾
6. 更改getDataFromOpenImages.py裡面要下載的類別名稱
7. 執行getDataFromOpenImages.py

## 拆分訓練圖片和驗證圖片
1. 執行splitTrainAndValid.py  
   `python splitTrainAndValid.py DIR_NAME`  
   或直接  
   `python splitTrainAndValid.py`
