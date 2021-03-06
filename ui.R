#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict Population from Murder cases"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderMurder","What are the number of murder cases?",
                        min = 0,max = 20,step = .1, value = 200),
            checkboxInput("showModel1","SHow/Hide Murder Arrests", value = TRUE),
            checkboxInput("showModel2","SHow/Hide Modified Murder Arrests", value = TRUE),
            submitButton("Submit")
        ),
         mainPanel(
            plotOutput("plot1"),
            h3("Predicted Population from Murder cases:"),
            textOutput("pred1"),
            h3("Predicted Population from Modified Murder cases:"),
            textOutput("pred2")
        )
    )
))
