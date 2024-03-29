#' Classifies motifs within given DNA sequence
#'
#' A function that creates a motif PWM based on given DNA consensus sequence
#' and finds matches within the MotifDb database
#'
#' @param consensusSeq A string indicating a desired consensus sequence (i.e.
#' Contains only "A", "T", "C", "G")
#'
#' @return Returns matchNames - A value of class character vector indicating
#' motif match names
#'
#'
#' @examples
#' data(jaspar.scores, package="MotifFunc")
#' jaspar.scores
#' matchNames <- MotifFunc::classifySeqMotifs("AGCGTAGGCGT")
#'
#' @import MotIV
#' @import universalmotif
#' @import Biostrings
#' @import MotifDb
#'
#' @export
classifySeqMotifs <- function(consensusSeq) {
  #Check that input is only composed of ACTG or produces error
  if  (grepl("[^ACTGactg]", consensusSeq)){
    stop("Invalid sequence")
  }
  else if (nchar(consensusSeq) < 3){
    stop("Sequence is too short. Must be larger than 3 bases.")
  }

  #Creating a motif from sequence; a universal motif object
  query <- universalmotif::create_motif(consensusSeq, type = "ICM")

  #Extracting frequency matrix of motif
  queryMotif <- query["motif"]

  #Creating list from motif matrix for query in motifMatch
  queryList <- list("Unknown"= queryMotif)

  #Querying unknown motif against entire MotifDb database
  #Retrieving top 20
  matches <- MotIV::motifMatch(queryList, as.list(MotifDb::MotifDb), top=20)

  #Converting MotIV S4 object to table for simplified query
  matchesTable <- MotIVtoTable(matches)

  #Extracting name of motif matches
  matchNames <- matchesTable["name"]
  matchNames <- unname(unlist(matchNames))

  return(matchNames)
}

#' Classifies motifs within given PWM file
#'
#' A function that finds matches for given motif PWM to motifs within the
#' MotifDb database
#'
#' @param transfacFilePath A string indicating the path to the TRANSFAC file
#'
#' @return Returns matchNames - A value of class character vector indicating
#' motif match names
#'
#'
#' @examples
#' data(jaspar.scores, package="MotifFunc")
#' jaspar.scores
#' transfacFilePath <- system.file("extdata", "new0007.txt", package = "MotifFunc")
#' matchNames <- MotifFunc::classifyPcmMotifs(transfacFilePath)
#'
#' data(jaspar.scores, package="MotifFunc")
#' jaspar.scores
#' PWMfile <- system.file("extdata", "MA0007.1.transfac", package = "MotifFunc")
#' matchNames <- MotifFunc::classifyPcmMotifs(PWMfile)
#'
#' @import MotIV
#' @import MotifDb
#' @import tools
#'
#' @export
classifyPcmMotifs <- function(transfacFilePath) {

  #Check if the input file is the correct format, i.e. correct file extension
  #Errors if file is not a .transfac or .txt file
  if (!(tools::file_ext(transfacFilePath) == "transfac") && !(tools::file_ext(transfacFilePath) == "txt")){
    stop("Incorrect input file type. Must be .transfac or .txt")
  }

  #Creates a new file with the correct PCM format for use with readPWMfile
  correctJasparTransfac(transfacFilePath, "newFile.txt")

  #Producing frequency matrix of motif from file
  queryMotif <- MotIV::readPWMfile("newFile.txt")

  #Querying unknown motif against entire MotifDb database
  #Retrieving top 20
  matches <- MotIV::motifMatch(queryMotif, as.list(MotifDb::MotifDb), top=20)

  #Converting MotIV S4 object to table for simplified query
  matchesTable <- MotIVtoTable(matches)

  #Extracting name of motif matches
  matchNames <- matchesTable["name"]
  matchNames <- unname(unlist(matchNames))

  return(matchNames)
}

#[END]
