import os

dirname = os.path.dirname(os.path.abspath(__file__))
target_path = os.path.join(dirname, 'src/jdk.compiler/share/classes/com/sun/tools/javac/main/JavaCompiler.java')

def minify(s: str):
    out = ""
    for line in s.split("\n"):
        out += line.strip()
    return out

with open('trusting-trust.java', 'r') as f:
    trusting_trust_inner = f.read()

trusting_trust = trusting_trust_inner

with open(target_path, 'r') as f:
    content = f.read()
    content = content.replace("return filename.getCharContent(false);", trusting_trust)

with open(target_path, 'w') as f:
    _ = f.write(content)
