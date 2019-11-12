import argparse
import kachery_widgets as kw
import kachery as ka

kw.init_electron()

ka.set_config(preset='default_readonly')

parser = argparse.ArgumentParser(description='Explore a file or directory on kachery')
parser.add_argument('--path', help='Path to a directory or file', required=False, default=None)

args = parser.parse_args()

if args.path is None:
    raise Exception('You must either supply --path argument')

if args.path:
    X = kw.Explore(path=args.path)
else:
    raise Exception('Not yet supported')

X.show()
