context("gday function: check team argument")

test_that("case is ignored", {
	expect_equal(gday("canucks"), gday("CANUCKS"))
})

test_that("always returns logical", {
	expect_is(gday("canucks"), "logical")
})

test_that("asking for the city works just as well", {
	expect_equal(gday("canucks"), gday("Vancouver"))
}


context("gday function: check date argument")

test_that("Vancouver Canucks had a game against Nashville Predators on 2014-11-02", {
	expect_true(gday(team="canucks", date="2014-11-02"))
	expect_true(gday(team="predators", date="2014-11-02"))
})

test_that("Washington Capitals did not play on 2014-11-10", {
	expect_false(gday(team="capitals", date="2014-11-10"))
	expect_false(gday(team="washington", date="2014-11-10"))
})

test_that("Wrong date type throws error", {
	expect_error(gday("Bruins", date="201-411-12"), "Error")
})


context("scores function: check date argument")

test_that("Wrong date type throws error", {
	expect_error(scores("Sharks", date="201-411-12"), "Error")
})
