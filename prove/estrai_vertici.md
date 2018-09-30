# estrai vertici (LZ50)

dataset: db sqlite con spatialidex

## QGIS 2.18.24

![](../img/qgis21824_info.png)

![](../img/estrai_vertici/qgis21824_01.png)

![](../img/estrai_vertici/qgis21824_02.png)

## QGIS 3.2.3

![](../img/qgis323_info.png)

![](../img/estrai_vertici/qgis323_01.png)

![](../img/estrai_vertici/qgis323_02.png)

## QGIS 3.3 master

![](../img/qgis33_master_info.png)

NB: Il debug rallenta le prestazioni!!!

![](../img/estrai_vertici/qgis33master_01.png)

![](../img/estrai_vertici/qgis33master_02.png)

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
![](../img/estrai_vertici/spatialite_gui_210_03.png)

## PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3

![](../img/pgAmin3_info.png)

```
CREATE TABLE vertici_dump AS
SELECT k."PK_UID", k.geom  
FROM ( SELECT (ST_DumpPoints(geom)).*, "PK_UID" FROM comuni )k;
```
![](../img/estrai_vertici/pgAmin3_01.png)

# RISULTATI (LZ50) - estrai vertici

tempo [sec]|programma
:---------:|---------
123|QGIS 2.18.24
66|QGIS 3.2.3
95|QGIS 3.3 master con debug
340|SpatiaLite_GUI 2.10 no spatialIndex
20|pgAdmin 3 con spatialIndex
??|mapshaper
??|R + RStudio

Dati:

nro vertici|nro no duplicati| nro duplicati
-----------|----------------|--------------
4.901.723|2.631.955|2.269.768

Da QGIS:

![](../img/estrai_vertici/qgis33master_06.png)