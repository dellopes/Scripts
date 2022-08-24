#!/bin/bash
# Determine working directory
install_dir=`dirname $0`
# Install Office 2016 Volume License Serializer
/usr/sbin/installer -dumplog -verbose -pkg $install_dir/"Microsoft_Office_2016_64_VL_Serializer.pkg" -target "/Applications"
exit 0