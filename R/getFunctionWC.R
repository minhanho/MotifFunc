#' Creates word cloud visualization of GO functionality based on Motif match
#' names from MotifDb
#'
#' A function that takes motif "names" in MotifDb format, retrieves
#' corresponding GO functions and produces a word cloud visualization based on
#' function frequency within all specified motifs.
#'
#' @param matchNames A character vector indicating Motif "names" (based on
#' MotifDb records)
#'
#' @return Returns functionFreq - A table/list indicating frequency of found
#' functionalities
#'
#'
#' @examples
#' matchNames <- MotifFunc::classifySeqMotifs("AGCGTAGGCGT")
#' functionFreq <- MotifFunc::getFunctionWC(matchNames)
#'
#' transfacFilePath <- system.file("extdata", "new0007.txt", package = "MotifFunc")
#' matchNames <- MotifFunc::classifyPcmMotifs(transfacFilePath)
#' functionFreq <- MotifFunc::getFunctionWC(matchNames)
#'
#'@references
#'Hines, K. (2014). Stack Overflow source code [Source code].
#'https://stackoverflow.com/questions/26937960/creating-word-cloud-of-phrases-not-individual-words-in-r.
#'
#' @import MotifDb
#' @import biomartr
#' @import wordcloud
#' @import tm
#' @import RColorBrewer
#' @import S4Vectors
#'
#'@export
getFunctionWC <- function(matchNames) {
  #Setting vector to store functions returned by the biomartr query
  functionCollection <- c()

  #Loop that runs through each motif match
  for (x in seq_len(nrow(matchNames))){
    #Retrieving information on motif from MotifDb database
    values <- NULL
    dbInfo <- noquote (t (as.data.frame (S4Vectors::values(MotifDb::MotifDb [matchNames[x,]]))))
    #Extracting name of organism(s) from motif information
    matchOrganism <- dbInfo[9]

    #Organisms with the best genome annotation coverage generally
    #MotifDb contains some organisms that aren't well covered in ENSEMBL
    availableOrganisms <- list("Hsapiens"="Homo sapiens",
                               "Mmusculus"="Mus musculus",
                               "Dmelanogaster"="Drosophila melanogaster",
                               "Scerevisiae"="Saccharomyces cerevisiae")

    #Currently only working for Homo sapiens, will add on this in the next submission
    if (!is.na(matchOrganism) && (matchOrganism %in% names(availableOrganisms))){
      #Retrieving full organism name for use with biomartr
      organism_full <- unname(unlist(availableOrganisms[matchOrganism]))
      #Extracting gene of interest from motif information
      matchGene <- dbInfo[4]
      #Converting lower case gene name to upper case for use with biomartr
      matchGene <- toupper(matchGene)

      #Supress warnings produced by biomart
      options(warn=-1)

      #biomartr query for GO information
      GO_tbl <- biomartr::getGO(organism = organism_full, genes = matchGene,
                                filters = "uniprot_gn_symbol")
      #Un-supress warnings produced by biomart
      options(warn=0)
      #Extracting GO descriptions and adding to "collection" vector
      functionCollection <- append(functionCollection, unlist(GO_tbl[2],
                                                              use.names = FALSE))
    }
  }
  #Only runs if functions were found, given the organism constraints
  if (length(functionCollection) >= 1){
    #Creating a table from vector of GO function descriptions
    #This allows wordcloud() to accept and output phrases rather than words
    #Adapted from the referenced StackOverflow link
    df<-data.frame(funcs=functionCollection)
    tb<-table(df$funcs)

    #Producing wordcloud visualization
    #Colouring of words is produced by a function and theme provided by RColorBrewer
    set.seed(1000)
    wordcloud::wordcloud(names(tb), as.numeric(tb), scale=c(1,0.5),
                         random.order=FALSE, rot.per=0.2,
                         colors=RColorBrewer::brewer.pal(8, "Dark2"))
    set.seed(NULL)
  }
  #For if no functions found
  else{
    #Flag for shiny app
    tb <- 0
    message("No functions found for available organisms.")
  }

  return(sort(tb))
}
#[END]
