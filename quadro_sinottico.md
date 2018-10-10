# Quadro sinottico LZ50

Software GIS / prova    | QGIS 2.18.24  | QGIS 3.2.3 | QGIS 3.3 master|SpatiaLite 2.10|PostGIS 2.2.3 |mapshaper|R + RStudio
-----------------------:|:-------------:|:----------:|:--------------:|:-------------:|:------------:|:-------:|:---------:
[estrai vertici](./prove/estrai_vertici.md)           |202/51        |218/27      |245/40          |283/`-`        |9/40          |63/`-`   |43/22
[elimina geom duplicate](./prove/elimina_geom_duplicate.md)   |`-`/`-`       |`-`/`-`     |462/387         |100/19         |13/26         |58/`-`   |??/??
[dissolvi](./prove/dissolvi_regione)                 |126/126       |99/99       |99/99           |98/98          |163/155       |3/`-`    |62/61
[buffer](./prove/buffer2km.md)                   |23/23         |22/22       |22/22           |15/11          |18/18         |`-`/`-`  |13/12
[conta punti nei poligoni](./prove/conta_punti_poligono.md) |65/60         |75/75       |75/75           |3372/+3600     |254/394       |64/`-`   |407/407
[spatial join](./prove/spatial_join.md)             |+1432/1432    |57/34       |60/47           |513/1          |530/26        |29/`-`   |??/??

tempi in secondi: file-tabella/memoria  

`-`: prova non prevista nel software o non fattibile; ??: prova da fare;


## NOTE sui software GIS utilizzati

**R + RStudio** è molto rapido nelle analisi in quanto carica i dataset in memoria, ma il processo di caricamento è lento!!!

**mapshaper** utility da riga di comando, fa benissimo alcune cose - vedi dissolve - ma non è completo!!!

**QGIS 2.18 LTR**  ha fatto la storia di QGIS ma andrà in pensione a ottobre 2018 dopo due anni di gloria!!!

**QGIS 3.2.x LR** come per tutte le regolar release, durerà solo 4 mesi!!!

**QGIS 3.3 master** è attualmente la versione di sviluppo ma a fine ottobre 2018 sarà la 3.4, ovvero la prossima LTR fino al 2020!!!

**PostGIS** è il migliore in assoluto ma in certe prove - come il dissolve - è lento!!!

**SpatiaLite** è il migliore se si considera la faciltà di uso.


