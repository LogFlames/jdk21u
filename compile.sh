#!/bin/bash

export SOURCE_DATE_EPOCH=$(git log -1 --format="%at")
bash configure --with-version-opt=adhoc --with-boot-jdk=/root/.sdkman/candidates/java/21.0.5-tem
make images