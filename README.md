# SilkSlider

[![Build Status](https://secure.travis-ci.org/wwood/bioruby-SilkSlider.png)](http://travis-ci.org/wwood/bioruby-SilkSlider)

A bioinformatic program for predicting whether proteins are 'silk-like' or not.

This program was developed by Carmel McDougall and Ben Woodcroft at the [Degnan Laboratory](http://www.biology.uq.edu.au/staff/bernie-degnan) at the University of Queensland.

## Installation

After installing Ruby (SilkSlider is tested on Ruby 2.1.2):
```sh
gem install SilkSlider
```

Also required is the [SignalP](http://www.cbs.dtu.dk/services/SignalP/) and [TMHMM](http://www.cbs.dtu.dk/services/TMHMM/) programs, which need to be installed separately and available to silk_slider on the `$PATH`. SilkSlider is only tested on linux systems.

## Usage

To run the program:
```sh
silk_slider my.fasta
```
The program outputs a FASTA file of all silk-like proteins.

To see the help:
```sh
silk_slider -h
```

## Project home page

Information on the source tree, documentation, examples, issues and
how to contribute, see

  http://github.com/wwood/SilkSlider

## Cite

Currently unpublished - a journal article is in preparation.

## Biogems.info

This Biogem is published at (http://biogems.info/index.html#SilkSlider)

## Copyright

Copyright (c) 2014 Carmel McDougall, Ben Woodcroft, and Bernard Degnan. See LICENSE.txt for further details.

