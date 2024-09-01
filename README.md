url_value.txt = list of urls files on cloud storages or others url files

download.log = log of activity donwload

**BEFORE  RUN**
```
sudo chmod +x download-files-with-try-attemp.sh
```


**HOW TO RUN**
```
./download-files-with-try-attemp.sh
```


**example log**
```
START Download Log - Min 01 Sep 2024 11:04:33 WIB
=========================
1. Downloaded: files/present/report3e1846.pdf
2. retry 1 to download: https://storage.googleapis.com/files/report92a5ffd2.pdf
2. Downloaded: files/laporan-akhir-penelitian/presentasi/04 laporan_akhir__92a5ffd2.pdf
=========================
FINISH Download - Min 01 Sep 2024 11:02:34 WIB
Elapsed Time (using $SECONDS): 1275 seconds
21 minutes and 15 seconds elapsed.
0 Hours elapsed.

```

**example url_value.txt**
```
https://storage.googleapis.com/files/presents/Tam-748323.pptx
https://storage.googleapis.com/files/presents/Tug-ac4f.pptx
https://storage.googleapis.com/files/presents/Usr-sd6ad45.pptx

```
