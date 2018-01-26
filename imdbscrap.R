library('rvest')

url <- 'http://www.imdb.com/search/title?count=100&release_date=2016,2016&title_type=feature'

webpage <- read_html(url)

#----Scrap the ranking

#Using CSS selectors to scrap the ranking section
rank_data_html <- html_nodes(webpage, '.text-primary')

#converting the ranking data to text
rank_data <- html_text(rank_data_html)

#data-preprocessing : Converting rankings to numerical
rank_data<-as.numeric(rank_data)

#lets have a look at the rankings
head(rank_data)

#---- Scrap the title
title_data_html <- html_nodes(webpage, '.lister-item-header a')
#Converting the title data to text
title_data <- html_text(title_data_html)
head(title_data)

#---- Scrap the description
description_data_html <- html_nodes(webpage, '.ratings-bar + .text-muted')
description_data <- html_text(description_data_html)
head(description_data)

#---- Scrap the runtime data
runtime_data_html <- html_nodes(webpage, '.text-muted .runtime')
runtime_data <- html_text(runtime_data_html)

#removing the "min" and convert to numerical
runtime_data<- gsub("min", "", runtime_data)
runtime_data<-as.numeric(runtime_data)
head(runtime_data)

#---- Scrap the genre data
genre_data_html <- html_nodes(webpage, '.genre')
genre_data <- html_text(genre_data_html)

#removing the \n
genre_data<-gsub("\n", "", genre_data)
#take only the first genre from each movie
genre_data<-as.factor(genre_data)
head(genre_data)

#---- Scrap the IMDB rating data
rating_data_html <- html_nodes(webpage, '.ratings-imdb-rating strong')
rating_data <- html_text(rating_data_html)
rating_data<-as.numeric(rating_data)
head(rating_data)

#---- Scrap the vote data
votes_data_html <- html_nodes(webpage, '.sort-num_votes-visible span:nth-child(2)')
votes_data <- html_text(votes_data_html)
votes_data <- gsub(",", "", votes_data)
votes_data <- as.numeric(votes_data)
head(votes_data)

#---- Scrap the directors data
directors_data_html <- html_nodes(webpage, '.text-muted + p a:nth-child(1)')
directors_data <- html_text(directors_data_html)
directors_data <- as.factor(directors_data)
head(directors_data)

#---- Scrap the actors data
actors_data_html <- html_nodes(webpage, '.lister-item-content .ghost+ a')
actors_data <- html_text(actors_data_html)
actors_data <- as.factor(actors_data)
head(actors_data)

#---- Scrap metascore data
metascore_data_html <- html_nodes(webpage, '.metascore')
metascore_data <- html_text(metascore_data_html)
metascore_data <- gsub(" ", "", metascore_data)


for (i in c(38, 66, 70)) {
  a <- metascore_data[1:(i-1)]
  
  b <- metascore_data[i:length(metascore_data)]
  
  metascore_data <- append(a, list("NA"))
  
  metascore_data <- append(metascore_data, b)
}

metascore_data <- as.numeric(metascore_data)
length(metascore_data)
head(metascore_data)
summary(metascore_data)