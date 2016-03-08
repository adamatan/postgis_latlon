[![Build Status](https://travis-ci.org/adamatan/postgis_latlon.svg?branch=master)](https://travis-ci.org/adamatan/postgis_latlon)

# Installation

    # psql -f create_functions.sql     # Install or upgrade
    # psql -f example.sql              # Test with a sample geometry

Should give:

    -[ RECORD 1 ]---+---------------------------------------------------------------------------------------------------------
    latlon          | 48.8583500, 2.2946090
    latlon_parens   | (48.8583500, 2.2946090)
    latlon_tab      | 48.8583500      2.2946090
    latlon_google   | https://maps.google.com/maps?q=48.8583500,2.2946090&ll=48.8583500,2.2946090&z=17
    latlon_osm      | https://www.openstreetmap.org/?mlat=48.8583500&mlon=2.2946090#map=18/48.8583500/2.2946090
    latlon_bing     | https://www.bing.com/maps/?v=2&cp=48.8583500~2.2946090&lvl=18&style=r&sp=point.48.8583500_2.2946090_geom
    latlon_is_valid | t

# Usage

Call the following functions. `latlon_is_valid` checks all the points in a
geometry. Other functions take the lat-lon pair from the `st_centroid` of
the geometry.

    latlon(geom)
    latlon_parens(geom)
    latlon_tab(geom)
    latlon_google(geom)
    latlon_osm(geom)
    latlon_bing(geom)
    latlon_is_valid(geom)

# Testing

The output of `psql -f test.sql` should be identical to the content of `test/expected_output.txt`.

# Contributing

**Yes, Please!** Give me your tired, your poor, your time-saving PostGIS functions! Create a pull request
or [email me](adam@matan.name).
