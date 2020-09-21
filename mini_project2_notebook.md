Covid Data Analytics
================
David Ellinger

# Correlation of positive test results and death

``` r
install.packages("pacman", repos = "http://cran.us.r-project.org")
```

    ## Installing package into 'C:/Users/david/Documents/R/win-library/4.0'
    ## (as 'lib' is unspecified)

    ## package 'pacman' successfully unpacked and MD5 sums checked
    ## 
    ## The downloaded binary packages are in
    ##  C:\Users\david\AppData\Local\Temp\RtmpUjQUTX\downloaded_packages

``` r
pacman::p_load(httr, jsonlite, corrplot, ggplot2, install = TRUE)

api <- "api.covidtracking.com/v1/states/ma/daily.json"
raw_state_data <- GET(api)
raw_state_text <- content(raw_state_data, "text")
```

    ## No encoding supplied: defaulting to UTF-8.

``` r
raw_state_json <- fromJSON(raw_state_text)
state_data <- as.data.frame(raw_state_json)


ggplot(state_data) +
  aes(x = positive, y = death) +
  geom_point(colour = "#0c4c8a") +
  theme_minimal()
```

    ## Warning: Removed 56 rows containing missing values (geom_point).

![](mini_project2_notebook_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->
