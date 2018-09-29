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
![](../img/estrai_vertici/spatialite_gui_210_00.png)

![](../img/estrai_vertici/spatialite_gui_210_01.png)

![](../img/estrai_vertici/spatialite_gui_210_02.png)

# RISULTATI

tempo [sec]|programma
:---------:|---------
123|QGIS 2.18.24
66|QGIS 3.2.3
95|QGIS 3.3 master con debug
241| SpatiaLite_GUI 2.10 no spatialIndex
