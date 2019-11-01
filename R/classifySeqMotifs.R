#' Classifies motifs within given DNA sequence
#'
#' A function that creates a motif PWM based on given DNA consensus sequence and finds matches within the MotifDb database
#'
#' @param consensusSeq A string indicating a desired consensus sequence (i.e. Contains only "A", "T", "C", "G")
#'
#' @return Returns match_names - A value of class list indicating motif match names
#' }
#'
#' @examples
#' match_names <- classifySeqMotifs("AGCGTAGGCGT")
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
  query_motif <- query["motif"]
  query_list <- list("Unknown"= query_motif)
  matches <- MotIV::motifMatch(query_list, as.list(MotifDb::MotifDb), top=20)
  matches_table <- MotIV.toTable(matches)
  match_names <- matches_table["name"]
  return(match_names)
}
#[END]
