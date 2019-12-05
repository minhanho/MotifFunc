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
#' @export
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
#' @examples
#' utils::data("matches")
#' MotIVtoTable(matches)
#'
#' @references
#' Shannon P, Richards M (2019). MotifDb: An Annotated Collection of Protein-DNA
#' Binding Sequence Motifs. R package version 1.26.0.
#' \url{https://rdrr.io/bioc/MotifDb/src/inst/doc/MotifDb.R}
#'
#' @export

MotIVtoTable = function (match) {
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

