-- Tests for the functions in postgis_latlon.
--
-- Prerequisites:
--    Install postgis_latlon (see README.md)
--
-- Testing:
--    psql --tuples-only --expanded -U postgres -f test/test.sql | tee test/actual_output.txt
--    diff test/expected_output.txt test/actual_output.txt
--
--    diff result should be completely identical (exit code 0, no output).

SELECT 'Sanity - All function work.' AS TEST;
SELECT latlon(geom),
       latlon_parens(geom),
       latlon_tab(geom),
       latlon_google(geom),
       latlon_osm(geom),
       latlon_bing(geom),
       latlon_is_valid(geom)
FROM (SELECT st_geomFromText('POINT(2.294609 48.85835)', 4326) as geom) sq;

SELECT 'latlon_is_valid - valid polygon.' AS TEST;
SELECT latlon_is_valid(geom) AS should_be_true
FROM (SELECT st_geomFromText('POLYGON((2.291 48.861,2.298 48.861,2.298 48.855,2.291 48.855,2.291 48.861))', 4326) as geom) sq;

SELECT 'latlon_is_valid - invalid polygons.' AS TEST;
SELECT latlon_is_valid(geom) AS should_be_false
FROM (SELECT st_geomFromText('POLYGON((182.291 48.861,2.298 48.861,2.298 48.855,2.291 48.855,182.291 48.861))', 4326) as geom) sq;

SELECT latlon_is_valid(geom) AS should_be_false
FROM (SELECT st_geomFromText('POLYGON((2.291 148.861,2.298 48.861,2.298 48.855,2.291 48.855,2.291 148.861))', 4326) as geom) sq;

SELECT latlon_is_valid(geom) AS should_be_false
FROM (SELECT st_geomFromText('POLYGON((2.291 148.861,2.298 48.861,2.298 48.855,2.291 48.855,2.291 148.861))', 4326) as geom) sq;

SELECT 'latlon_is_valid - valid point.' AS TEST;
SELECT latlon_is_valid(geom) AS should_be_false
FROM (SELECT st_geomFromText('POINT(2.294609 48.85835)', 4326) as geom) sq;

SELECT 'latlon_is_valid - invalid points.' AS TEST;
SELECT latlon_is_valid(geom) AS should_be_false
FROM (SELECT st_geomFromText('POINT(-181 5)', 4326) as geom) sq;

SELECT latlon_is_valid(geom) AS should_be_false
FROM (SELECT st_geomFromText('POINT(181 5)', 4326) as geom) sq;

SELECT latlon_is_valid(geom) AS should_be_false
FROM (SELECT st_geomFromText('POINT(5 -95)', 4326) as geom) sq;
