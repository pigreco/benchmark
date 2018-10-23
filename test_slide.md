# Funzioni di aggregazione

`relation_agregate` VS variabile `@parent`
--
![foto](./img/esempio/esempio_01.png)

Due layer: foglio e particelle
---
## Definisco due relazioni di progetto
--
![foto](./img/esempio/esempio_02.png)
---
espressione utilizzata per l'etichettatura:

```
'sup:,' ||  
relation_aggregate( 
relation:='rel_01', 
aggregate:='concatenate', 
expression:='dest: '||"destinazio"||': '||"area_kmq"||' kmq', 
concatenator:=',') 
|| ',_________________,' || 
'sup_TOT: ' ||  
relation_aggregate( 
relation:='rela_02', 
aggregate:='sum',  
expression:="sup" ) 
|| ' kmq'
```
--
risultato:

![foto](./img/esempio/esempio_03.png)
---
## Usando SOLO la variabile `@parent`

espressione utilizzata per l'etichettatura:

```
'sup:,' ||  
aggregate( 
layer:='virtual_layer', 
aggregate:='concatenate', 
expression:='dest: '||"destinazio" ||': '||"area_kmq"||' kmq', 
filter:= intersects($geometry, geometry(@parent)),
concatenator:=',') 
|| ',_________________,' || 
'sup_TOT: ' ||  
aggregate( 
layer:='particella', 
aggregate:='sum',  
expression:="sup",
filter:= intersects($geometry, geometry(@parent) ) )
|| ' kmq'
```
--
risultato:

![foto](./img/esempio/esempio_03.png)
---
Confronto:

![foto](./img/esempio/esempio_04.png)