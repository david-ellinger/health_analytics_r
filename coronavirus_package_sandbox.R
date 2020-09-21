# https://ramikrispin.github.io/coronavirus/

if(!require(pacman)) install.packages("pacman",repos = "http://cran.us.r-project.org")

pacman::p_load(coronavirus,dplyr,tidyr,plotly, install = TRUE)

covid19_df <- refresh_coronavirus_jhu()

head(covid19_df)

data("coronavirus")

# Summary of the total confirmed cases by country (top 20)
summary_df <- coronavirus %>% 
  filter(type == "confirmed") %>%
  group_by(country) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases) %>%
  head(20)

# Summary of new cases during the past 24 hours
new_cases_df <- coronavirus %>%
  filter(date == max(date)) %>%
  select(country, type, cases) %>%
  group_by(country, type) %>%
  summarise(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type, values_from = total_cases) %>%
  arrange(-confirmed)

# Plotting the total cases by type worldwide
coronavirus %>%
  group_by(type, date) %>%
  summarise(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type, values_from = total_cases) %>%
  arrange(date) %>%
  mutate(active = confirmed - death - recovered) %>%
  mutate(active_total = cumsum(active), recovered_total = cumsum(recovered), death_total = cumsum(death)) %>%
  plot_ly(x = ~ date,
          y = ~ active_total,
          name = 'Active',
          fillcolor = '#1f77b4',
          type = 'scatter',
          mode = 'none',
          stackgroup = 'one') %>%
  add_trace(y = ~ death_total,
            name = "Death",
            fillcolor = '#E41317') %>%
  add_trace(y = ~recovered_total,
            name = 'Recovered',
            fillcolor = 'forestgreen') %>%
  layout(title = 'Distribution of Covid19 Cases Worldwide',
         legend = list(x = 0.1, y = 0.9),
         yaxis = list(title="Number of Cases"),
         xaxis = list(title = "Source: Johns Hopkins University Center for Systems Science and Engineering"))

# Plot the confirmed cases distribution by country with treemap plot
confirmed_df <- coronavirus %>%
  filter(type == "confirmed") %>%
  group_by(country) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases) %>%
  mutate(parents = "Confirmed") %>%
  ungroup()

plot_ly(data = confirmed_df, type = "treemap", values = ~total_cases,
        labels= ~ country, parents= ~parents,
        domain = list(column=0), name = "Confirmed", textinfo="label+value+percent parent")
  
  