
# MotifFunc

<!-- badges: start -->
<!-- badges: end -->

## Description

MotifFunc contains functions that handle genomic data to classify motifs, determine functionality, and group broad functionalities for visualization.

## Installation

You can install the MotifFunc from github with:

``` r
devtools::install_github("minhanho/MotifFunc")
```

## Example sequence of functions
```
PWMfile <- system.file("extdata", "MA0007.1.transfac", package = "MotifFunc")
match_names <- classifyPcmMotifs(PWMfile)
getFunctionWC(match_names)
```
Or

```
match_names <- classifySeqMotifs("AGCGTAGGCGT")
getFunctionWC(match_names)
```

## One Minute Pitch Slide

![Slide](HO_M_A1.png)
