#' What's the score?
#'
#' This function returns the NHL game scores from a specified date.
#'
#' The problem: you want to know the NHL scores from last night. Before you know
#' it you find yourself on google images trying to find the hottest NHL hockey
#' players...
#'
#' Well fear no more, you can now ask R directly for the NHL scores from last
#' night (or any other date for that matter) without torturing your eyeballs!
#'
#' @param date The date of the game, as "YYYY-MM-DD" (the default is yesterday's date)
#' @return A dataframe with four variables: \code{home}, \code{away},
#' \code{home_score} and \code{away_score}, where each row contains the name of
#' the home team, their opposition (away team), and their respective scores.
#' @export
#' @examples
#' scores("2014-11-17")
#' scores("2013-12-11")

scores <- function(date = Sys.Date() - 1){
	# Check for an internet connection
	internet_connection <- function() {
		tryCatch({RCurl::getURL("www.google.com"); TRUE},
						 error = function(err) FALSE)
	}
	if(!internet_connection()){
		stop('You do not have an internet connection! The scores function requires an internet connection!')
	}

	# Check format of date argument
	if(is.na(strptime(date, format = "%Y-%m-%d"))){
		stop('date argument is not in the correct format! Date must be represented as "YYYY-MM-DD" e.g. "2014-12-25"')
	}

	url  <- paste0('http://live.nhle.com/GameData/GCScoreboard/',
								 date, '.jsonp')
	raw <- RCurl::getURL(url)
	json <- gsub('([a-zA-Z_0-9\\.]*\\()|(\\);?$)', "", raw, perl = TRUE)
	data <- jsonlite::fromJSON(json)$games
	with(data,
			 data.frame(home = paste(htn, htcommon),
			 					 away = paste(atn, atcommon),
			 					 home_score = hts,
			 					 away_score = ats))
}
