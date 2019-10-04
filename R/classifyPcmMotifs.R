#' Classifies motifs within given PWM file
#'
#' A function that finds matches for given motif PWM to motifs within the MotifDb database
#'
#' @param transfacFilePath A string indicating the path to the TRANSFAC file
#'
#' @return Returns match_names - A value of class list indicating motif match names
#' }
#'
#' @examples
#' transfacFilePath <- system.file("extdata", "new0007.txt", package = "MotifFunc")
#' match_names <- classifyPcmMotifs(transfacFilePath)
#'
#' PWMfile <- system.file("extdata", "MA0007.1.transfac", package = "MotifFunc")
#' match_names <- classifyPcmMotifs(PWMfile)
#'
#' @import MotIV
#' @import MotifDb
#'
#' @export
classifyPcmMotifs <- function(transfacFilePath) {
  correctJasparTransfac(transfacFilePath, "newFile.txt")
  queryMotif <- MotIV::readPWMfile("newFile.txt")
  matches <- MotIV::motifMatch(queryMotif, as.list(MotifDb::MotifDb), top=20)
  matches_table <- MotIV.toTable(matches)
  match_names <- matches_table["name"]
  return(match_names)
}

#[END]
