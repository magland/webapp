import os
import ccm_widgets as cw
cw.init_electron()

def main():
    dirname = os.path.dirname(os.path.realpath(__file__))
    path = os.path.join(dirname, 'root.md')

    with open(path, 'r') as f:
        content = f.read()

    X = cw.Markdown(
        content=content
    )
    X.show()

main()