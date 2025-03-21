#!/bin/bash

java --patch-module jdk.compiler=./third_compile com.sun.tools.javac.Main $@