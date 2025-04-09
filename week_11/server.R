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
library(tidyverse)

# Define server logic required to draw a histogram
function(input, output, session) {
  
  # use srs <- reactive({}) to make sure all renders use the same values
  
  srs <- reactive({
    
    
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
    
    list(pois.srs=pois.srs,
         norm1.srs=norm1.srs,
         norm2.srs=norm2.srs,
         transformed.srs=transformed.srs)
  })
  
  
  
  output$summary_text <- renderText({
    
    srs.vals <- srs()
    glue(paste("Sample mean from a","SRS from a Poisson distribution:",mean(srs.vals$pois.srs),"\n",
          "Sample mean from a","SRS from a Normal distribution with inputed mean and sd sqrt of mean:",mean(srs.vals$norm1.srs),"\n",
          "Sample mean from a","SRS from a Normal distribution with sqrt inputed mean and sd 1/4:",mean(srs.vals$norm2.srs),"\n",
          "Sample mean from a","transformed (sqrt of pois) SRS:",mean(srs.vals$transformed.srs),"\n"))
    
  })
  
  output$distPlot <- renderPlot({
    
    srs.vals <- srs()
    
     data.frame(pois = srs.vals$pois.srs,
                      norm1 = srs.vals$norm1.srs,
                      norm2 = srs.vals$norm2.srs,
                      transformed = srs.vals$transformed.srs) %>%
       
       pivot_longer(everything(),
                    names_to = "dist",
                    values_to = "value") %>%
       mutate(espected_mean = case_match(dist,
                                         'pois' ~ 'lambda',
                                         'norm1' ~ 'lambda',
                                         'norm2' ~ 'sqrt lambda',
                                         'transformed' ~ 'sqrt lambda'
         
       )) %>% 
       ggplot(aes(x=value)) +
       geom_histogram(aes(fill=dist),
                      alpha=0.5,
                      position = position_identity()) +
       facet_grid(cols = vars(espected_mean))
    
    
    
  })
  
}
