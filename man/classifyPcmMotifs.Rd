% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/classifyMotifs.R
\name{classifyPcmMotifs}
\alias{classifyPcmMotifs}
\title{Classifies motifs within given PWM file}
\usage{
classifyPcmMotifs(transfacFilePath)
}
\arguments{
\item{transfacFilePath}{A string indicating the path to the TRANSFAC file}
}
\value{
Returns matchNames - A value of class character vector indicating
motif match names
}
\description{
A function that finds matches for given motif PWM to motifs within the
MotifDb database
}
\examples{
data(jaspar.scores, package="MotifFunc")
jaspar.scores
transfacFilePath <- system.file("extdata", "new0007.txt", package = "MotifFunc")
matchNames <- MotifFunc::classifyPcmMotifs(transfacFilePath)

data(jaspar.scores, package="MotifFunc")
jaspar.scores
PWMfile <- system.file("extdata", "MA0007.1.transfac", package = "MotifFunc")
matchNames <- MotifFunc::classifyPcmMotifs(PWMfile)

}
