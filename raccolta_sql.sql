---------PostGIS-----------

-- creo SpatialIndex PostGIS
CREATE INDEX sidx_vertici_g_ok_geom
  ON public.vertici_g_ok
  USING gist
  (geom);
  
-- creo tabella vertici_dump
CREATE TABLE vertici_g_dump AS
SELECT k.gid, k.geom  
FROM ( SELECT (ST_DumpPoints(geom)).*, gid FROM com01012018_g_wgs84 )k;

-- creo geotabella con geometrie non duplicate
CREATE TABLE vertici_g_ok AS
SELECT DISTINCT ON (ST_AsBinary(geom)) geom 
FROM vertici_g_dump;
  
-- creo geotabella dissolvi per regione
CREATE TABLE dissolto_g_reg AS
SELECT cod_reg, St_Multi(St_Union(geom)) AS geom
FROM public.com01012018_g_WGS84
GROUP BY 1;

-- creo geotabella con buffer di -2 km
CREATE TABLE buffer2km_g AS
SELECT cod_reg, St_Multi(St_Buffer(geom, -2000)) AS geom
FROM dissolto_g_reg;

-- creo geotabella con geometria non duplicate
CREATE TABLE vertici_g_ok AS
SELECT DISTINCT ON (St_AsBinary(geom)) geom
FROM vertici_g_dump;

-- creo geotabella con conteggio
CREATE TABLE count_buffer2km_g AS
SELECT cod_reg, b.geom AS geom, count(v.geom) as nro
FROM buffer2km_g b join vertici_g_ok v on st_intersects(b.geom,v.geom)
GROUP BY 1,2;

-- creo geotabella vertici_g_ok_sj per spatial join
CREATE TABLE vertici_g_ok_sj AS
SELECT b.cod_reg, v.geom AS geom
FROM buffer2km_g b join vertici_g_ok v on st_intersects(b.geom,v.geom);

---------SPATIALITE----------

-- creo SpatialIndex SpatiaLite
SELECT CreateSpatialIndex ('com01012018_g_WGS84','geom');

-- creo geotabella estraendo i vertici
CREATE TABLE "vertici_g" AS
SELECT ST_DissolvePoints(geom) as geom from Com01012018_g_WGS84;
SELECT RecoverGeometryColumn('vertici_g','geom',32632,'MULTIPOINT','XY');
-- esplodo i vertici MultiPoint in Point
SELECT ElementaryGeometries( 'vertici_g' ,'geom' , 'vertici_g_dump' ,'out_pk' , 'out_multi_id', 1 ) as num, 'vertici' as label;
-- creo SpatialIndex SpatiaLite
SELECT CreateSpatialIndex ('vertici_g_dump','geom');

-- creo geotabella buffer di -2 km
CREATE TABLE buffer2km_g AS
SELECT cod_reg, CastToMultiPolygon(ST_Buffer(geom, -2000)) AS geom
FROM dissolve_reg;
SELECT RecoverGeometryColumn('buffer2km_g','geom',32632,'MULTIPOLYGON','XY');
-- creo SpatialIndex SpatiaLite
SELECT CreateSpatialIndex ('buffer2km_g','geom');

-- crea geotabella dissolvendo per cod_reg
CREATE TABLE dissolve_reg AS
SELECT cod_reg, CastToMultiPolygon(ST_Union(geom)) AS geom
FROM com01012018_G_wgs84
GROUP BY 1;
SELECT RecoverGeometryColumn('dissolve_reg','geom',32632,'MULTIPOLYGON','XY');
-- creo SpatialIndex SpatiaLite
SELECT CreateSpatialIndex ('dissolve_reg','geom');

-- creo geotabella evitando le geometrie duplicate:
CREATE TABLE vertici_g_ok AS
SELECT out_pk, geom
FROM vertici_g_dump
WHERE out_pk IN (SELECT min(out_pk) FROM vertici_g_dump GROUP BY geom);
SELECT RecoverGeometryColumn('vertici_g_ok','geom',32632,'POINT','XY');
-- creo SpatialIndex SpatiaLite
SELECT CreateSpatialIndex ('vertici_g_ok','geom');

-- creo geotabella
CREATE TABLE "vertici_g_ok2" 
(
out_pk INTEGER PRIMARY KEY NOT NULL
);
SELECT AddGeometryColumn ('vertici_g_ok2','geom',32632,'POINT','XY');
-- popolo la geotabella evitando le geometrie duplicate
INSERT INTO "vertici_g_ok2" (out_pk, geom)
SELECT out_pk, geom
FROM vertici_g_dump
WHERE out_pk IN (SELECT min(out_pk) FROM vertici_g_dump GROUP BY geom);
-- creo SpatialIndex SpatiaLite
SELECT CreateSpatialIndex ('vertici_g_ok','geom');

-- creo geotabella per conteggio punti nei poligoni
CREATE TABLE "count_buffer2km_g" AS
SELECT b.cod_reg AS cod_reg, b.geom AS geom, count(v.geom) AS nro
FROM "buffer2km_g" b JOIN "vertici_g_ok2" v ON St_Intersects (b.geom, v.geom)
WHERE v.out_pk IN (
SELECT rowid FROM SpatialIndex WHERE f_table_name = 'vertici_g_ok2'
AND search_frame = b.geom)
GROUP BY 1,2;
SELECT RecoverGeometryColumn('count_buffer2km_g','geom',32632,'MULTIPOLYGON','XY');

-- creo geotabella vertici_g_ok2_sj per spatial join - trasferire 'cod_reg'
CREATE TABLE "vertici_g_ok2_sj" AS
SELECT b.cod_reg AS cod_reg, v.geom AS geom
FROM "buffer2km_g" b JOIN "vertici_g_ok2" v ON St_Intersects (b.geom, v.geom)
WHERE v.out_pk IN (
SELECT rowid FROM SpatialIndex WHERE f_table_name = 'vertici_g_ok2'
AND search_frame = b.geom);
SELECT RecoverGeometryColumn('vertici_g_ok2_sj','geom',32632,'POINT','XY');

