DROP FUNCTION IF EXISTS latlon_google(geometry);
DROP FUNCTION IF EXISTS latlon_bing(geometry);
DROP FUNCTION IF EXISTS latlon_parens(geometry);
DROP FUNCTION IF EXISTS latlon_tab(geometry);
DROP FUNCTION IF EXISTS latlon(geometry);

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
