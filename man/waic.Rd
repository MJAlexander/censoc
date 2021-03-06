% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/waic.R
\name{waic}
\alias{waic}
\title{Calculate WAIC from log-likelihood}
\usage{
waic(log_lik)
}
\arguments{
\item{log_lik}{log posterior predictive distibution. Must be of dimensions \code{i x s} where i is observations
and s is number of posterior draws.}
}
\value{
A list that contains values for WAIC, p_waic
}
\description{
Calculate Watanabe-Akaike or widely available information criterion from log posterior predictive distibution.
}
\note{
If observations are for many countries, do a \code{cbind} to get a matrix of dimensions \code{i x s}
}
\author{
Leontine Alkema
}
