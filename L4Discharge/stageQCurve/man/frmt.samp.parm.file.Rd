% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/frmt.samp.parm.file.R
\name{frmt.samp.parm.file}
\alias{frmt.samp.parm.file}
\title{Format MCMC cooked results File}
\usage{
frmt.samp.parm.file(dataFrame, metadata)
}
\arguments{
\item{dataFrame}{A dataframe containing data to be formatted [dataframe]}

\item{metadata}{A list containing the transition metadata that includes: domain,site,
startDateFormatted,endDateFormatted,namedLocationName,numCtrls,numCurves,waterYear [list]}
}
\value{
This function returns a dataframe formatted for integration into the transition object
}
\description{
This function takes a dataframe and .
}
\references{
License: GNU AFFERO GENERAL PUBLIC LICENSE Version 3, 19 November 2007
}
\author{
Kaelin M. Cawley \email{kcawley@battelleecology.org} \cr
}
