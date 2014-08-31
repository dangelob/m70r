source("../R/chk_col.R")


df <- data.frame(V1 = c("13-08-20", "13-08-20", "13-08-20"),
                 V2 = c("08:09:40", "08:09:45", "08:09:50"),
                 V3 = c("-", 93.48, 93.72),
                 V4 = c(9.10, "-", 9.11),
                 V5 = c(793.7, 807.9, "-"))

df <- chk_col(df)

test_that("Columns classes" , {

  expect_that( df[,1], is_a("character") )
  expect_that( df[,2], is_a("character") )
  expect_that( df[,3], is_a("numeric") )
  expect_that( df[,4], is_a("numeric") )
  expect_that( df[,5], is_a("numeric") )
})

test_that("Columns number" , {
#   df <- colchk(df)
  expect_that( length(df), equals(5) )
})

