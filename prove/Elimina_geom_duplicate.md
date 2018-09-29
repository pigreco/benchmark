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
![](../img/estrai_vertici/spatialite_gui_210_04.png)

![](../img/estrai_vertici/spatialite_gui_210_02.png)

# RISULTATI

tempo [sec]|programma
:---------:|---------
???|QGIS 2.18.24
???|QGIS 3.2.3
???|QGIS 3.3 master con debug
302| SpatiaLite_GUI 2.10 no spatialIndex
