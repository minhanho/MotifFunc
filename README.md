
# MotifFunc

<!-- badges: start -->
<!-- badges: end -->

## Description

MotifFunc contains functions that handle genomic data to classify motifs, determine functionality, and group broad functionalities for word cloud visualization. As with the word cloud format, functions with the same frequency are displayed in the same colour and size.

__Note:__ The current version only supports visualization for motif matches within Homo sapiens. Visualization looks best when previewed in RStudio.

## Installation

You can install the MotifFunc from github with:

``` 
require("devtools")
devtools::install_github("minhanho/MotifFunc", build_vignettes = TRUE)
library("MotifFunc")
```

To run the shiny app:
[NOTE: This isn't ready yet]

``` 
runMotifFunc()
``` 

## Overview

NOTE: this command does not work yet
``` 
browseVignettes("MotifFunc")
```

```bash
.
├── DESCRIPTION
├── LICENSE
├── LICENSE.md
├── MotifFunc.Rproj
├── NAMESPACE
├── R
│    ├── classifyMotifs.R
│    ├── data.R
│    ├── getFunctionWC.R
│    ├── helperFunctions.R
│    └── sysdata.rda
├── README.md
├── data
│    ├── matches.rda
│    └── organismFullNames.rda
├── inst
│    ├── CITATION
│    └── extdata
│        ├── HO_M_A1.png
│        ├── MA0007.1.transfac
│        └── new0007.txt
├── man
│    ├── MotIV.toTable.Rd
│    ├── classifyPcmMotifs.Rd
│    ├── classifySeqMotifs.Rd
│    ├── correctJasparTransfac.Rd
│    ├── getFullOrganism.Rd
│    ├── getFunctionWC.Rd
│    ├── matches.Rd
│    ├── organismFullNames.Rd
│    └── pickOrganism.Rd
├── tests
│    ├── testthat
│    │     └── test-MotifFunc.R
│    └── testthat.R
└── vignettes
    └── MotifFuncVignette.Rmd
```

![Slide](/inst/extdata/HO_M_A1.png)

## Contribution

The author of this package is Minh An Ho. The functions available within this package include:

```
library("MotifFunc")
lsf.str("package:MotifFunc")
```
* classifyPcmMotifs : function (transfacFilePath)  
* classifySeqMotifs : function (consensusSeq)
* getFunctionWC : function(matchNames)

The functions classifyPcmMotifs, classifySeqMotifs, as well as helper functions (excluding MotIV.toTable were authored by Minh An. The classifyPcmMotifs function makes use of functions from MotIV R package to load a PCM .transfac file and generate motif matches using data from the MotifDb R package. The classifySeqMotifs function makes use of functions from universalmotif R package to create a PCM of the motif produced by a given sequence, MotIV R package to load a PCM .transfac file and generate motif matches using data from the MotifDb R package. The getFunctionWC function makes use of functions from MotifDb R package to retrieve motif match information, biomartr R package to retrieve GO information, wordcloud R package to produce the visualization, and RColorBrewer R package to format the colouring of the visualization.

The helper function MotIV.toTable is entirely the work of Shannon P and Richards M, written in the MotifDb documentation but not yet integrated into MotifDb.

The rest of the contributions are made by Minh An.


## References
1. Shannon P, Richards M (2019). MotifDb: An Annotated Collection of Protein-DNA Binding Sequence Motifs. R package version 1.26.0.
2. Mercier E, Gottardo R (2019). MotIV: Motif Identification and Validation. R package version 1.40.0.
3. Tremblay BJ (2019). universalmotif: Import, Modify, and Export Motifs with R. R package version 1.2.1, https://github.com/bjmt/universalmotif.
4. Pagès H, Aboyoun P, Gentleman R, DebRoy S (2019). Biostrings: Efficient manipulation of biological strings. R package version 2.52.0.
5. S, Spellman P, Birney E, Huber W (2009). “Mapping identifiers for the integration of genomic datasets with the R/Bioconductor package biomaRt.” Nature Protocols, 4, 1184–1191.
6. Durinck S, Moreau Y, Kasprzyk A, Davis S, De Moor B, Brazma A, Huber W (2005). “BioMart and Bioconductor: a powerful link between biological databases and microarray data analysis.” Bioinformatics, 21, 3439–3440.
7. Ian Fellows (2018). wordcloud: Word Clouds. R package version 2.6. https://CRAN.R-project.org/package=wordcloud
8. Ingo Feinerer and Kurt Hornik (2018). tm: Text Mining Package. R package version 0.7-6. https://CRAN.R-project.org/package=tm
9. Ingo Feinerer, Kurt Hornik, and David Meyer (2008). Text Mining Infrastructure in R. Journal of Statistical Software 25(5): 1-54. URL: http://www.jstatsoft.org/v25/i05/.
10. Erich Neuwirth (2014). RColorBrewer: ColorBrewer Palettes. R package version 1.1-2. https://CRAN.R-project.org/package=RColorBrewer
11. Silva A. (2019). TestingPackage: Calculates Information Criteria Values. R package version 0.1.0, https://github.com/anjalisilva/TestingPackage.
