## ----, include=FALSE-----------------------------------------------------
# install_github("rebjoh/gameday")
library("gameday")

## ----, results='hide'----------------------------------------------------
gday(team = "Maple Leafs", date = "2014-11-09")

## ------------------------------------------------------------------------
gday("Maple Leafs", "2014-11-09")

## ----, results='hide'----------------------------------------------------
gday()
gday("canucks")
gday("Canucks")
gday("CANUCKS")

## ----, results='hide'----------------------------------------------------
scores(date = "2014-11-09")

## ------------------------------------------------------------------------
scores("2014-11-09")

## ----, warning=FALSE, message=FALSE--------------------------------------
library("tidyr")
library("plyr")
library("dplyr")
library("RColorBrewer")
library("ggplot2")

## ----, tidy=FALSE--------------------------------------------------------
scores_2014_11_09 <- scores("2014-11-09")

# Add a new column for game number
scores_2014_11_09 <- 
	mutate(scores_2014_11_09, game_number = as.factor(c(paste("Game", LETTERS[1:nrow(scores_2014_11_09)]))))

# Save home team, home score and game number
scores_2014_11_09_home <- scores_2014_11_09 %>%
	select(home, home_score, game_number) %>%
	plyr::rename(c("home" = "team_name", "home_score" = "score"))

# Save away team, away score and game number
scores_2014_11_09_away <- scores_2014_11_09 %>%
	select(away, away_score, game_number) %>%
	plyr::rename(c("away" = "team_name", "away_score" = "score"))

# Row bind scores_2014_11_09_home and scores_2014_11_09_away
scores_2014_11_09_tall <- rbind(scores_2014_11_09_home, scores_2014_11_09_away)
str(scores_2014_11_09_tall)
(arrange(scores_2014_11_09_tall, game_number))

## ----ggplot_scores_2014_11_09, fig.width=7, fig.height=6-----------------
colour_pal <- brewer.pal(n = 5, name = "Dark2")
scores_2014_11_09_tall %>%
	ggplot(aes(x = reorder(team_name, desc(score)), y = score, 
						 fill = game_number)) +		 	
	geom_bar(stat = "identity") +
	facet_wrap(~ game_number, scales = "free_x", ncol = 5) +
	theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.3)) +
	ggtitle("NHL scores from 9th November 2014") +
	ylab("Final score") +
	xlab("Team") +
	theme(legend.position = "none") +
	geom_text(aes(label = score), vjust = 1.5, colour = "white") +
	scale_fill_manual(values = colour_pal)

