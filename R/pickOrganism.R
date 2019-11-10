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
