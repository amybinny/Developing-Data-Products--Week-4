#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    USArrests$pop <- ifelse(USArrests$Murder-7>0,USArrests$Murder-7,0)
    model1       <- lm(UrbanPop~Murder,data=USArrests)
    model2       <- lm(UrbanPop~pop+Murder,data=USArrests)    
    model1pred    <- reactive({
        MurderInput <- input$sliderMurder
        predict(model1,newdata=data.frame(Murder=MurderInput))
    })
    model2pred   <- reactive({
        MurderInput <- input$sliderMurder
        predict(model2,newdata=data.frame(Murder=MurderInput,
                pop=ifelse(MurderInput-7>0,MurderInput-7,0)))
    })
    output$plot1 <- renderPlot({
        MurderInput <- input$sliderMurder
        plot(USArrests$Murder,USArrests$UrbanPop,xlab="Murder arrests 
             (per 100,000)", ylab="Percent Urban Population", 
             bty="n",pch=16,xlim = c(0,20),ylim = c(30,100))
        if(input$showModel1){
            abline(model1,col="red", lwd=2)
        }
        if(input$showModel2){
            model2lines<- predict(model2,newdata=data.frame(Murder=0:20,
            pop=ifelse(0:20-7>0,0:20-7,0)))
            lines(0:20,model2lines,col="blue",lwd=2)
        }
        legend(10,100,c("Murder Arrest Population Prediction","Modified Murder Arrest Population Prediction"), 
               pch=16,col=c("red","blue"), bty="n",cex=0.8)
        points(MurderInput,model1pred(),col="red",pch=16,cex=2)
        points(MurderInput,model2pred(),col="blue",pch=16,cex=2)
    })
    output$pred1 <- renderText({
        model1pred()
    })
    output$pred2 <- renderText({
        model2pred()
    })
})