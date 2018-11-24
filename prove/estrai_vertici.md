# estrai vertici (LZ50)

**dataset:** db sqlite con spatialindex tabella _Com01012018_g_WGS84_

<!-- TOC -->

- [estrai vertici (LZ50)](#estrai-vertici-lz50)
    - [QGIS 2.18.24](#qgis-21824)
    - [QGIS 3.2.3](#qgis-323)
    - [QGIS 3.3 master](#qgis-33-master)
    - [SpatiaLite GUI 2.10](#spatialite-gui-210)
    - [PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3](#postgresql-93--postgis-223--pgadmin-3)
    - [mapshaper](#mapshaper)
    - [R + RStudio](#r--rstudio)
    - [RISULTATI (LZ50) - estrai vertici](#risultati-lz50---estrai-vertici)
    - [Osservazioni finali:](#osservazioni-finali)

<!-- /TOC -->

## QGIS 2.18.24

![](../img/qgis21824_info.png)

![](../img/estrai_v/qgis21824_01.png)

Creando un layer temporaneo in memoria:

![](../img/estrai_v/qgis21824_02.png)

Salvando in un file shp:

![](../img/estrai_v/qgis21824_03.png)

Numero vertici estratti: 853.700

-->[torna su](#estrai-vertici-lz50)

## QGIS 3.2.3

![](../img/qgis323_info.png)

![](../img/estrai_v/qgis323_01.png)

Creando un layer temporaneo in memoria:

![](../img/estrai_v/qgis323_03.png)

Salvando in un file shp:

![](../img/estrai_v/qgis323_02.png)

Numero vertici estratti: 853.700

-->[torna su](#estrai-vertici-lz50)

## QGIS 3.3 master

![](../img/qgis33_master_info.png)

NB: Il debug rallenta le prestazioni!!!

![](../img/estrai_v/qgis330_01.png)

Creando un layer temporaneo in memoria:

![](../img/estrai_v/qgis330_03.png)

Salvando in un file shp:

![](../img/estrai_v/qgis330_02.png)

Numero vertici estratti: 853.700

-->[torna su](#estrai-vertici-lz50)

## SpatiaLite GUI 2.10

![](../img/spatialite_gui_210_info.png)

```
-- Creo geotabella estraendo i vertici
CREATE TABLE "vertici_g" AS
SELECT ST_DissolvePoints(geom) as geom from Com01012018_g_WGS84;
SELECT RecoverGeometryColumn('vertici_g','geom',32632,'MULTIPOINT','XY');
-- Esplodo i vertici MultiPoint in Point
SELECT ElementaryGeometries( 'vertici_g' ,'geom' , 'vertici_g_dump' ,'out_pk' , 'out_multi_id', 1 ) as num, 'vertici' as label;
```
![](../img/estrai_v/sl_210_01.png)

Numero vertici estratti: 853.700

-->[torna su](#estrai-vertici-lz50)

## PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3

![](../img/pgAmin3_info.png)

```
-- Creo geotabella vertici_dump
CREATE TABLE vertici_dump AS
SELECT k.gid, k.geom  
FROM ( SELECT (ST_DumpPoints(geom)).*, gid FROM com01012018_g_wgs84 )k;
```
![](../img/estrai_v/pg_223_01.png)

```
-- Creo query in memoria
SELECT k.gid, k.geom  
FROM ( SELECT (ST_DumpPoints(geom)).*, gid FROM com01012018_wgs84 )k;
```

![](../img/estrai_v/pg_223_02.png)

Numero vertici estratti: 853.700

-->[torna su](#estrai-vertici-lz50)

## mapshaper

![](../img/mapshaper_info.png)

```
time node  --max-old-space-size=4192 `which mapshaper` encoding=utf-8 Com01012018_g_wgs84.shp -points vertices -explode -o vertici_g_mapsh.shp
```

**NB:** restituisce 9004 punti in meno rispetto a tutti gli altri software, questo è dovuto al fatto che lo svilippatore ha previsto di eliminare tutti i punti duplicati all'interno della stessa feature, vedasi [issues](https://github.com/mbloch/mapshaper/issues/307)

Numero vertici estratti: 844.696

![](../img/estrai_v/mapshaper_01.png)

**EDIT**: dopo issues lo sviluppatore ha implementato, per la funzione `-points`, l'opzione `-vertices2` ecco il risultato:

![](../img/estrai_v/mapshaper_02.png)

-->[torna su](#estrai-vertici-lz50)

## R + RStudio

![](../img/rstudio_info.png)

**NB:** restituisce 23.657 punti in meno rispetto tutti gli altri software!!!

```
library(rgdal)
###lettura shapefile
start.time <- Sys.time()#inizio cronometro
setwd("F:\\Limiti01012018_g\\Com01012018_g")
comuni<-readOGR("com01012018_g_wgs84.shp")
#plot(comuni)
##estrazione vertici
geom_list<-comuni@polygons
vertices_list<-lapply(1:length(geom_list), function (x) geom_list[[x]]@Polygons[[1]]@coords)
vertices_data<-do.call(rbind.data.frame, vertices_list)
vertices_points<-SpatialPoints(vertices_data, comuni@proj4string)#layer dei vertici
#plot(vertices_points, pch = 19)#processo lungo, togliere # prim del plot per eseguire
num_vertices<-length(vertices_points)#numero di vertici
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken #fine cronometro
##esporta le coordinate in csv
start.time <- Sys.time()#inizio cronometro
write.csv2(vertices_data, file="vertici_g.csv", quote=F, na="", row.names=T)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken#fine cronometro
##stampa numero vertici estratti
num_vertices
```
![](../img/estrai_v/rstudio_01.png)

Numero vertici estratti: 830.043

## RISULTATI (LZ50) - estrai vertici

file/table [sec]|memoria [sec]|software GIS       | nro vertici
:---------:|:---------:|--------------------------|:-----------:
202        |   51      |QGIS 2.18.24              | 853.700
218        |   27      |QGIS 3.2.3                | 853.700
245        |   40      |QGIS 3.3 master con debug | 853.700
283        |   `-`     |SpatiaLite_GUI 2.10       | 853.700
9          |   40      |pgAdmin 3 con spatialIndex| 853.700
63         |   `-`     |mapshaper                 | 844.696
43         |   22      |R + RStudio               | 830.043

`-` prova non possibile! 

[torna su](#estrai-vertici-lz50)

## Osservazioni finali:

In QGIS l'uso dei _file temporanei_ (in memoria) velocizza di parecchio la generazione dell'output di alcuni processing; al contrario in PostGIS, la creazione della tabella è molto più rapida; in RStudio la creazione di un file di output implica sempre più tempo.