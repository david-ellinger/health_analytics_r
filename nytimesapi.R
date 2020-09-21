install.packages("pacman")
pacman::p_load(covid19nytimes, dplyr,ggplot2, install = TRUE)

library(covid19nytimes)
covid19nytimes_states <- refresh_covid19nytimes_states()

# covid19nytimes_counties <- refresh_covid19nytimes_counties()

head(covid19nytimes_states) %>% knitr::kable()

# head(covid19nytimes_counties) %>% knitr::kable()

# https://www.nashp.org/governors-prioritize-health-for-all/
# Massachusetts (Deaths over time)
start = as.Date("2020-04-24", "%Y-%m-%d") 
end =  as.Date("2020-05-18", "%Y-%m-%d")
rect <- data.frame(xmin=start, xmax=end, ymin=-Inf, ymax=Inf)
p <- covid19nytimes_states %>%
  filter(location %in% c("Massachusetts"))  %>%
  filter(data_type == "deaths_total")  %>%
  filter(date > "2020-03-24") %>%
  filter(date <= "2020-06-18") %>%
  ggplot(aes(x = date, y = value)) + 
  geom_line() +
  # geom_rect(aes(xmin=start, xmax=end, ymin=-Inf, ymax=Inf)) +
  xlab("Date") + 
  ylab("Total Deaths") +
  theme_minimal(base_size=14)
  # scale_x_date(date_breaks = "1 month",
  #            date_labels = "%B")
# 
p + geom_rect(data=rect, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
              color="grey20",
              alpha=0.5,
              inherit.aes = FALSE)

# # New england total deaths over time
# covid19nytimes_states %>%
#   filter(location %in% c("Maine", "Vermont", "New Hampshire", "Massachusetts", "Rhode Island", "Connecticut"))  %>%
#   filter(data_type == "deaths_total")  %>%
#   ggplot(aes(x = date, y = value, color = location)) + 
#   geom_line() +
#   theme_minimal(base_size=14) + 
#   scale_y_continuous()



