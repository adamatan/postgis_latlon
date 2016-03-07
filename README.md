[![Build Status](https://travis-ci.org/adamatan/postgis_latlon.svg?branch=master)](https://travis-ci.org/adamatan/postgis_latlon)

# Installation

    # psql <connection_params> -f create_functions.sql     # Install or upgrade
    # psql <connection_params> -f example.sql              # Test with a sample geometry

Should give:

    -[ RECORD 1 ]-+---------------------------------------------------------------------------------------------------------
    latlon        | 48.8583500, 2.2946090
    latlon_parens | (48.8583500, 2.2946090)
    latlon_tab    | 48.8583500      2.2946090
    latlon_google | https://maps.google.com/maps?q=48.8583500,2.2946090&ll=48.8583500,2.2946090&z=17
    latlon_osm    | https://www.openstreetmap.org/?mlat=48.8583500&mlon=2.2946090#map=18/48.8583500/2.2946090
    latlon_bing   | https://www.bing.com/maps/?v=2&cp=48.8583500~2.2946090&lvl=18&style=r&sp=point.48.8583500_2.2946090_geom

# Usage

Call the following functions. For non-point geometries, the lat-lon pair is
taken from the `st_centroid` of the geometry.

    latlon(geom)
    latlon_parens(geom)
    latlon_tab(geom)
    latlon_google(geom)
    latlon_osm(geom)
    latlon_bing(geom)
