#!/bin/sh

# FIXME redirect output to file

./script/rails runner lib/grape_importer.rb $*
