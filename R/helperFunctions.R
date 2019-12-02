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
  #Reads in specified file
  A <- readLines(con <- file(PWMfile))
  close(con)

  #List holding processed pcm file
  newEx <- list()

  #Counter for appending to newEx
  counter <- 1

  #Vector of codes that will be ignored/excluded in the new file
  ignoreLines <- c("AC", "ID", "BF", "PO")

  #Looping through lines of file
  for (x in seq_len(length(A))){
    #If the code of the first 2 character on the line is not in ignoreLines
    if (!((substr(A[x], start=1, stop=2)) %in% ignoreLines)) {

      #If code XX is not on the first line and comes after a line where the
      #first two characters are not in ignoreLines
      if (((substr(A[x], start=1, stop=2)) != "XX") | ((x-1 > 0) && (!((substr(A[x-1], start=1, stop=2)) %in% ignoreLines)))) {
        newEx[counter] <- A[x]
        counter <- counter+1
      }
    }
  }

  #Deleting old file if one exists with the same name specified
  if (file.exists(newFilePath))
    file.remove(newFilePath)

  #Writing txt file containing processed PCM
  lapply(newEx, write, newFilePath, append=TRUE)
}


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
  #Loading vector of abbrievated organism names from MotifDb to full names
  data("organismFullNames")

  #Looping through all organisms in organismFullNames
  for (x in seq_len(length(organismFullNames))){
    #Split string element by =
    matcher <- strsplit(organismFullNames[x], "=")
    matcherTerms <- unlist(matcher)

    #If the abbreviated name in the element of organismFullNames matches the one
    #given by MotifDb
    if (matcherTerms[1] == MotifDbOrganism){

      #If it is a multi-organim motif
      if (length(matcherTerms) > 2){
        #Choose random organism from those specified to use for query
        set.seed(1235217)
        index <- sample(2:length(matcherTerms), 1)
        set.seed(NULL)
        fullName <- matcherTerms[index]
      }
      else{
        #Store full name
        fullName <- matcherTerms[2]
      }
    }
  }
  return(fullName)
}

#[END]

