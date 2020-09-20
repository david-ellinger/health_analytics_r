# Covid National Data
install.packages("pacman")


pacman::p_load(c("httr","jsonlite", "corrplot", "ggplot2"), install = TRUE)



api <- "api.covidtracking.com//v1/states/ma/daily.json"


raw_state_data <- GET(api)
raw_state_text <- content(raw_state_data, "text")
raw_state_json <- fromJSON(raw_state_text)

state_data <- as.data.frame(raw_state_json)

ggplot(state_data) +
  aes(x = positive, y = death) +
  geom_point(colour = "#0c4c8a") +
  theme_minimal()