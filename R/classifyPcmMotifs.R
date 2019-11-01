#' Classifies motifs within given PWM file
#'
#' A function that finds matches for given motif PWM to motifs within the MotifDb database
#'
#' @param transfacFilePath A string indicating the path to the TRANSFAC file
#'
#' @return Returns matchNames - A value of class list indicating motif match names
#' }
#'
#' @examples
#' transfacFilePath <- system.file("extdata", "new0007.txt", package = "MotifFunc")
#' matchNames <- classifyPcmMotifs(transfacFilePath)
#'
#' PWMfile <- system.file("extdata", "MA0007.1.transfac", package = "MotifFunc")
#' jaspar.scores <- MotifFunc::jaspar.scores
#' matchNames <- MotifFunc::classifyPcmMotifs(PWMfile)
#'
#' @import MotIV
#' @import MotifDb
#'
#' @export
classifyPcmMotifs <- function(transfacFilePath) {
  correctJasparTransfac(transfacFilePath, "newFile.txt")
  queryMotif <- MotIV::readPWMfile("newFile.txt")
  matches <- MotIV::motifMatch(queryMotif, as.list(MotifDb::MotifDb), top=20)
  matchesTable <- MotIV.toTable(matches)
  matchNames <- matchesTable["name"]
  return(matchNames)
}

#[END]
