SELECT latlon(geom),
       latlon_parens(geom),
       latlon_tab(geom),
       latlon_google(geom),
       latlon_osm(geom),
       latlon_bing(geom),
       latlon_is_valid(geom)
FROM (SELECT st_geomFromText('POINT(2.294609 48.85835)', 4326) as geom) sq;

SELECT latlon_is_valid(geom) AS should_be_true
FROM (SELECT st_geomFromText('POLYGON((2.291 48.861,2.298 48.861,2.298 48.855,2.291 48.855,2.291 48.861))', 4326) as geom) sq;

SELECT latlon_is_valid(geom) AS should_be_false
FROM (SELECT st_geomFromText('POLYGON((182.291 48.861,2.298 48.861,2.298 48.855,2.291 48.855,182.291 48.861))', 4326) as geom) sq;

SELECT latlon_is_valid(geom) AS should_be_false
FROM (SELECT st_geomFromText('POLYGON((2.291 148.861,2.298 48.861,2.298 48.855,2.291 48.855,2.291 148.861))', 4326) as geom) sq;

SELECT latlon_is_valid(geom) AS should_be_false
FROM (SELECT st_geomFromText('POLYGON((2.291 148.861,2.298 48.861,2.298 48.855,2.291 48.855,2.291 148.861))', 4326) as geom) sq;

SELECT latlon_is_valid(geom) AS should_be_false
FROM (SELECT st_geomFromText('POINT(-181 5)', 4326) as geom) sq;

SELECT latlon_is_valid(geom) AS should_be_false
FROM (SELECT st_geomFromText('POINT(181 5)', 4326) as geom) sq;

SELECT latlon_is_valid(geom) AS should_be_false
FROM (SELECT st_geomFromText('POINT(5 -95)', 4326) as geom) sq;
