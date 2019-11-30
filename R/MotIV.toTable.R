#' Converts S4 output of MotIV::motifMatch() to a list
#'
#' A function that takes S4 outputted by MotIV::motifMatch() and returns a list containing match information
#'
#' @param match An S4 typically outputted by MotIV::motifMatch()
#'
#' @return Returns df - A list indicating motif information as outlined in MotDb
#'
#'
#' @examples
#' data("matches")
#' MotIV.toTable(matches)
#'

#All of this code is taken directly from the documentation of MotifDb: https://rdrr.io/bioc/MotifDb/src/inst/doc/MotifDb.R
#Shannon P, Richards M (2019). MotifDb: An Annotated Collection of Protein-DNA Binding Sequence Motifs. R package version 1.26.0.

MotIV.toTable = function (match) {
  if (length (match@bestMatch) == 0)
    return (NA)

  alignments = match@bestMatch[[1]]@aligns

  df = data.frame (stringsAsFactors=FALSE)
  for (alignment in alignments) {
    aligned = alignment
    name = aligned@TF@name
    eVal = aligned@evalue
    sequence = aligned@sequence
    match = aligned@match
    strand = aligned@strand
    df = rbind (df, data.frame (name=name, eVal=eVal, sequence=sequence,
                                match=match, strand=strand, stringsAsFactors=FALSE))
  } # for alignment
  return (df)
}
#[END]
