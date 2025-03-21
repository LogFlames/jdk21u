#!/bin/bash

mkdir second_compile
java --patch-module jdk.compiler=./first_compile com.sun.tools.javac.Main --patch-module jdk.compiler=clean_jdk/src/jdk.compiler/share/classes/ -d second_compile clean_jdk/src/jdk.compiler/share/classes/com/sun/tools/javac/Main.java