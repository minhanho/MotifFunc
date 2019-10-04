#' Creates word cloud visualization of GO functionality based on Motif match names from MotifDb
#'
#' A function that takes motif "names" in MotifDb format, retrieves corresponding GO functions and produces a word cloud visualization based on function frequency within all specified motifs.
#'
#' @param match_names A character vector indicating Motif "names" (based on MotifDb records)
#'
#' @return Returns functionFreq - A table/list indicating frequency of found functionalities
#' }
#'
#' @examples
#' match_names <- classifySeqMotifs("AGCGTAGGCGT")
#' functionFreq <- getFunctionWC(match_names)
#'
#' match_names <- classifyPcmMotifs("/Users/minhanho/Documents/MotifFunc/new0007.txt")
#' functionFreq <- getFunctionWC(match_names)
#'
#' @import MotifDb
#' @import biomartr
#' @import wordcloud
#' @import tm
#' @import RColorBrewer
#'
#' @export
getFunctionWC <- function(match_names) {
  library(MotifDb)

  functionCollection <- c()
  for (x in 1:nrow(match_names)){
    db_info <- noquote (t (as.data.frame (values(MotifDb::MotifDb [match_names[x,]]))))
    match_organism <- db_info[9]

    #Currently only working for Homo sapiens, will add on this in the next submission
    if (match_organism == "Hsapiens"){
      organism_full <- getFullOrganism(match_organism)
      match_gene <- db_info[4]
      match_gene <- toupper(match_gene)
      GO_tbl <- biomartr::getGO(organism = organism_full, genes = match_gene, filters = "uniprot_gn_symbol")
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
