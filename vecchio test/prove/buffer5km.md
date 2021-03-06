# buffer -5 km (LZ50) RIFARE TUTTO!!!

dataset: db sqlite con spatialindex

<!-- TOC -->

- [buffer -5 km (LZ50) RIFARE TUTTO!!!](#buffer--5-km-lz50-rifare-tutto)
    - [QGIS 2.18.24](#qgis-21824)
    - [QGIS 3.2.3](#qgis-323)
    - [QGIS 3.3 master](#qgis-33-master)
    - [SpatiaLite_GUI 2.10](#spatialitegui-210)
    - [PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3](#postgresql-93--postgis-223--pgadmin-3)
    - [mapshaper](#mapshaper)
    - [R + RStudio](#r--rstudio)
    - [RISULTATI (LZ50) - buffer 1 m](#risultati-lz50---buffer-1-m)

<!-- /TOC -->

## QGIS 2.18.24

![](../img/qgis21824_info.png)

![](../img/buffer5km/qgis21824_01.png)

![](../img/buffer5km/qgis21824_02.png)

## QGIS 3.2.3

![](../img/qgis323_info.png)

![](../img/buffer5km/qgis323_01.png)

![](../img/buffer5km/qgis323_02.png)

## QGIS 3.3 master

![](../img/qgis33_master_info.png)

NB: Il debug rallenta le prestazioni!!!

![](../img/buffer5km/qgis33master_01.png)

![](../img/buffer5km/qgis33master_02.png)

## SpatiaLite_GUI 2.10

estraggo i vertici:

![](../img/spatialite_gui_210_info.png)

```
-- Creo tabella estraendo i vertici
CREATE TABLE "vertici_com" AS
SELECT ST_DissolvePoints(geometry) as geometry from Com01012018_WGS84;
SELECT RecoverGeometryColumn('vertici_com','geometry',32632,'MULTIPOINT','XY');
-- Esplodo i vertici MultiPoint
SELECT ElementaryGeometries( 'vertici_com' ,'geometry' , 'vertici' ,'out_pk' , 'out_multi_id', 1 ) as num, 'vertici' as label;
```
![](../img/buffer5km/spatialite_gui_210_01.png)

## PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3

![](../img/pgAmin3_info.png)

```
-- crea tabella vertici_dump
CREATE TABLE vertici_dump AS
SELECT k.gid, k.geom  
FROM ( SELECT (ST_DumpPoints(geom)).*, gid FROM com01012018_wgs84 )k;
```
![](../img/buffer5km/pgAmin3_01.png)

## mapshaper

Il Buffer sembra non previsto!!!

## R + RStudio

```
##install required packages
#install.packages("rgeos")
##required packages
library(rgeos)
library(sp)
library(rgdal)


start.time <- Sys.time()
## read shapefile
regioni<-readOGR(dsn = "C:\\Users\\Salvatore\\Desktop\\mapshaper", layer = "dissolve_regioni")
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

##Buffer with rgeos AND writeOGR
start.time <- Sys.time()
buffer5km<-gBuffer(regioni, byid = TRUE , width = 1)
plot(buffer5km)
buffer5km<- as(buffer5km,"SpatialPolygonsDataFrame")
writeOGR(buffer5km, dsn = "C:\\Users\\Salvatore\\Desktop\\mapshaper",layer="buffer5kmR", driver = "ESRI Shapefile")
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
```

![](../img/buffer5km/r_01.png)

![](../img/buffer5km/r_02.png)

## RISULTATI (LZ50) - buffer 1 m

tempo [sec]|software GIS
:---------:|---------
935|QGIS 2.18.24
928|QGIS 3.2.3
3.3|QGIS 3.3 master con debug
9|SpatiaLite_GUI 2.10
9|pgAdmin 3 con spatialIndex
NO|mapshaper
5+15|R + RStudio

[torna su](#buffer-1-m-lz50)