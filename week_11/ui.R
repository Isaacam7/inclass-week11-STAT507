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
fluidPage(

    # Application title
    titlePanel("Week 11 Activity 1"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("nobs",
                        "Number of Observations:",
                        min = 10,
                        max = 1000,
                        value = 100),
        
            selectInput("distparam",
                        "Distribution Parameters: ",
                        list("Mean=4"=4,
                             "Mean=10"=10,
                             "Mean=100"=100),
                        selected = "Mean=10"),
            actionButton("update",
                         "Update summary statistics")
        ),

        # Show a plot of the generated distribution
        mainPanel(
          textOutput("summary_text"),
            plotOutput("distPlot",
                       width = "100%",
                       height = "600px")
        )
    )
)
