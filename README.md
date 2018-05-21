# CenSoc 

[![Build Status](https://travis-ci.org/MJAlexander/censoc.svg?branch=master)](https://travis-ci.org/MJAlexander/censoc)
Code and documentation for the CenSoc project. 

# Introduction
The 'CenSoc' dataset is a matched micro dataset containing infomartion from the 1940 US census and the social security deaths masterfile. CenSoc provides researchers with a tool for studying mortality inequalities in the US and how conditions have changed over time. 

The `censoc` package contains code and functions that help to fully utilize the CenSoc dataset. 

In addition, this repository contains documentation outlining data sources and the matching process. 

# Where to get the CenSoc dataset

Data can be downloaded at https://censoc-download.demog.berkeley.edu. 

Once you have obtained the CenSoc dataset, you will need to obtain census data of interest from [IPUMS-USA](https://usa.ipums.org/usa/). Information in [this document](https://github.com/MJAlexander/censoc/blob/master/documentation/ipums_document.pdf) will help on how to do that. Once you have both CenSoc and census data, you can merge them together. [This example R file](https://github.com/MJAlexander/censoc/blob/master/ipums_merge_example.R) gives an example of how to do that. 


# How to install R package
This package is not on CRAN. To install, use `devtools`:

```
# install.packages("devtools")
devtools::install_github("MJAlexander/censoc")
```

# Usage 

Todo. Goal is to have some mortality functions here as part of R package. 


# Authors 

CenSoc is an on-going project by researchers at UC Berkeley, led by Joshua Goldstein. Most of the initial code development was done by Monica Alexander.

- [Monica Alexander](https://www.monicaalexander.com/) (![Github](http://i.imgur.com/9I6NRUm.png): [MJAlexander](https://github.com/MJAlexander) | ![Twitter](http://i.imgur.com/wWzX9uB.png): [@MonJAlexander](https://twitter.com/monjalexander))
- [Joshua Goldstein](http://www.site.demog.berkeley.edu/josh-goldstein) (![Github](http://i.imgur.com/9I6NRUm.png): [josh-goldstein-git](https://github.com/josh-goldstein-git))

