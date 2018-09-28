# benchmark
benchmark su due laptop e software GIS diversi 

## Laptop Lenovo Z50 - SO windows 10 64 b (LZ50)

sistema:

* _processore_: AMD FX-7500 Radeon R7, 10 Compute Cores 4C + 6G 2,10 GHz
* _RAM_: 8,00 GB
* _Tipo sistema_: Sistema operativo a 64 bit, processore basato du x64
* _storage_: HDD 


## xxxxxxxxxxxxxxxxx - SO windows 10 64 b (yyy)

sistema:

* _processore_: Intel i7-7700 2,10 GHz
* _RAM_: 16,00 GB
* _Tipo sistema_: Sistema operativo a 64 bit, processore basato du x64
* _storage_: SSD

## dataset

Confini delle unità amministrative a fini statistici al 1 gennaio 2018 -ISTAT - (anno 2018 - [versione non generalizzata](https://www4.istat.it/it/archivio/209722)) cartella Com01012018. NB: gli shapefile dell'ISTAT hanno geometrie non valide, la correzione è stata fatta tramite spatialite_gui - leggere blog post su [pigrecoinfinito](https://pigrecoinfinito.wordpress.com/2018/03/23/gli-shapefile-istat-del-2018-non-sono-validi-ecco-come-correggerli-con-spatialite/)

* [qui](https://mega.nz/#!BApjSCJT!kSPF01S_BPEpK_ErYEx1Jse4XWjV52oA0iS0dgxZU5o) shapefile
* [qui](https://mega.nz/#!gFglWIAC!CmDUmG4FTbEwpd7KixGmf7Zhw7kALru_2eQfzSJpL9c) db sqlite

## software GIS

* QGIS 2.18.24, 3.2.3, 3.3 master
* R 3.5.1 + RStudio 1.1.456 
* SpatiaLite_gui 2.10
* PostgreSQL9.3/PostGIS 2.2.3
* Mapshaper 0.4.94 (riga di comando - GNU/Linux - Ubuntu 16.4 in Win10 64b)

## prove

1. estrai vertici;
2. elimina geometrie duplicate (alludo ai vertici)
3. dissolvi tutto;
4. buffer 1 m;
5. conta punti nel poligono (usando il buffer 1 m - vertici per comune)
6. spatial join (tra vertici e comuni - trasferire nome comune)

## come eseguire le prove

È importante chiudere tutti gli applicativi non interessati alla prova in modo che ogni risorsa sia dedicata ai test.
