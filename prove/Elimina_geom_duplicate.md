# elimina geometrie duplicate (LZ50)

dataset: db sqlite con spatialidex

## QGIS 2.18.24

![](../img/qgis21824_info.png)

**Elimina geometrie duplicate** è un algoritmo inefficiente (problema risolto nella prossima 3.4), nessun risultato dopo oltre 30 minuti, quindi è stato bloccato:

![](../img/estrai_vertici/qgis21824_03.png)

## QGIS 3.2.3

![](../img/qgis323_info.png)

![](../img/estrai_vertici/qgis323_03.png)

**Elimina geometrie duplicate** è un algoritmo inefficiente (problema risolto nella prossima 3.4), nessun risultato dopo oltre 10 minuti, quindi è stato bloccato:

![](../img/estrai_vertici/qgis323_04.png)

## QGIS 3.3 master

![](../img/qgis33_master_info.png)

NB: Il debug rallenta le prestazioni!!!

![](../img/estrai_vertici/qgis33master_03.png)

![](../img/estrai_vertici/qgis33master_04.png)

domani!!!

## SpatiaLite_GUI 2.10

Elimino le geometrie duplicate:

![](../img/spatialite_gui_210_info.png)

```
-- Creo tabella evitando le geometrie duplicate:
CREATE TABLE vertici_ok as 
SELECT distinct geometry
FROM vertici;
SELECT RecoverGeometryColumn('vertici_ok','geometry',32632,'POINT','XY');
```
NB: il **select distinct** NON è preciso (1e-5)

![](../img/estrai_vertici/spatialite_gui_210_04.png)

![](../img/estrai_vertici/spatialite_gui_210_02.png)

## PostgreSQL 9.3 / PostGIS 2.2.3 / pgAdmin 3

![](../img/pgAmin3_info.png)

![](../img/estrai_vertici/pgAmin3_02.png)

```
SELECT DISTINCT ON (ST_AsBinary(geom)) geom 
FROM vertici_dump;
```

![](../img/estrai_vertici/pgAmin3_03.png)

```
SELECT geom, count(*) as nro
FROM vertici_dump
GROUP BY 1
HAVING count(*) > 1
ORDER BY count(*) DESC;
```

# RISULTATI (LZ50)

tempo [sec]|programma
:---------:|---------
???|QGIS 2.18.24
???|QGIS 3.2.3
???|QGIS 3.3 master con debug
302| SpatiaLite_GUI 2.10 no spatialIndex
134|pgAdmin 3 con spatialIndex
??|mapshaper
??|R + RStudio