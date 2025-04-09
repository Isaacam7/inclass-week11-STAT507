#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(glue)
library(ggplot2)

# Define server logic required to draw a histogram
function(input, output, session) {

  
  
  # output$distPlot <- renderPlot({
  #   
  # })
  
  output$summary_text <- renderText({
    
    set.seed(507)
    
    
    len  <- as.numeric(isolate(input$nobs))
    lambda <- as.numeric(isolate(input$distparam))
    
    input$update
    
    pois.srs <- rpois(n=len,
                       lambda=lambda)
    
    norm1.srs <- rnorm(n=len,
                       mean=lambda,
                       sd=sqrt(lambda))
    
    norm2.srs <- rnorm(n=len,
                       mean=sqrt(lambda),
                       sd=1/4)
    
    transformed.srs <- sqrt(pois.srs)
    
    glue(paste("Sample mean from a","SRS from a Poisson distribution:",mean(pois.srs),"\n",
          "Sample mean from a","SRS from a Normal distribution with inputed mean and sd sqrt of mean:",mean(norm1.srs),"\n",
          "Sample mean from a","SRS from a Normal distribution with sqrt inputed mean and sd 1/4:",mean(norm2.srs),"\n",
          "Sample mean from a","transformed (sqrt of pois) SRS:",mean(transformed.srs),"\n"))
    
  })
  
}
