---
title       : Gas usage for heating and outside temperature
subtitle    : A linear model for energy consumption
author      : Edwin Rijgersberg
job         : Coursera Student
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Predicting and evaluating gas usage

- Gas usage for heating in the Netherlands is strongly influenced by the weather
- Commonly, a linear model with so-called "degree-days" is used to model this effect.
- A day is assigned a number of degree-days based on the difference
between the 24-hour average outside temperature and a ficticious temperature called
the heating temperature, via the following formula:

```
degee_days = max(0, heating_temperature - outside_temperature)
```

- Sensible comparison between gas consumptions in different periods can then be
made by correcting for the number of degree-days in the period.
- We made a small app [on Shinyapps](https://edwinrijgersberg.shinyapps.io/GasUsage/)
which explores the effect of changing the ```heating_temperature``` parameter.

--- .class #id 

## Temperature in the Netherlands (1/2)
To give you an idea of the weather in the Netherlands, we plot the 24-hour average
temperature in degrees C.

```r
library(ggplot2)
temperatures <- read.csv('data/temperature.csv')
temperatures$date <- as.POSIXct(strptime(temperatures$date, format="%Y-%m-%d"))
ggplot(temperatures, aes(date, temperature)) + geom_line()
```

--- .class #id 

## Temperature in the Netherlands (2/2)
![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2.png) 

--- .class #id

## Data Sources
The following data sources were used for this presentation and for the Shiny app:

1. [Liander open data](https://www.liander.nl/over-liander/innovatie/open-data/data)
2. [KNMI weather data](http://www.knmi.nl/klimatologie/daggegevens/index.cgi)




