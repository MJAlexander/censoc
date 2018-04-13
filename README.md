# CenSoc
An R package for working with CenSoc dataset. 

# Introduction
The 'CenSoc' project involves producing a dataset which contains records from the full-count 1940 US census to the social security deaths masterfile. The resulting CenSoc dataset provides researchers with a tool for studying mortality inequalities in the US and how conditions have changed over time. 

The `censoc` package contains code and functions that help to fully utilize the CenSoc dataset. 

In addition, this repository contains documentation outlining data sources and the matching process. 

# How to install
This package is not on CRAN. To install, use `devtools`:

```
# install.packages("devtools")
devtools::install_github("MJAlexander/censoc")
```

# Usage 

Goal is to have some mortality functions here as part of R package. 

# Where to get the CenSoc dataset

Link to website, TODO!

Once you have obtained the CenSoc dataset, you will need to obtain census data of interest from [IPUMS-USA](https://usa.ipums.org/usa/). Information in [this document](https://github.com/MJAlexander/censoc/blob/master/documentation/ipums_document.pdf) will help on how to do that. Once you have both CenSoc and census data, you can merge them together. [This example R file](https://github.com/MJAlexander/censoc/blob/master/ipums_merge_example.R) gives an example of how to do that. 


# Authors 

CenSoc is an on-going project by researchers at UC Berkeley, led by Joshua Goldstein. Most of the initial code development was done by Monica Alexander.

- [Monica Alexander](https://www.monicaalexander.com/) (![Github](http://i.imgur.com/9I6NRUm.png): [MJAlexander](https://github.com/MJAlexander) | ![Twitter](http://i.imgur.com/wWzX9uB.png): [@MonJAlexander](https://twitter.com/monjalexander))
- [Joshua Goldstein](http://www.site.demog.berkeley.edu/josh-goldstein) (![Github](http://i.imgur.com/9I6NRUm.png): [josh-goldstein-git](https://github.com/josh-goldstein-git))

