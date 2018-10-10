# elimina geometrie duplicate (LZ50)

**dataset:** db sqlite con spatialindex tabella _vertici_g_dump_

<!-- TOC -->

- [elimina geometrie duplicate (LZ50)](#elimina-geometrie-duplicate-lz50)
    - [QGIS 2.18.24](#qgis-21824)
    - [QGIS 3.2.3](#qgis-323)
    - [QGIS 3.3 master](#qgis-33-master)
    - [SpatiaLite GUI 2.10](#spatialite-gui-210)
    - [PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3](#postgresql-93--postgis-223--pgadmin-3)
    - [mapshaper](#mapshaper)
    - [R + RStudio](#r--rstudio)
    - [RISULTATI (LZ50) - elimina geometrie duplicate](#risultati-lz50---elimina-geometrie-duplicate)
    - [Osservazioni finali:](#osservazioni-finali)

<!-- /TOC -->

## QGIS 2.18.24

![](../img/qgis21824_info.png)

![](../img/elimina_d/qgis21824_01.png)

Questo geoalgoritmo è inefficiente e il tempo è troppo lungo, quindi prova non eseguita.

-->[torna su](#elimina-geometrie-duplicate-lz50)

## QGIS 3.2.3

![](../img/qgis323_info.png)

![](../img/elimina_d/qgis323_01.png)

Creando un layer temporaneo in memoria o

Salvando in un file shp:

![](../img/elimina_d/qgis323_02.png)

Questo geoalgoritmo è inefficiente e il tempo è troppo lungo, quindi prova non eseguita. Bug RISOLTO nella prossima verisone 3.4

-->[torna su](#elimina-geometrie-duplicate-lz50)

## QGIS 3.3 master

![](../img/qgis33_master_info.png)

NB: Il debug rallenta le prestazioni!!!

![](../img/elimina_d/qgis330_01.png)

Creando un layer temporaneo in memoria:

![](../img/elimina_d/qgis330_02.png)

Salvando in un file shp:

![](../img/elimina_d/qgis330_04.png)

Numero vertici puliti: 432.355

-->[torna su](#elimina-geometrie-duplicate-lz50)

## SpatiaLite GUI 2.10

![](../img/spatialite_gui_210_info.png)

Creo tabella:
```
-- creo geotabella evitando le geometrie duplicate
CREATE TABLE vertici_g_ok AS
SELECT out_pk, geom
FROM vertici_g_dump
WHERE out_pk IN (SELECT min(out_pk) FROM vertici_g_dump GROUP BY geom);
SELECT RecoverGeometryColumn('vertici_g_ok','geom',32632,'POINT','XY');
-- creo SpatialIndex SpatiaLite
SELECT CreateSpatialIndex ('vertici_g_ok','geom');
```
![](../img/elimina_d/sl_210_01.png)

Creo query in memoria:

```
-- creo query in memoria
SELECT out_pk, geom
FROM vertici_g_dump
WHERE out_pk IN (SELECT min(out_pk) FROM vertici_g_dump GROUP BY geom);
```

![](../img/elimina_d/sl_210_02.png)

Numero vertici puliti: 432.355

-->[torna su](#elimina-geometrie-duplicate-lz50)

## PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3

![](../img/pgAmin3_info.png)

Creo tabella:

```
-- creo geotabella con geometrie non duplicate
CREATE TABLE vertici_g_ok AS
SELECT DISTINCT ON (ST_AsBinary(geom)) geom 
FROM vertici_g_dump;
```
![](../img/elimina_d/pg_223_01.png)

Creo query in memoria:

```
-- Creo query in memoria
SELECT DISTINCT ON (ST_AsBinary(geom)) geom 
FROM vertici_g_dump;
```

![](../img/elimina_d/pg_223_02.png)

Numero vertici puliti: 432.355

-->[torna su](#elimina-geometrie-duplicate-lz50)

## mapshaper

[issues](https://github.com/mbloch/mapshaper/issues/305) - grazie [Andrea](https://twitter.com/aborruso?lang=it)

Non esiste una funzione che faccia al caso nostro, quello che segue è una forzatura e quindi i tempi sono più lunghi!
```
time node  --max-old-space-size=4192 `which mapshaper` encoding=utf-8 vertici_g.shp -explode -each 'key = this.x + "," + this.y' -uniq key -o vertici_g_ok_mapsh.shp
```

![](../img/elimina_d/mapshaper_01.png)

![](../img/elimina_d/mapshaper_02.png)

Numero vertici puliti: 432.355

-->[torna su](#elimina-geometrie-duplicate-lz50)

## R + RStudio

![](../img/rstudio_info.png)

```
da fare
```
![](../img/elimina_d/rstudio_01.png)

## RISULTATI (LZ50) - elimina geometrie duplicate

file/table [sec]|memoria [sec]|software GIS       | puliti
:---------:|:---------:|--------------------------|:---------
  `-`      |    `-`    |QGIS 2.18.24              | `-`
  `-`      |    `-`    |QGIS 3.2.3                | `-`
462        |  387      |QGIS 3.3 master con debug | 432.355
100        |   19      |SpatiaLite_GUI 2.10       | 432.355
13         |   26      |pgAdmin 3 con spatialIndex| 432.355
58         |   `-`     |mapshaper                 | 432.355
??         |   ??      |R + RStudio               | ??

`-` prova non possibile o bug!  `??` da fare 

[torna su](#elimina-geometrie-duplicate-lz50)

## Osservazioni finali:

In QGIS l'uso dei _file temporanei_ (in memoria) velocizza di parecchio la generazione dell'output di alcuni processing, in questo caso il bug non permette la realizzazione dei test; al contrario in PostGIS, la creazione della tabella è molto più rapida; in Spatialite restituisce velocemente i primi 500 risultati; in RStudio la creazione di un file di output implica sempre più tempo.