# conta punti nel poligono (LZ50)

dataset: db sqlite con spatialidex

<!-- TOC -->

- [conta punti nel poligono (LZ50)](#conta-punti-nel-poligono-lz50)
    - [QGIS 2.18.24](#qgis-21824)
    - [QGIS 3.2.3](#qgis-323)
    - [QGIS 3.3 master](#qgis-33-master)
    - [SpatiaLite_GUI 2.10](#spatialitegui-210)
    - [PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3](#postgresql-93--postgis-223--pgadmin-3)
    - [mapshaper](#mapshaper)
    - [R + RStudio](#r--rstudio)
    - [RISULTATI (LZ50) - conta punti nel poligono](#risultati-lz50---conta-punti-nel-poligono)
    - [RISULTATI (xxx) - estrai vertici](#risultati-xxx---estrai-vertici)

<!-- /TOC -->

## QGIS 2.18.24

![](../img/qgis21824_info.png)

![](../img/conta_punti_poligono/qgis21824_01.png)

![](../img/conta_punti_poligono/qgis21824_02.png)

![](../img/conta_punti_poligono/conteggio21824.png)

## QGIS 3.2.3

![](../img/qgis323_info.png)

![](../img/conta_punti_poligono/qgis323_01.png)

![](../img/conta_punti_poligono/qgis323_02.png)

## QGIS 3.3 master

![](../img/qgis33_master_info.png)

NB: Il debug rallenta le prestazioni!!!

![](../img/conta_punti_poligono/qgis33master_01.png)

![](../img/conta_punti_poligono/qgis33master_02.png)

![](../img/conta_punti_poligono/conteggio33master.png)

## SpatiaLite_GUI 2.10

estraggo i vertici:

![](../img/spatialite_gui_210_info.png)

```
-- Creo tabella 
```
![](../img/conta_punti_poligono/spatialite_gui_210_01.png)

## PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3

![](../img/pgAmin3_info.png)

```
-- crea tabella
```
![](../img/conta_punti_poligono/pgAmin3_01.png)

## mapshaper

```
time node  --max-old-space-size=4192 `which mapshaper` encoding=utf-8 dissolto_reg_b1m.shp -join vertix.shp calc='join_count = count()' fields= -o out_count_reg.shp
```

![](../img/conta_punti_poligono/mapshaper_01.png)

## R + RStudio

Osservazione: occorrono circa 7 minuti per caricare i dati in memoria !!!

```
library(rgdal)
library(GISTools)
setwd("C:\\Users\\Salvatore\\Desktop\\mapshaper")
start.time <- Sys.time()
punti<-readOGR("vertici_ok.shp")
reticolo<-readOGR("dissolto_reg_b1m.shp")
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
#### calcolo conteggio con misura tempo esecuzione #######
start.time <- Sys.time()
conteggio<-poly.counts(punti, reticolo)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
conteggio
```

![](../img/conta_punti_poligono/r_01.png)

PS: non è comprensibile l'output!!!

## RISULTATI (LZ50) - conta punti nel poligono

tempo [sec]|programma
:---------:|---------
214|QGIS 2.18.24
272|QGIS 3.2.3
182|QGIS 3.3 master con debug
??|SpatiaLite_GUI 2.10
??|pgAdmin 3 con spatialIndex
303|mapshaper
420 + 35|R + RStudio

## RISULTATI (xxx) - estrai vertici

tempo [sec]|programma
:---------:|---------
sss|QGIS 2.18.24
sss|QGIS 3.2.3
sss|QGIS 3.3 master con debug
sss|SpatiaLite_GUI 2.10
sss|pgAdmin 3 con spatialIndex
sss|mapshaper
sss|R + RStudio
