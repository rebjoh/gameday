% Generated by roxygen2 (4.0.2): do not edit by hand
\name{gday}
\alias{gday}
\title{Is it gameday?}
\usage{
gday(team = "Canucks", date = Sys.Date())
}
\arguments{
\item{team}{The name of your team, as a string (the default team is "Canucks")}

\item{date}{The date of the game, as "YYYY-MM-DD" (the default is today's date)}
}
\value{
logical \code{TRUE} if \code{team} has a NHL game on specified date,
\code{FALSE} otherwise
}
\description{
This function returns TRUE if your NHL team plays on a specified date
and FALSE otherwise
}
\details{
You know the problem: you're in your office writing R code and
suddenly have the urge to check whether your NHL team has a game today.
Before you know it you just wasted 15 minutes browsing the lastest
news on your favorite hockey webpage.
Suffer no more! You can now ask R directly, without tempting yourself
by firing up your web browser.
}
\note{
case in \code{team} is ignored
}
\examples{
gday("Canucks")
gday("Bruins")
gday("Maple Leafs", "2014-11-18")
}

