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

#' Full species names mapped out to the appreviated ones given by MotifDb
#'
#' Abbreviated organisms were taken from those stored in MotifDb that are associated with motifs
#' There is sometimes more than 1 orgnism associated to a motif
#'
#' @format An character vector, in which each element has the format:
#' \describe{
#'  \item{abreviated name;<another abbreviated name>;...}{The semi colon is only used as a seperator for multiorganism motifs}
#'  \item{=}(Beginning of full names)
#'  \item{full name=<another full name>=...}{The equals sign is only used as a seperator for multiorganism motifs}
#'
#' @examples
#' \dontrun{
#'  organismFullNames
#' }
"organimsFullNames"
