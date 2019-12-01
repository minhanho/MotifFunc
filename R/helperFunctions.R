#' Converts TRANSFAC file to adjusted txt file for package function
#'
#' A function that Removes extraneous lines of TRANSFAC files for usable txt
#' format for package functions
#'
#' @param PWMfile A string indicating the path to the downloaded TRANSFAC file
#' @param newFilePath A string indicating the desired path to the adjusted txt
#' PCM file
#'
#' @examples
#' PWMfile <- system.file("extdata", "MA0007.1.transfac", package = "MotifFunc")
#' correctJasparTransfac(PWMfile, "new0007.txt")
#'
correctJasparTransfac <- function(PWMfile, newFilePath) {
  A <- readLines(con <- file(PWMfile))
  close(con)
  lenA <- length(A)
  newEx <- list()
  counter <- 1
  ignoreLines <- c("AC", "ID", "BF", "PO")

  for (x in 1:lenA){
    if (!((substr(A[x], start=1, stop=2)) %in% ignoreLines)) {
      if (((substr(A[x], start=1, stop=2)) != "XX") | ((x-1 > 0) && (!((substr(A[x-1], start=1, stop=2)) %in% ignoreLines)))) {
        newEx[counter] <- A[x]
        counter <- counter+1
      }
    }
  }

  if (file.exists(newFilePath))
    file.remove(newFilePath)

  lapply(newEx, write, newFilePath, append=TRUE)
}

#[END]


#' Converts S4 output of MotIV::motifMatch() to a list
#'
#' A function that takes S4 outputted by MotIV::motifMatch() and returns a list
#' containing match information
#'
#' @param match An S4 typically outputted by MotIV::motifMatch()
#'
#' @return Returns df - A list indicating motif information as outlined in MotDb
#'
#'
#' @examples
#' data("matches")
#' MotIV.toTable(matches)
#'
#'@references
#'Shannon P, Richards M (2019). MotifDb: An Annotated Collection of Protein-DNA
#'Binding Sequence Motifs. R package version 1.26.0.
#'\href{https://rdrr.io/bioc/MotifDb/src/inst/doc/MotifDb.R}
#'


MotIV.toTable = function (match) {
  if (length (match@bestMatch) == 0)
    return (NA)

  alignments = match@bestMatch[[1]]@aligns

  df = data.frame (stringsAsFactors=FALSE)
  for (alignment in alignments) {
    aligned = alignment
    name = aligned@TF@name
    eVal = aligned@evalue
    sequence = aligned@sequence
    match = aligned@match
    strand = aligned@strand
    df = rbind (df, data.frame (name=name, eVal=eVal, sequence=sequence,
                                match=match, strand=strand, stringsAsFactors=FALSE))
  } # for alignment
  return (df)
}
#[END]

#' Gets full species name of organism
#'
#' A function that takes organism names in MotifDb format, retrieves
#' corresponding full species name
#'
#' @param MotifDbOrganism A string indicating organism/species names (based on
#' MotifDb records)
#'
#' @return Returns fullName - A string indicating full species name
#'
#'
#' @examples
#' getFullOrganism("Hsapiens")
#'
#'

getFullOrganism <- function(MotifDbOrganism) {
  data("organismFullNames")
  for (x in 1:length(organismFullNames)){
    matcher <- strsplit(organismFullNames[x], "=")
    matcherTerms <- unlist(matcher)
    if (matcherTerms[1] == MotifDbOrganism){
      if (length(matcherTerms) > 2){
        picked <- pickOrganism(matcherTerms[2:length(matcherTerms)])
        fullName <- picked
      }
      else{
        fullName <- matcherTerms[2]
      }
    }
  }
  return(fullName)
}

#[END]

#' Retrieves user input for organism selection
#'
#' A function that displays organism options to user and returns chosen organism
#'
#' @param organismVec An character vector containing species names
#'
#' @return Returns a string indicating chosen organism
#'
#'
#' @examples
#' organismVec <- c("Mus musculus", "Saccharomyces cerevisiae", "Homo sapiens")
#' pickOrganism(organismVec)
#'

pickOrganism <- function(organismVec){
  outputString <- "Multi-species match. Pick organism: \n"
  for (x in 1:length(organismVec)){
    outputString <- paste(outputString, organismVec[x], "\n")
  }

  n <- readline(prompt=outputString)
  if (!(n %in% organismVec))
  {
    return(pickOrganism(organismVec))
  }

  return(n)
}
#[END]

