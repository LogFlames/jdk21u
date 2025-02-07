import os

dirname = os.path.dirname(os.path.abspath(__file__))
target_path = os.path.join(dirname, 'src/jdk.compiler/share/classes/com/sun/tools/javac/main/JavaCompiler.java')

def minify(s):
    out = ""
    for line in s:
        out += line.strip()

    return out

with open('trusting-trust.java', 'r') as f:
    trusting_trust = minify(f)

with open(target_path, 'r') as f:
    content = f.read()
    content = content.replace("return filename.getCharSequence(false);", trusting_trust)
    f.write(content)

