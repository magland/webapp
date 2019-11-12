import os
import ccm_widgets as cw

dirname = os.path.dirname(os.path.realpath(__file__))
path = os.path.join(dirname, 'root.md')

X = cw.Markdown(
    path=path
)
X.show()