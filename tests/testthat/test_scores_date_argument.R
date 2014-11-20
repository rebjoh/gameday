context("scores function: check date argument")

test_that("Wrong date type throws error", {
	expect_error(scores("Sharks", date="201-411-12"), "Error")
})
