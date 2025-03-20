#!/bin/bash

java --patch-module jdk.compiler=./second_compile com.sun.tools.javac.Main $@