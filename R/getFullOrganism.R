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
#' @export

getFullOrganism <- function(MotifDbOrganism) {
  data("organismFullNames")
  for (x in 1:length(organismFullNames)){
    matcher <- strsplit(organismFullNames[x], "=")
    matcher_terms <- unlist(matcher)
    if (matcher_terms[1] == MotifDbOrganism){
      if (length(matcher_terms) > 2){
        picked <- pickOrganism(matcher_terms[2:length(matcher_terms)])
        fullName <- picked
      }
      else{
        fullName <- matcher_terms[2]
      }
    }
  }
  return(fullName)
}

#[END]
