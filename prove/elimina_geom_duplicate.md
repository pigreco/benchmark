# elimina geometrie duplicate (LZ50)

dataset: db sqlite con spatialidex

<!-- TOC -->

- [elimina geometrie duplicate (LZ50)](#elimina-geometrie-duplicate-lz50)
    - [QGIS 2.18.24](#qgis-21824)
    - [QGIS 3.2.3](#qgis-323)
    - [QGIS 3.3 master](#qgis-33-master)
    - [SpatiaLite_GUI 2.10](#spatialitegui-210)
    - [PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3](#postgresql-93--postgis-223--pgadmin-3)
    - [mapshaper - issues - grazie Andrea](#mapshaper---issues---grazie-andrea)
    - [R + RStudio](#r--rstudio)
    - [RISULTATI (LZ50) - elimina geometrie duplicate](#risultati-lz50---elimina-geometrie-duplicate)

<!-- /TOC -->

## QGIS 2.18.24

![](../img/qgis21824_info.png)

**Elimina geometrie duplicate** è un algoritmo inefficiente (problema risolto nella prossima 3.4), nessun risultato dopo oltre 30 minuti, quindi è stato bloccato:

![](../img/elimina_geom_duplicate/qgis21824_03.png)

## QGIS 3.2.3

![](../img/qgis323_info.png)

![](../img/elimina_geom_duplicate/qgis323_03.png)

**Elimina geometrie duplicate** è un algoritmo inefficiente (problema risolto nella prossima 3.4), nessun risultato dopo oltre 10 minuti, quindi è stato bloccato:

![](../img/elimina_geom_duplicate/qgis323_04.png)

## QGIS 3.3 master

![](../img/qgis33_master_info.png)

NB: Il debug rallenta le prestazioni!!!

![](../img/elimina_geom_duplicate/qgis33master_04.png)

![](../img/elimina_geom_duplicate/qgis33master_05.png)

## SpatiaLite_GUI 2.10

Elimino le geometrie duplicate:

![](../img/spatialite_gui_210_info.png)

```
-- Creo tabella evitando le geometrie duplicate:
CREATE TABLE vertici_ok AS
SELECT out_pk, geometry
FROM vertici
WHERE out_pk IN (SELECT min(out_pk) 
                 FROM vertici
                 GROUP BY geometry);

SELECT RecoverGeometryColumn('vertici_ok','geometry',32632,'POINT','XY');
```

![](../img/elimina_geom_duplicate/spatialite_gui_210_02.png)

## PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3

![](../img/pgAmin3_info.png)

![](../img/elimina_geom_duplicate/pgAmin3_02.png)

```
-- crea tabella con geometrie non duplicate
CREATE TABLE vertici_ok AS
SELECT DISTINCT ON (ST_AsBinary(geom)) geom 
FROM vertici_dump;
```

![](../img/elimina_geom_duplicate/pgAmin3_03.png)

```
-- geometrie duplicate
SELECT * 
FROM 
(
SELECT gid, ROW_NUMBER() OVER(PARTITION BY geom ORDER BY gid ASC) AS Row,geom 
FROM ONLY vertici_dump
) dups 
WHERE dups.Row > 1
```
[articolo.](https://gis4programmers.wordpress.com/2016/10/11/detecting-duplicated-geometries-in-a-postgis-table/)

la seguente restituisce valori diversi, perché?
```
SELECT geom, count(*) as nro
FROM vertici_dump
GROUP BY 1
HAVING count(*) > 1
ORDER BY count(*) DESC;
```

## mapshaper - [issues](https://github.com/mbloch/mapshaper/issues/305) - grazie [Andrea](https://twitter.com/aborruso?lang=it)

Non esiste una funzione che faccia al caso nostro, quello che segue è una forzatura e quindi i tempi sono lunghi!
```
time node  --max-old-space-size=4192 `which mapshaper` encoding=utf-8 vertci_all.shp -explode -each 'key = this.x + "," + this.y' -uniq key -o unique_points.shp
```

![](../img/elimina_geom_duplicate/mapshaper_01.png)

## R + RStudio



## RISULTATI (LZ50) - elimina geometrie duplicate

tempo [sec]|software GIS
:---------:|---------
NO|QGIS 2.18.24
NO|QGIS 3.2.3
1162|QGIS 3.3 master con debug
82|SpatiaLite_GUI 2.10
39|pgAdmin 3 con spatialIndex
210|mapshaper
??|R + RStudio

[torna su](#elimina-geometrie-duplicate-lz50)