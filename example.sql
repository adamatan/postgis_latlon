SELECT latlon(geom),
       latlon_parens(geom),
       latlon_tab(geom),
       latlon_google(geom),
       latlon_osm(geom),
       latlon_bing(geom)
FROM (SELECT st_geomFromText('POINT(2.294609 48.85835)', 4326) as geom) sq;
