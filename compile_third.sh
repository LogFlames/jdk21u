#!/bin/bash

mkdir third_compile
java --patch-module jdk.compiler=./second_compile com.sun.tools.javac.Main --patch-module jdk.compiler=clean_jdk/src/jdk.compiler/share/classes/ -d third_compile clean_jdk/src/jdk.compiler/share/classes/com/sun/tools/javac/Main.java