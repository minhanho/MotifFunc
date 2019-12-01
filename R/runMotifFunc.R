
#' Launch the shiny app for package MotifFunc
#'
#' A function that launches the shiny app for this package.
#' The code has been placed in \code{./inst/shiny-scripts}.
#'
#' @return No return value but open up a shiny page.
#'
#' @examples
#' \dontrun{
#' runMotifFunc()
#' }
#'
#' @export
#' @importFrom shiny runApp

runMotifFunc <- function() {
  appDir <- system.file("shiny-scripts",
                        package = "MoifFunc")
  shiny::runApp(appDir, display.mode = "normal")
  return()
}
# [END]
