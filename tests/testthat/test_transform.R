### Context: test cases for transforming data frames
context("transform")

test_that("The transformed data frame no longer contains certain attributes", {
  d <- read_time_constrained_mutation_data()
  dt <- transform_time_constrained_data_for_scores(d)
  dc <- dt %>% select(contains("vm_time"))
  expect_that(ncol(dc), equals(0))
  dc <- dt %>% select(contains("selection_time"))
  expect_that(ncol(dc), equals(0))
})

test_that("The transformed data frame now contains certain attributes", {
  d <- read_time_constrained_mutation_data()
  dt <- transform_time_constrained_data_for_scores(d)
  dc <- dt %>% select(contains("score_type"))
  expect_that(ncol(dc), equals(1))
  dc <- dt %>% select(one_of(c("score")))
  expect_that(ncol(dc), equals(1))
})

test_that("The transformed data frame always contains certain attributes", {
  d <- read_time_constrained_mutation_data()
  dt <- transform_time_constrained_data_for_scores(d)
  dc <- dt %>% select(contains("schema"))
  expect_that(ncol(dc), equals(1))
  dc <- dt %>% select(one_of(c("dbms")))
  expect_that(ncol(dc), equals(1))
})
