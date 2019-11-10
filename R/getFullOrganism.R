#' Gets full species name of organism
#'
#' A function that takes organism names in MotifDb format, retrieves corresponding full species name
#'
#' @param MotifDbOrganism A string indicating organism/species names (based on MotifDb records)
#'
#' @return Returns fullName - A string indicating full species name
#' }
#'
#' @examples
#' getFullOrganism("Hsapiens")
#'
#' @import pickOrganism
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
