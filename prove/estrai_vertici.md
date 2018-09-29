# estrai vertici

dataset: db sqlite con spatialidex

## QGIS 2.18.24

![](../img/qgis21824_master_info.png)

![](../img/estrai_vertici/qgis21824master_01.png)

![](../img/estrai_vertici/qgis21824master_02.png)

**Elimina geometrie duplicate** è un algoritmo inefficiente (problema risolto nella prossima 3.4), nessun risultato dopo oltre 30 minuti, quindi è stato bloccato:

![](../img/estrai_vertici/qgis21824master_03.png)

## ## QGIS 3.2.3

![](../img/qgis323_master_info.png)

![](../img/estrai_vertici/qgis323_01.png)

![](../img/estrai_vertici/qgis323_02.png)

![](../img/estrai_vertici/qgis323_03.png)

**Elimina geometrie duplicate** è un algoritmo inefficiente (problema risolto nella prossima 3.4), nessun risultato dopo oltre 10 minuti, quindi è stato bloccato:

![](../img/estrai_vertici/qgis323_04.png)

## ## QGIS 3.3 master

![](../img/qgis33_master_info.png)

![](../img/estrai_vertici/qgis33master_01.png)

![](../img/estrai_vertici/qgis33master_02.png)

![](../img/estrai_vertici/qgis33master_03.png)

![](../img/estrai_vertici/qgis33master_04.png)

domani!!!

## SpatiaLite_GUI 2.10

estraggo i vertici:
```
-- Creo tabella estraendo i vertici
CREATE TABLE "vertici_com" AS
SELECT ST_DissolvePoints(geometry) as geometry from Com01012018_WGS84;
SELECT RecoverGeometryColumn('vertici_com','geometry',32632,'MULTIPOINT','XY');
-- Esplodo i vertici MultiPoint
SELECT ElementaryGeometries( 'vertici_com' ,'geometry' , 'vertici' ,'out_pk' , 'out_multi_id', 1 ) as num, 'vertici' as label;
-- Creo tabella evitando le geometrie duplicate:
CREATE TABLE vertici_ok as 
SELECT distinct geometry
FROM vertici;
SELECT RecoverGeometryColumn('vertici_ok','geometry',32632,'POINT','XY');
```
![](../img/spatialite_gui_210_info.png)

![](../img/estrai_vertici/spatialite_gui_210_01.png)

![](../img/estrai_vertici/spatialite_gui_210_02.png)
