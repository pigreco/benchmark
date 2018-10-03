# Quadro sinottico


Programma GIS     | [estrai vertici](./prove/estrai_vertici.md) | [elimina geom duplicate](./prove/elimina_geom_duplicate.md) | [dissolvi](./prove/dissolvi_regione) |[buffer](./prove/buffer1m.md)|[conta punti nei poligoni](./prove/conta_punti_poligono.md)| [spatial join](./prove/spatial_join.md)
----------------|:--------------:|:-------:|:--------:|:----:|:---:|:-----:
QGIS 2.18.24    | 123            | NO      |       588|     7|  214| +600
QGIS 3.2.3      | 66             | NO      |       253|   3.4|  272| 565
QGIS 3.3 master | 95             |     1162|       247|**3.3**|  182| 317
SpatiaLite 2.10 | 340            |       82|       249|     9|   ??| ??
PostGIS 2.2.3   | **21**         |   **39**|       381|     9|   ??| ??
mapshaper       | 380            |210      |     **9**|    NO|  303| 335
R + RStudio     | 71             |       ??|       136|    20|  455| ??

NO: prova troppo lunga o inesitente nel programma; ??: prova da fare;


_CONCLUSIONI:_

Se devi estrarre vertici usa **PostGIS**

Se devi eliminare geometrie duplicate usa **PostGIS**

Se devi fare il dissolve usa **mapshaper**

Se devi fare buffer usa **QGIS** 3.4

Se devi contare punti nei poligoni usa **QGIS** 3.4

Se devi fare uno spatiali join usa **QGIS** 3.4

_PODIO:_

Secondo  | PRIMO    | Terzo
:-------:|:--------:|:-------:
PostGIS  | QGIS     | mapshaper


**R + RStudio** è molto rapido nelle analisi in quanto carica i dataset in memoria, ma il processo di caricamento è lento!!!

**mapshaper** utility da riga di comando, fa benissimo alcune cose - vedi dissolve - ma non è completo!!!

**QGIS 2.18 LTR**  ha fatto la storia di QGIS ma andrà in pensione a ottobre 2018 dopo due anni di gloria!!!

**QGIS 3.2.x LR** come per tutte le regolar release, durerà solo 4 mesi!!!

**QGIS 3.3 master** è attualmente la versione di sviluppo ma a fine ottobre 2018 sarà la 3.4, ovvero la prossima LTR fino al 2020!!!
