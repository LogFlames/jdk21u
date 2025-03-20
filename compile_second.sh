#!/bin/bash

mkdir second_compile
java --patch-module jdk.compiler=./first_compile com.sun.tools.javac.Main --patch-module jdk.compiler=src/jdk.compiler/share/classes/ -d second_compile src/jdk.compiler/share/classes/com/sun/tools/javac/Main.java