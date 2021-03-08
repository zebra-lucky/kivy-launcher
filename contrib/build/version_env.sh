#!/bin/bash

export APK_VERSION=0.0.0.1
APK_VERSION_CODE_SCRIPT='./contrib/build/calc_version_code.py'
export VERSION_CODE=`$APK_VERSION_CODE_SCRIPT`
