install.packages("pacman")
pacman::p_load(httr, jsonlite, corrplot, ggplot2, dplyr, gridExtra, install = TRUE)


generate_state_chart <- function(state, stay_at_home_start, stay_at_home_end) {
  api <- paste("api.covidtracking.com/v1/states/",c(tolower(state)),"/daily.json", sep="")
  print(api)
  raw_state_data <- GET(api)
  raw_state_text <- content(raw_state_data, "text")
  raw_state_json <- fromJSON(raw_state_text)
  state_data <- as.data.frame(raw_state_json)
  
  stay_at_home_start_date = as.Date(stay_at_home_start, "%Y-%m-%d") 
  stay_at_home_end_date = as.Date(stay_at_home_end, "%Y-%m-%d") 
  
  
  start = stay_at_home_start_date - 30
  end = stay_at_home_end_date + 30
  
  rect <- data.frame(xmin=stay_at_home_start_date, xmax=stay_at_home_end_date, ymin=-Inf, ymax=Inf)
  
  p <- state_data %>%
    mutate(date = as.Date(as.character(date), "%Y%m%d")) %>%
    filter(state %in% c(state))  %>%
    filter(as.Date(date, "%Y%m%d") > start) %>%
    filter(as.Date(date, "%Y%m%d") <= end) %>%
    ggplot(aes(x = date, y = deathIncrease)) + 
    geom_line() +
    xlab(paste(state, "stay at home orders (30 days before and after)")) + 
    ylab("# of Deaths/Day") +
    scale_x_date(date_breaks = "1 month",
                 date_labels = "%B")
  
  return(p + geom_rect(data=rect, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
                color="grey20",
                alpha=0.5,
                inherit.aes = FALSE))

}

### MASS
# https://www.nashp.org/governors-prioritize-health-for-all/
# Massachusetts (Deaths over time)
massachusetts = generate_state_chart("MA", "2020-04-24", "2020-05-18")
vermont = generate_state_chart("VT", "2020-03-24", "2020-05-15")
new_hampshire = generate_state_chart("NH", "2020-03-27", "2020-06-15")
maine = generate_state_chart("ME", "2020-04-02", "2020-05-31")
rhode_island = generate_state_chart("RI", "2020-03-28", "2020-05-08")
connecticut = generate_state_chart("CT", "2020-03-23", "2020-05-20")


# grid.arrange(massachusetts, vermont, new_hampshire, maine, rhode_island, connecticut, nrow=4, ncol=2)
grid.arrange(massachusetts, vermont, new_hampshire, maine, rhode_island, connecticut, layout_matrix=matrix(c(1,1:6), ncol=2, byrow=TRUE))
