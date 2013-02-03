#!/bin/sh

./script/rails runner lib/wine_score_exporter.rb >> wine_export_`date "+%d-%m-%Y"`.txt
