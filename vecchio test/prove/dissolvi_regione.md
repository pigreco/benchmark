# dissolvi per regione (LZ50)

dataset: db sqlite con spatialindex

<!-- TOC -->

- [dissolvi per regione (LZ50)](#dissolvi-per-regione-lz50)
    - [QGIS 2.18.24](#qgis-21824)
    - [QGIS 3.2.3](#qgis-323)
    - [QGIS 3.3 master](#qgis-33-master)
    - [SpatiaLite_GUI 2.10](#spatialitegui-210)
    - [PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3](#postgresql-93--postgis-223--pgadmin-3)
    - [mapshaper](#mapshaper)
    - [R +RStudio](#r-rstudio)
    - [RISULTATI (LZ50) - dissolvi per regione](#risultati-lz50---dissolvi-per-regione)

<!-- /TOC -->

## QGIS 2.18.24

![](../img/qgis21824_info.png)

![](../img/dissolvi_regione/qgis21824_01.png)

![](../img/dissolvi_regione/qgis21824_02.png)

## QGIS 3.2.3

![](../img/qgis323_info.png)

![](../img/dissolvi_regione/qgis323_01.png)

![](../img/dissolvi_regione/qgis323_02.png)

## QGIS 3.3 master

![](../img/qgis33_master_info.png)

NB: Il debug rallenta le prestazioni!!!

![](../img/dissolvi_regione/qgis33master_01.png)

![](../img/dissolvi_regione/qgis33master_02.png)

## SpatiaLite_GUI 2.10

estraggo i vertici:

![](../img/spatialite_gui_210_info.png)

```
-- crea geotabella dissolvendo per cod_reg
CREATE TABLE dissolve_reg AS
SELECT cod_reg, CastToMultiPolygon(ST_Union(geometry)) AS geometry 
FROM com01012018_wgs84
GROUP BY 1;
SELECT RecoverGeometryColumn('dissolve_reg','geometry',32632,'MULTIPOLYGON','XY');
```
![](../img/dissolvi_regione/spatialite_gui_210_01.png)

## PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3

![](../img/pgAmin3_info.png)

```
-- crea tabella dissolvi per regione
CREATE TABLE dissolto_reg AS
SELECT cod_reg, ST_Multi(ST_Union(geom)) AS geom  
FROM public.com01012018_wgs84
GROUP BY 1;
```
![](../img/dissolvi_regione/pgAmin3_01.png)

## mapshaper 

```
time mapshaper encoding=utf-8  com01012018_wgs84.shp -dissolve cod_reg -o outdissolto_reg.shp
```

![](../img/dissolvi_regione/mapshaper_01.png)

## R +RStudio

```
##install required packages
#install.packages("rgdal", "maptools")
##required packages
library("rgdal")
library("maptools")
library("raster")

start.time <- Sys.time()
## read shapefile
comuni<-readOGR(dsn = "C:\\Users\\Salvatore\\Desktop\\mapshaper", layer = "com01012018_wgs84")
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

##dissolve with raster AND writeOGR
start.time <- Sys.time()
dissolveR<- aggregate(comuni, by ='cod_reg')
#plot(dissolveR)
writeOGR(dissolveR, dsn = "C:\\Users\\Salvatore\\Desktop\\mapshaper",layer="dissolve_regioni", driver = "ESRI Shapefile")
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
```

![](../img/dissolvi_regione/r_01.png)

![](../img/dissolvi_regione/r_02.png)

## RISULTATI (LZ50) - dissolvi per regione

tempo [sec]|software GIS
:---------:|---------
588|QGIS 2.18.24
253|QGIS 3.2.3
247|QGIS 3.3 master con debug
249|SpatiaLite_GUI 2.10
381|pgAdmin 3 (PostGIS 2.2.3)
9|mapshaper
16+120|R + RStudio

[torna su](#dissolvi-per-regione-lz50)