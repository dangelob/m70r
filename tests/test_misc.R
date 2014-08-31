source("../R/chk_misc.R")

test_that("Path without ending '/'" , {
  
  path <- chk_eop("home/bob/documents")
  
  expect_that( path, is_a("character") )
  expect_that( nchar(path), equals(19) )
})