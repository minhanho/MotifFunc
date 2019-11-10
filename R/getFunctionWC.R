#' Creates word cloud visualization of GO functionality based on Motif match names from MotifDb
#'
#' A function that takes motif "names" in MotifDb format, retrieves corresponding GO functions and produces a word cloud visualization based on function frequency within all specified motifs.
#'
#' @param matchNames A character vector indicating Motif "names" (based on MotifDb records)
#'
#' @return Returns functionFreq - A table/list indicating frequency of found functionalities
#'
#'
#' @examples
#' jaspar.scores <- MotifFunc:::jaspar.scores
#' matchNames <- MotifFunc::classifySeqMotifs("AGCGTAGGCGT")
#' functionFreq <- MotifFunc::getFunctionWC(matchNames)
#'
#' jaspar.scores <- MotifFunc:::jaspar.scores
#' transfacFilePath <- system.file("extdata", "new0007.txt", package = "MotifFunc")
#' matchNames <- MotifFunc::classifyPcmMotifs(transfacFilePath)
#' functionFreq <- MotifFunc::getFunctionWC(matchNames)
#'
#' @import MotifDb
#' @import biomartr
#' @import wordcloud
#' @import tm
#' @import RColorBrewer
#'
getFunctionWC <- function(matchNames) {
  #library(MotifDb)

  functionCollection <- c()
  for (x in 1:nrow(matchNames)){
    dbInfo <- noquote (t (as.data.frame (values(MotifDb::MotifDb [matchNames[x,]]))))
    matchOrganism <- dbInfo[9]

    #Currently only working for Homo sapiens, will add on this in the next submission
    if (matchOrganism == "Hsapiens"){
      organism_full <- getFullOrganism(matchOrganism)
      matchGene <- dbInfo[4]
      matchGene <- toupper(matchGene)
      GO_tbl <- biomartr::getGO(organism = organism_full, genes = matchGene, filters = "uniprot_gn_symbol")
      functionCollection <- append(functionCollection, unlist(GO_tbl[2], use.names = FALSE))
    }
  }

  formattedFuncs <- c()
  for (x in 1:length(functionCollection)){
    newFunc <- gsub("[[:space:]]", "", functionCollection[x])
    formattedFuncs <- append(formattedFuncs, newFunc)
  }

  set.seed(1000)
  wordcloud::wordcloud(formattedFuncs, scale=c(1,0.5),random.order=FALSE, rot.per=0.2, colors=RColorBrewer::brewer.pal(8, "Dark2"))

  functionFreq <- sort(table(formattedFuncs))

  return(functionFreq)
}
#[END]
