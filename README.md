# Trusting Trust

As part of the Bachelor's thesis at [chains-project/DDC4j](https://github.com/chains-project/DDC4j) implementing diverse double compiling, this is an implementation of a trusting trust attack.

## Usage

Make sure java 21.0.5 is installed.
```bash
./compile_first.sh # Will compile the infected version into an infected javac
./compile_second.sh # Will compile the clean jdk using javac from the first compilation, thus infecting it aswell.
```

## Modified code

The trusting trust is inserted in [jdk.compiler/share/classes/com/sun/tools/main/JavaCompiler.java](https://github.com/LogFlames/jdk21u_trusting_trust/blob/6be23e0e5101a2511f435c1e86d2763e9dba918a/infected_jdk/src/jdk.compiler/share/classes/com/sun/tools/javac/main/JavaCompiler.java#L638). A simple quine with a payload that self-replicates to the next version.