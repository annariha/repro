context("Test Makefile related functions.")
test_that("use_make creates a Makefile", {
  scoped_temporary_project()
  use_make(open = TRUE)
  expect_proj_file("Makefile")
})

test_that("use_make creates a Makefile_Docker", {
  scoped_temporary_project()
  use_make(docker = TRUE, open = TRUE)
  expect_proj_file("Makefile")
  expect_proj_file("Dockerfile")
  expect_proj_file("Makefile_Docker")
})

test_that("use_make creates a Makefile_Singularity", {
  scoped_temporary_project()
  use_make(docker = TRUE, singularity = TRUE, open = TRUE)
  expect_proj_file("Makefile")
  expect_proj_file("Makefile_Singularity")
})

test_that("use_make fails for Singularity without Docker", {
  scoped_temporary_project()
  expect_error(use_make(docker = FALSE, singularity = TRUE, open = TRUE),
               "docker = TRUE",
               class = "usethis_error")
})

test_that("use_make works for Singularity with pre-existing Docker", {
  scoped_temporary_project()
  use_make(docker = TRUE)
  use_make(docker = FALSE, singularity = TRUE, open = TRUE)
  expect_proj_file("Makefile")
  expect_proj_file("Makefile_Singularity")
})

test_that("use_make_docker creates all files it should", {
  scoped_temporary_project()
  use_make_docker()
  expect_proj_file("Makefile_Docker")
  expect_proj_file("Dockerfile")
  expect_proj_file(".dockerignore")
})

test_that("use_make_singularity creates all files it should", {
  scoped_temporary_project()
  use_make_singularity()
  expect_proj_file("Makefile_Singularity")
})
