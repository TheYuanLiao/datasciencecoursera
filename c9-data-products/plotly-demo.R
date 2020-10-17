library(plotly)
library(shiny)

set.seed(777)
temp <- rnorm(100, mean=30, sd=5)
pressure <- rnorm(100)
dtime <- 1:100
p <- plot_ly(x=temp, y=pressure, z=dtime,
             type='scatter3d', mode='markers', color=temp)
p
