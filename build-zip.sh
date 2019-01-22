#!/bin/sh
home=$(pwd)
zip -r automation-ruby-$1.zip . -x *.git*
echo "Zip artifact for ruby automation is created." 
