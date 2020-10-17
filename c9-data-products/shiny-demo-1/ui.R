#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Plot random numbers"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            numericInput("numeric", 'How many random numbers should be plotted?',
                         value = 1000, min = 1, max = 1000, step = 1),
            sliderInput("sliderX",
                        "Pick minimum and maximum X values",
                        min = -100,
                        max = 100,
                        value = c(-50, 50)),
            sliderInput("sliderY",
                        "Pick minimum and maximum Y values",
                        min = -100,
                        max = 100,
                        value = c(-50, 50)),
            checkboxInput('show_xlab', "Show/Hide X axis label", value=TRUE),
            checkboxInput('show_ylab', "Show/Hide Y axis label", value=TRUE),
            checkboxInput('show_title', "Show/Hide title")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3("Graph of random points"),
            plotOutput("plot1")
        )
    )
))
