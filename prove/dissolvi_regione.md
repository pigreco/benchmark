# dissolvi per regione (LZ50)

dataset: db sqlite con spatialidex

<!-- TOC -->

- [dissolvi per regione (LZ50)](#dissolvi-per-regione-lz50)
    - [QGIS 2.18.24](#qgis-21824)
    - [QGIS 3.2.3](#qgis-323)
    - [QGIS 3.3 master](#qgis-33-master)
    - [SpatiaLite_GUI 2.10](#spatialitegui-210)
    - [PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3](#postgresql-93--postgis-223--pgadmin-3)
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
-- Creo tabella estraendo i vertici
CREATE TABLE "vertici_com" AS
SELECT ST_DissolvePoints(geometry) as geometry from Com01012018_WGS84;
SELECT RecoverGeometryColumn('vertici_com','geometry',32632,'MULTIPOINT','XY');
-- Esplodo i vertici MultiPoint
SELECT ElementaryGeometries( 'vertici_com' ,'geometry' , 'vertici' ,'out_pk' , 'out_multi_id', 1 ) as num, 'vertici' as label;
```
![](../img/dissolvi_regione/spatialite_gui_210_03.png)

## PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3

![](../img/pgAmin3_info.png)

```
-- crea tabella vertici_dump
CREATE TABLE vertici_dump AS
SELECT k.gid, k.geom  
FROM ( SELECT (ST_DumpPoints(geom)).*, gid FROM com01012018_wgs84 )k;
```
![](../img/dissolvi_regione/pgAmin3_01.png)

## RISULTATI (LZ50) - dissolvi per regione

tempo [sec]|programma
:---------:|---------
123|QGIS 2.18.24
255|QGIS 3.2.3
95|QGIS 3.3 master con debug
340|SpatiaLite_GUI 2.10
21|pgAdmin 3 con spatialIndex
??|mapshaper
??|R + RStudio
