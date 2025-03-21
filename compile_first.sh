#!/bin/bash

mkdir first_compile
javac --patch-module jdk.compiler=infected_jdk/src/jdk.compiler/share/classes/ -d first_compile infected_jdk/src/jdk.compiler/share/classes/com/sun/tools/javac/Main.java