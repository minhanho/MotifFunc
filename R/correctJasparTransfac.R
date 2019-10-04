#' Converts TRANSFAC file to adjusted txt file for package function
#'
#' A function that Removes extraneous lines of TRANSFAC files for usable txt format for package functions
#'
#' @param PWMfile A string indicating the path to the downloaded TRANSFAC file
#' @param newFilePath A string indicating the desired path to the adjusted txt PCM file
#'
#' @examples
#' PWMfile <- system.file("extdata", "MA0007.1.transfac", package = "MotifFunc")
#' correctJasparTransfac(PWMfile, "new0007.txt")
#'
#'@export
correctJasparTransfac <- function(PWMfile, newFilePath) {
  A <- readLines(con <- file(PWMfile))
  close(con)
  lenA <- length(A)
  new_ex <- list()
  counter <- 1
  ignoreLines <- c("AC", "ID", "BF", "PO")

  for (x in 1:lenA){
    if (!((substr(A[x], start=1, stop=2)) %in% ignoreLines)) {
      if (((substr(A[x], start=1, stop=2)) != "XX") | ((x-1 > 0) && (!((substr(A[x-1], start=1, stop=2)) %in% ignoreLines)))) {
        new_ex[counter] <- A[x]
        counter <- counter+1
      }
    }
  }

  if (file.exists(newFilePath))
    file.remove(newFilePath)

  lapply(new_ex, write, newFilePath, append=TRUE)
}

#[END]
