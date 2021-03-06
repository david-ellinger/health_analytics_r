Mini Project 2
================
David Ellinger

# Background and Significance

For my project, I am consuming the [API from The Covid Tracking
Project](https://covidtracking.com/data/api). The datasets provided
allow for in depth analysis of the U.S national and state data relating
to Covid-19. Covid-19 has rapidly been spreading over the course of the
last year. Analyzing data may help us better prepare for the next
pandemic, help develop a vaccine, drive better pandemic safety protocols
in the future.

# Problem

Was there a decrease in daily deaths after a state gave stay at home
orders?

# Proposed Solution

My solution pulls down data for all states in the New England region of
the united states. Based on the National Academy for State Health
Policy, the original stay at home order dates are captured along with
other information. Each state is different in their policies so it is
not a one for one match, but does give a good regional idea.

# Demo

``` r
install.packages("pacman",repos="http://cran.us.r-project.org")
```

    ## Installing package into 'C:/Users/david/Documents/R/win-library/4.0'
    ## (as 'lib' is unspecified)

    ## package 'pacman' successfully unpacked and MD5 sums checked
    ## 
    ## The downloaded binary packages are in
    ##  C:\Users\david\AppData\Local\Temp\RtmpyafX6S\downloaded_packages

``` r
pacman::p_load(httr, jsonlite, corrplot, ggplot2, dplyr, gridExtra, install = TRUE)

generate_state_chart <- function(state, stay_at_home_start, stay_at_home_end) {
  api <- paste("api.covidtracking.com/v1/states/",c(tolower(state)),"/daily.json", sep="")
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

massachusetts = generate_state_chart("MA", "2020-04-24", "2020-05-18")
```

    ## No encoding supplied: defaulting to UTF-8.

``` r
vermont = generate_state_chart("VT", "2020-03-24", "2020-05-15")
```

    ## No encoding supplied: defaulting to UTF-8.

``` r
new_hampshire = generate_state_chart("NH", "2020-03-27", "2020-06-15")
```

    ## No encoding supplied: defaulting to UTF-8.

``` r
maine = generate_state_chart("ME", "2020-04-02", "2020-05-31")
```

    ## No encoding supplied: defaulting to UTF-8.

``` r
rhode_island = generate_state_chart("RI", "2020-03-28", "2020-05-08")
```

    ## No encoding supplied: defaulting to UTF-8.

``` r
connecticut = generate_state_chart("CT", "2020-03-23", "2020-05-20")
```

    ## No encoding supplied: defaulting to UTF-8.

``` r
grid.arrange(massachusetts, vermont, new_hampshire, maine, rhode_island, connecticut, ncol=2)
```

![](mini_project2_notebook_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

# Improvements

There is a lot that can be improved here, as far as visibility and scope
of data. Applying this to all states would be difficult due to each
state having autonomous guidelines.

# References

National Academy for State Health Policy. (2020, September 10).

Chart: Each State’s COVID-19 Reopening and Reclosing Plans and Mask
Requirements \[Dataset\].
<https://www.nashp.org/governors-prioritize-health-for-all/>

The COVID Tracking Project. (2020, March 1). Data API \[Dataset\].
<https://covidtracking.com/data/api/>
