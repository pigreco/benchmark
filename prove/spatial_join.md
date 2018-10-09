# spatial join - attibuti per posizione (LZ50)

**dataset:** db sqlite con spatialindex tabella _vertici_g_ok_ e _buffer_2km_g_

<!-- TOC -->

- [spatial join - attibuti per posizione (LZ50)](#spatial-join---attibuti-per-posizione-lz50)
    - [QGIS 2.18.24](#qgis-21824)
    - [QGIS 3.2.3](#qgis-323)
    - [QGIS 3.3 master](#qgis-33-master)
    - [SpatiaLite GUI 2.10](#spatialite-gui-210)
    - [PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3](#postgresql-93--postgis-223--pgadmin-3)
    - [mapshaper](#mapshaper)
    - [R + RStudio](#r--rstudio)
    - [RISULTATI (LZ50) - spatial join - attibuti per posizione](#risultati-lz50---spatial-join---attibuti-per-posizione)
    - [Osservazioni finali](#osservazioni-finali)

<!-- /TOC -->

## QGIS 2.18.24

![](../img/qgis21824_info.png)

![](../img/spatial_j/qgis21824_01.png)

Creando un layer temporaneo in memoria:

![](../img/spatial_j/qgis21824_02.png)


![](../img/spatial_j/qgis21824_03.png)

![](../img/spatial_j/qgis21824_04.png)

-->[torna su](#spatial-join---attibuti-per-posizione-lz50)

## QGIS 3.2.3

![](../img/qgis323_info.png)

![](../img/spatial_j/qgis323_01.png)

Creando un layer temporaneo in memoria:

![](../img/spatial_j/qgis323_02.png)

Salvando in un file shp:

![](../img/spatial_j/qgis323_03.png)

![](../img/spatial_j/qgis323_04.png)

-->[torna su](#spatial-join---attibuti-per-posizione-lz50)

## QGIS 3.3 master

![](../img/qgis33_master_info.png)

NB: Il debug rallenta le prestazioni!!!

![](../img/spatial_j/qgis330_01.png)

Creando un layer temporaneo in memoria:

![](../img/spatial_j/qgis330_02.png)

Salvando in un file shp:

![](../img/spatial_j/qgis330_03.png)

![](../img/spatial_j/qgis330_04.png)

-->[torna su](#spatial-join---attibuti-per-posizione-lz50)

## SpatiaLite GUI 2.10

![](../img/spatialite_gui_210_info.png)

Creando una tabella:

```
-- creo geotabella vertici_g_ok2_sj per spatial join - trasferire 'cod_reg'
CREATE TABLE "vertici_g_ok2_sj" AS
SELECT b.cod_reg AS cod_reg, v.geom AS geom
FROM "buffer2km_g" b JOIN "vertici_g_ok2" v ON St_Intersects (b.geom, v.geom)
WHERE v.out_pk IN (
SELECT rowid FROM SpatialIndex WHERE f_table_name = 'vertici_g_ok2'
AND search_frame = b.geom);
SELECT RecoverGeometryColumn('vertici_g_ok2_sj','geom',32632,'POINT','XY');
```
![](../img/spatial_j/sl_210_01.png)

Creando una query in memoria:

```
-- creo query in memoria
SELECT b.cod_reg AS cod_reg, v.geom AS geom
FROM "buffer2km_g" b JOIN "vertici_g_ok2" v ON St_Intersects (b.geom, v.geom)
WHERE v.out_pk IN (
SELECT rowid FROM SpatialIndex WHERE f_table_name = 'vertici_g_ok2'
AND search_frame = b.geom);
```

![](../img/spatial_j/sl_210_02.png)

-->[torna su](#spatial-join---attibuti-per-posizione-lz50)

## PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3

![](../img/pgAmin3_info.png)

Creo tabella:

```
-- creo geotabella vertici_g_ok_sj per spatial join
CREATE TABLE vertici_g_ok_sj AS
SELECT b.cod_reg, v.geom AS geom
FROM buffer2km_g b join vertici_g_ok v on st_intersects(b.geom,v.geom);
```
![](../img/spatial_j/pg_223_01.png)

Creo query in memoria:

```
-- creo query in memoria
SELECT b.cod_reg, v.geom AS geom
FROM buffer2km_g b join vertici_g_ok v on st_intersects(b.geom,v.geom);
```

![](../img/spatial_j/pg_223_02.png)

-->[torna su](#spatial-join---attibuti-per-posizione-lz50)

## mapshaper

![](../img/mapshaper_info.png)

```
time node  --max-old-space-size=4192 `which mapshaper` encoding=utf-8 vertici_g_ok_330.shp -join dissolto_g_reg_330.shp calc= fields=cod_reg -o vertici_g_ok_sjoin.shp
```

![](../img/spatial_j/mapshaper_01.png)


-->[torna su](#spatial-join---attibuti-per-posizione-lz50)

## R + RStudio

![](../img/rstudio_info.png)

```
da fare!!!
```
![](../img/spatial_j/r_01.png)

## RISULTATI (LZ50) - spatial join - attibuti per posizione

file/table [sec]|memoria [sec]|software GIS
:---------:|:---------:|---------
+1432      |   1432    |QGIS 2.18.24
57         |   34      |QGIS 3.2.3
60         |   47      |QGIS 3.3 master con debug
513        |     1     |SpatiaLite_GUI 2.10
530        |   26      |pgAdmin 3 con spatialIndex
29         |   `-`     |mapshaper
???        |   ???     |R + RStudio

`-` prova non possibile! ??? da fare

[torna su](#spatial-join---attibuti-per-posizione-lz50)

## Osservazioni finali

In QGIS l'uso dei _file temporanei_ (in memoria) velocizza di parecchio la generazione dell'output di alcuni processing.