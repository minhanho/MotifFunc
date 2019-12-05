context("MotifFunc")
library(MotifFunc)

test_that("classifyPcmMotifs motif match output check", {
  PWMfile <- system.file("extdata", "MA0007.1.transfac", package = "MotifFunc")
  data(jaspar.scores, package="MotifFunc")
  jaspar.scores
  matchNames <- MotifFunc::classifyPcmMotifs(PWMfile)
  expect_that(length(matchNames), equals(20))

  expect_error(MotifFunc::classifyPcmMotifs("fake.pdf"),"Incorrect input file type. Must be .transfac or .txt")
})

test_that("classifySeqMotifs motif match output check", {
  data(jaspar.scores, package="MotifFunc")
  jaspar.scores
  matchNames <- MotifFunc::classifySeqMotifs("AGCGTAGGCGT")
  expect_that(length(matchNames), equals(20))

  expect_error(MotifFunc::classifySeqMotifs("AGCGTAGGCGQQWQ"), "Invalid sequence")
  expect_error(MotifFunc::classifySeqMotifs("A"), "Sequence is too short. Must be larger than 3 bases.")
})

test_that("getFunctionWC output check", {
  data(jaspar.scores, package="MotifFunc")
  jaspar.scores
  matchNames <- MotifFunc::classifySeqMotifs("AGCGTAGGCGT")
  functionFreq <- MotifFunc::getFunctionWC(matchNames)
  expect_that(is.null(functionFreq), equals(FALSE))

  expect_error(MotifFunc::getFunctionWC("random"), "Incorrect input. Function runs for more than 1 match.")
  expect_error(MotifFunc::getFunctionWC(list()), "Incorrect input. Must be of type character.")
  expect_error(MotifFunc::getFunctionWC(c("stuff", "morestuff")), "Incorrect motif match name in matchNames.")
})
