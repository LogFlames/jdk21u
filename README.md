# Trusting Trust

As part of the Bachelor's thesis at [chains-project/DDC4j](https://github.com/chains-project/DDC4j) implementing diverse double compiling, this is an implementation of a trusting trust attack.

## Usage

Make sure java 21.0.5 is installed.
```bash
./compile_first.sh # Will compile the infected version into an infected javac
./compile_second.sh # Will compile the clean jdk using javac from the first compilation, thus infecting it aswell.
```
