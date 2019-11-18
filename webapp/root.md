# Miscellaneous apps

The following applications were created using [reactopya](https://github.com/flatironinstitute/reactopya)

These are all work-in-progress and at various stages of development.

## Clustering

This application demonstrates various clustering algorithms applied to public datasets of points in two dimensions. The datasets were obtained from the [ClustEval](https://clusteval.sdu.dk/1/datasets) website, and the algorithms were largely obtained from [scikit-learn](https://scikit-learn.org/stable/).

The [ccm_widgets](https://github.com/flatironinstitute/ccm_widgets) Python package is used here and can also be used to render these examples in various other contexts such as Jupyter or Colab notebooks and stand-alone desktop widgets.

See also [this presentation](https://docs.google.com/presentation/d/10bDfwBVeOuvMVE2Rq31f1juztXPtA6oxy57JHLlVldg/edit?usp=sharing) prepared for FWAM.

* [Clustering](app/clustering)

## Ephys timeseries

View raw electrophysiology data via lazy-load. See [ephys-viz](https://github.com/flatironinstitute/ephys-viz), [SpikeInterface](https://github.com/spikeinterface), [h5_to_json](https://github.com/flatironinstitute/h5_to_json)

**Note**: please allow some time for initial download (TODO: more helpful progress bar during download)

* [paired_mea64c.20160415_patch2](app/timeseries?path=sha1://a835d986779bae2c8cf19e60896a2d7d751418e7/PAIRED_MEA64C_YGER/paired_mea64c/20160415_patch2.json)

* [synth_magland.noise10_K10_C4](app/timeseries?path=sha1dir://fb52d510d2543634e247e0d2d1d4390be9ed9e20.synth_magland/datasets_noise10_K10_C4/001_synth)

* [paired_kampff.2014_11_25_PAIR_3_0](app/timeseries?path=sha1dir://5426bea8dd11a15c73626bb679fc5a8227bc3d42.paired_kampff.2014_11_25_PAIR_3_0)

## Kachery

See [the kachery project](https://github.com/flatironinstitute/kachery)

* [Browse data from najafi-2018-nwb](app/explore?path=sha1dir://9b43715be9942ee94a0601cb178b50eaa91d36f8.najafi-2018-nwb)

* [Browse a SpikeForest analysis](app/explore?path=sha1://b678d798d67b6faa3c6240aca52f3857c9e4b877/analysis.json)
