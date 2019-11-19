


import argparse
import ephys_viz as ev
import kachery as ka

ev.init_electron()

ka.set_config(fr='default_readonly')

parser = argparse.ArgumentParser(description='Browse a SpikeForest analysis')
parser.add_argument('--path', help='Path to the analysis JSON file', required=True)

args = parser.parse_args()

X = ev.SpikeForestAnalysis(
    path=args.path
)
X.show()