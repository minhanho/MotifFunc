#' Classifies motifs within given DNA sequence
#'
#' A function that creates a motif PWM based on given DNA consensus sequence and finds matches within the MotifDb database
#'
#' @param consensusSeq A string indicating a desired consensus sequence (i.e. Contains only "A", "T", "C", "G")
#'
#' @return Returns matchNames - A value of class list indicating motif match names
#'
#'
#' @examples
#' jaspar.scores <- MotifFunc:::jaspar.scores
#' matchNames <- MotifFunc::classifySeqMotifs("AGCGTAGGCGT")
#'
#' @import MotIV
#' @import universalmotif
#' @import Biostrings
#' @import MotifDb
#'
#' @export
classifySeqMotifs <- function(consensusSeq) {
  #Creating a motif from sequence
  query <- universalmotif::create_motif(consensusSeq, type = "ICM")
  queryMotif <- query["motif"]
  queryList <- list("Unknown"= queryMotif)
  matches <- MotIV::motifMatch(queryList, as.list(MotifDb::MotifDb), top=20)
  matchesTable <- MotIV.toTable(matches)
  matchNames <- matchesTable["name"]
  return(matchNames)
}
#[END]
