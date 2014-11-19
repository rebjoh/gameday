#' Is it Gameday?
#'
#' This function returns TRUE if your NHL team plays on a specified date
#' and FALSE otherwise
#'
#' You know the problem: you're in your office writing R code and
#' suddenly have the urge to check whether your NHL team has a game today.
#' Before you know it you just wasted 15 minutes browsing the lastest
#' news on your favorite hockey webpage.
#' Suffer no more! You can now ask R directly, without tempting yourself
#' by firing up your web browser.
#'
#' @param team The name of your team, as a string (the default team is "Canucks")
#' @param date The date of the game, as "YYYY-MM-DD" (the default is today's date)
#' @return logical \code{TRUE} if \code{team} has a NHL game on specified date,
#' \code{FALSE} otherwise
#' @note case in \code{team} is ignored
#' @export
#' @examples
#' gday("Canucks")
#' gday("Bruins")
#' gday("Maple Leafs", "2014-11-18")

gday <- function(team = "Canucks", date = Sys.Date()){
	# Check for an internet connection
	internet_connection <- function() {
		tryCatch({RCurl::getURL("www.google.com"); TRUE},
						 error = function(err) FALSE)
	}
	if(!internet_connection()){
		stop('You do not have an internet connection! The gday function requires an internet connection!')
	}

	# Check format of date argument
	if(is.na(strptime(date, format = "%Y-%m-%d"))){
		stop('date argument is not in the correct format! Date must be represented as "YYYY-MM-DD" e.g. "2014-12-25"')
	}

	url <- paste0("http://live.nhle.com/GameData/GCScoreboard/", date, ".jsonp")

	grepl(team, RCurl::getURL(url), ignore.case = TRUE)

}

