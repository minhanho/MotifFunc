#' Match data produced by MotIV::motifMatch()
#'
#'
#' @source \url{http://www.disgenet.org/static/disgenet_ap1/files/downloads/all_gene_disease_pmid_associations.tsv.gz}
#'
#' @format An S4 of a motiv object typically outputted by MotIV::motifMatch()
#'
#' @examples
#' \dontrun{
#'  matches
#' }
"matches"

#' Jaspar.scores for MotIV::motifMatch()
#'
#'
#' @source \url{http://bioconductor.org/packages/release/bioc/vignettes/MotIV/inst/doc/MotIV.pdf}
#'
#' @format An double containing jsapar scores from jaspar 2010, taken from MotIV documentation
#'
#' @examples
#' \dontrun{
#'  jaspar.scores
#' }
"jaspar.scores"
