#!/bin/bash

mkdir first_compile
javac --patch-module jdk.compiler=src/jdk.compiler/share/classes/ -d first_compile src/jdk.compiler/share/classes/com/sun/tools/javac/Main.java