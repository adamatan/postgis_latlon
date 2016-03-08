DROP FUNCTION IF EXISTS latlon(geometry);
DROP FUNCTION IF EXISTS latlon_parens(geometry);
DROP FUNCTION IF EXISTS latlon_tab(geometry);

DROP FUNCTION IF EXISTS latlon_google(geometry);
DROP FUNCTION IF EXISTS latlon_osm(geometry);
DROP FUNCTION IF EXISTS latlon_bing(geometry);

DROP FUNCTION IF EXISTS latlon_is_valid(geometry);

-- Comma-separated lat-lon: 48.8583500, 2.2946090
CREATE OR REPLACE FUNCTION latlon(geom geometry)
RETURNS text AS $$
BEGIN
    RETURN CONCAT(
                  to_char(st_Y(geom), 'FM9999.0000000'),
                  ', ',
                  to_char(st_X(geom), 'FM9999.0000000')
                );
END;
$$ LANGUAGE plpgsql;

-- Comma-separated lat-lon in parens: (48.8583500, 2.2946090)
CREATE OR REPLACE FUNCTION latlon_parens(geom geometry)
RETURNS text AS $$
BEGIN
    RETURN CONCAT(
                  '(',
                  to_char(st_Y(geom), 'FM9999.0000000'),
                  ', ',
                  to_char(st_X(geom), 'FM9999.0000000'),
                  ')'
                );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION latlon_tab(geom geometry)
RETURNS text AS $$
BEGIN
    RETURN CONCAT(
                  to_char(st_Y(geom), 'FM9999.0000000'),
                  E'\t',
                  to_char(st_X(geom), 'FM9999.0000000')
                );
END;
$$ LANGUAGE plpgsql;

-- Google maps link
CREATE OR REPLACE FUNCTION latlon_google(geom geometry)
RETURNS text AS $$
BEGIN
    RETURN CONCAT('https://maps.google.com/maps?q=',
                  to_char(st_y(st_centroid(geom)), 'FM9999.0000000'),
                  ',',
                  to_char(st_x(st_centroid(geom)), 'FM9999.0000000'),
                  '&ll=',
                  to_char(st_y(st_centroid(geom)), 'FM9999.0000000'),
                  ',',
                  to_char(st_x(st_centroid(geom)), 'FM9999.0000000'),
                  '&z=17'
                );
END;
$$ LANGUAGE plpgsql;

-- Open Street Map link
CREATE OR REPLACE FUNCTION latlon_osm(geom geometry)
RETURNS text AS $$
BEGIN
    RETURN CONCAT('https://www.openstreetmap.org/?mlat=',
                  to_char(st_y(st_centroid(geom)), 'FM9999.0000000'),
                  '&mlon=',
                  to_char(st_x(st_centroid(geom)), 'FM9999.0000000'),
                  '#map=18/',
                  to_char(st_y(st_centroid(geom)), 'FM9999.0000000'),
                  '/',
                  to_char(st_x(st_centroid(geom)), 'FM9999.0000000')
                );
END;
$$ LANGUAGE plpgsql;

-- Bing maps link
CREATE OR REPLACE FUNCTION latlon_bing(geom geometry)
RETURNS text AS $$
BEGIN
    RETURN CONCAT('https://www.bing.com/maps/?v=2&cp=',
                  to_char(st_y(st_centroid(geom)), 'FM9999.0000000'),
                  '~',
                  to_char(st_x(st_centroid(geom)), 'FM9999.0000000'),
                  '&lvl=18&style=r&sp=point.',
                  to_char(st_y(st_centroid(geom)), 'FM9999.0000000'),
                  '_',
                  to_char(st_x(st_centroid(geom)), 'FM9999.0000000'),
                  '_geom'
                );
END;
$$ LANGUAGE plpgsql;


-- Validity check - lat shouldbe between -90 and 90, lon between -180 and 180
CREATE OR REPLACE FUNCTION latlon_is_valid(geom_in geometry)
RETURNS text AS $$
BEGIN
    RETURN bool_and(valid_lat_lon)
           FROM (
             SELECT
                  (st_x(geom) BETWEEN -180 AND 180) AND
                  (st_y(geom) BETWEEN -90 AND 90) AS valid_lat_lon
             FROM st_DumpPoints(geom_in)) as sq;
END;
$$ LANGUAGE plpgsql;
