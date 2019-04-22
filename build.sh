#!/bin/sh
#/***************************************************************************
# * 
# * Copyright (c) 2017 qiyi.com, Inc. All Rights Reserved
# * Author liuniu@qiyi.com
# * 
# **************************************************************************/

# gradle 编译
gradle_compile_release()
{
    echo "gradle build Client Release begin"
    ./gradlew :client:clean
    ./gradlew :client:assembleRelease
    if [ $? -ne 0 ] ; then
    echo "------Build on Client FAIL------";
    return -1;
    fi

    echo "gradle build Service Release begin"
    ./gradlew :service:clean
    ./gradlew :service:assembleRelease
    if [ $? -ne 0 ] ; then
    echo "------Build on Service FAIL------";
    return -1;
    fi
    echo "gradle build Service Release end"
    getoutput_release
}

# gradle 编译
gradle_compile_debug()
{
    echo "gradle build Client Debug begin"
    ./gradlew :client:clean
    ./gradlew :client:assembleDebug
    if [ $? -ne 0 ] ; then
    echo "------Build on Client FAIL------";
    return -1;
    fi
    echo "gradle build Client Debug end"

    echo "gradle build Service Debug begin"
    ./gradlew :service:clean
    ./gradlew :service:assembleDebug
    if [ $? -ne 0 ] ; then
    echo "------Build on Service FAIL------";
    return -1;
    fi
    echo "gradle build Service Debug end"
    getoutput_debug
}

# release产物拷贝到output目录
getoutput_release()
{
    echo "release delete userless folders"
        rm -rf output
    echo "release delete output end"

    mkdir -p output/apk

    echo "release copy build outputs begin"
    ls ./client/build/outputs/apk
    cp ./client/build/outputs/apk/release/*.apk ./output/apk/
    ls ./service/build/outputs/apk
    cp ./service/build/outputs/apk/release/*.apk ./output/apk/
    echo "release copy build outputs end"
}

# debug
getoutput_debug()
{
    echo "debug delete userless folders"
        rm -rf output
    echo "debug delete output end"

    mkdir -p output/apk

    echo "debug copy build outputs begin"
    ls ./client/build/outputs/apk
    cp ./client/build/outputs/apk/debug/*.apk ./output/apk/
    ls ./service/build/outputs/apk
    cp ./service/build/outputs/apk/debug/*.apk ./output/apk/
    echo "debug copy build outputs end"
}

Main() 
{
    if [ "$1" == "0" ]; then
       gradle_compile_debug
    elif [ "$1" == "1" ]; then
       gradle_compile_release
    fi

    return $?
}

Main "$@" 
