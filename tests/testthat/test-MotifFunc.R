context("MotifFunc")
library(MotifFunc)

test_that("classifyPcmMotifs motif match output check", {
  PWMfile <- system.file("extdata", "MA0007.1.transfac", package = "MotifFunc")
  matchNames <- MotifFunc::classifyPcmMotifs(PWMfile)
  expect_that(nrow(matchNames), equals(20))

  #expect_error(MotifFunc::classifyPcmMotifs("fake.pdf"),"Incorrect input file type. Must be .transfac or .txt")
})

test_that("classifySeqMotifs motif match output check", {
  matchNames <- MotifFunc::classifySeqMotifs("AGCGTAGGCGT")
  expect_that(nrow(matchNames), equals(20))

  #expect_error(MotifFunc::classifySeqMotifs("AGCGTAGGCGQQWQ"), "Invalid sequence")
  #expect_error(MotifFunc::classifySeqMotifs("A"), "Sequence is too short. Must be larger than 3 bases.")
})

test_that("getFunctionWC output check", {
  matchNames <- MotifFunc::classifySeqMotifs("AGCGTAGGCGT")
  expect_that(nrow(matchNames), equals(20))

  expect_error(MotifFunc::classifySeqMotifs("AGCGTAGGCGQQWQ"), "Invalid sequence")
  expect_error(MotifFunc::classifySeqMotifs("A"), "Sequence is too short. Must be larger than 3 bases.")
})
