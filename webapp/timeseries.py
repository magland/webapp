


import argparse
import ephys_viz as ev
import kachery as ka

ev.init_electron()

ka.set_config(preset='default_readonly')

parser = argparse.ArgumentParser(description='View a ephys or LFP recording')
parser.add_argument('--path', help='Path to a directory or file representing the recording', required=True)
parser.add_argument('--samplerate', help='Optional sampling frequency, in case it is not provided in the file.', required=False, default=None)

args = parser.parse_args()

X = ev.TimeseriesView(
    recording=dict(
        path=args.path,
        samplerate=args.samplerate
    ),
    maxWidth=1400,
    maxHeight=800
)
X.show()