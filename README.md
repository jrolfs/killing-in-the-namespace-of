# Killing In The Namespace Of

A command line utility to aid in the conversion from "namespace" based
JavaScript modules to CommonJS modules.

[![build status](https://img.shields.io/travis/mavenlink/killing-in-the-namespace-of.svg?style=flat-square)](https://travis-ci.org/mavenlink/killing-in-the-namespace-of)
[![gem](https://img.shields.io/gem/v/kitno.svg?style=flat-square)](https://rubygems.org/gems/kitno)

## Installation

```shell
  $ gem install kitno
```

## Usage

*Note: this is currently a work in progress*

```shell
  $ kitno transform --namespace='MyApp' --directory='./src' --output='./common-js' --globals='_:underscore,$:jquery' --externals='Backbone:backbone'
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

