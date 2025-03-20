#!/bin/bash

java --patch-module jdk.compiler=./first_compile com.sun.tools.javac.Main $@