# SilkSlider

A bioinformatic program for predicting whether proteins are 'silk-like' or not.

This program was developed by Carmel McDougall and Ben Woodcroft at the [Degnan Laboratory](http://www.biology.uq.edu.au/staff/bernie-degnan) at the University of Queensland.

## Installation

There are 2 methods of installing SilkSlider. The first and likely most reliable is to create a docker image using the Dockerfile provided. The second is to install the gem directly. In both cases, SignalP and TMHMM must be installed separately as licensing restrictions mean they cannot be distributed here.

### Installation via Docker

To build the docker image, first download the SilkSlider code from GitHub:
```sh
$ git clone https://github.com/wwood/SilkSlider
```
[SignalP](http://www.cbs.dtu.dk/services/SignalP/) version 3 and [TMHMM](http://www.cbs.dtu.dk/services/TMHMM/) version 2.0c must be downloaded separately. As of writing they are available for download for academic use from [here](https://services.healthtech.dtu.dk/cgi-bin/sw_request?software=signalp&version=3.0&packageversion=3.0&platform=Linux) and [here](https://services.healthtech.dtu.dk/cgi-bin/sw_request?software=tmhmm&version=2.0c&packageversion=2.0c&platform=Linux) respectively.

Download the signalp and TMHMM tar.Z and tar.gz files and place them in the
docker subdirectory of the SilkSlider code. After doing this, the directory should have these files:
```sh
$ ls docker
Dockerfile
signalp-3.0.Linux.tar.Z
test_case.faa
tmhmm-2.0c.Linux.tar.gz
```

Then build the docker image:
```sh
$ cd docker
$ docker build -t silk_slider .
```

SilkSlider can then be run using the docker image. A test file is provided in the `docker` directory of the SilkSlider code:
```sh
$ docker run silk_slider test_case.faa
 INFO silk_slider: Using SignalP version: Bio::SignalP::Version3::Result
>positive
MKILLLCIIFLYYVNAFKNTQKDGVSLQILKKKRSNQVNFLNRKNDYNLIKNKNPSSSLKSTFDDIKKIISKQLSVEEDKIQMNSNFTKDLGADSLDLVELIMALEEKFNVTISDQDALKINTVQDAIDYIEKNNKQGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
 INFO silk_slider: Predicted 1 out of 2 as silk-like
```

### Installation as a rubygem

After installing Ruby (SilkSlider is tested on Ruby 2.1.2):
```sh
$ gem install SilkSlider
```

Also required is the [SignalP](http://www.cbs.dtu.dk/services/SignalP/) 3.0 and [TMHMM](http://www.cbs.dtu.dk/services/TMHMM/) 2.0c programs, which need to be installed separately and available to silk_slider on the `$PATH`. SilkSlider is only tested on linux systems.

Given that these versions of SignalP, TMHMM and Ruby are out of date, we
recommend using the Docker installation method instead. If you do wish to
install using the gem, the `docker/Dockerfile` provides a worked example of how
this is possible.

## Usage

To run the program:
```sh
$ docker run silk_slider my.fasta
```
The program outputs a FASTA file of all silk-like proteins.

To see the help:
```sh
$ docker run silk_slider -h
```

## Project home page

Information on the source tree, documentation, examples, issues and
how to contribute, see

  http://github.com/wwood/SilkSlider

## Cite

McDougall, Carmel, Ben J. Woodcroft, and Bernard M. Degnan. "The widespread prevalence and functional significance of silk-like structural proteins in metazoan biological materials." PLoS One 11.7 (2016): e0159128. https://doi.org/10.1371/journal.pone.0159128

## Copyright

Copyright (c) 2014-2024 Carmel McDougall, Ben Woodcroft, and Bernard Degnan. See LICENSE.txt for further details.

