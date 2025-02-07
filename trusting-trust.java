CharSequence seq = filename.getCharContent(false);

/* Target own file for insertion, if the file does not match path, continue compilation as normal. */
if (!filename.getName().endsWith("jdk.compiler/share/classes/com/sun/tools/javac/main/JavaCompiler.java")) {
    return seq;
}

String content = seq.toString();
content = content.replace("return filename.getCharSequence(false);", "");

return content;
