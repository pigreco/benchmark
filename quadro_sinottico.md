# Quadro sinottico


Programma       | [estrai vertici](./prove/estrai_vertici.md) | [elimina](./prove/elimina_geom_duplicate.md) | [dissolvi](./prove/dissolvi_regione) |[buffer](./prove/buffer1m.md)|[conta](./prove/conta_punti_poligono.md)| [join](./prove/spatial_join.md)
----------------|:--------------:|:-------:|:--------:|:----:|:---:|:-----
QGIS 2.18.24    | 123            | NO      |       588|     7|  214| +600
QGIS 3.2.3      | 66             | NO      |       253|   3.4|  272| 565
QGIS 3.3 master | 95             |     1162|       247|**3.3**|  182| 317
SpatiaLite 2.10 | 340            |       82|       249|     9|   ??| ??
PostGIS 2.2.3   | **21**         |   **39**|       381|     9|   ??| ??
mapshaper       | 380            |210      |     **9**|    NO|  303| 335
R + RStudio     | 71             |       ??|       136|    20|  455| ??

Se devi estrarre vertici usa **PostGIS**

Se devi eliminare geometrie duplicate usa **PostGIS**

Se devi fare il dissolve usa **mapshaper**

Se dei fare buffer usa **QGIS**

Se devi contare punti nei poligoni usa **QGIS**

Se devi fare uno spatiali join usa **QGIS**


Secondo  | PRIMO    | Terzo
---------|----------|---------
PostGIS  | QGIS     | mapshaper
