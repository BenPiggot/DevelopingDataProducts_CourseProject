library(ggplot2)
library(scales)
library(plyr)
library(dplyr)
library(shiny)
library(SportsAnalytics)
library(ggvis)

data(BundesligaTransferSums)
data(BundesligaFinalStandings)
bundesligaMaster <- cbind(BundesligaFinalStandings, BundesligaTransferSums)
bundesligaMaster <- bundesligaMaster[,c(-13,-14,-15)]
bundesligaMaster <- mutate(bundesligaMaster, TransferSpending = Spendings/1000000, 
                           TransferIncome = Takings/1000000)
glimpse(bundesligaMaster)

shinyServer(function(input, output){
    
    output$Plot <- renderPlot({
        if(input$variable == 1) {     
            ggplot(bundesligaMaster, aes(x=(Spendings/1000000), y=Wins)) + geom_point() + 
                stat_smooth(method=lm) + scale_x_continuous(labels = comma) + 
                xlab("Transfer Spending in Millions of Euros") + theme(axis.title.x = element_text(vjust = 0)) +
                labs(title="Relationship between Transfer Spending and Wins, 1990 to 2010") +
                theme(plot.title = element_text(face="bold", size = 18, vjust = 2.3))
        } else if (input$variable == 2) {
            ggplot(bundesligaMaster, aes(x=(Takings/1000000), y=Wins)) + geom_point() + 
                stat_smooth(method=lm) + scale_x_continuous(labels = comma) + 
                xlab("Transfer Income in Millions of Euros") + theme(axis.title.x = element_text(vjust = 0)) +
                labs(title="Relationship between Transfer Income and Wins, 1990 to 2010") +
                theme(plot.title = element_text(face="bold", size = 18, vjust = 2.3))
        } else if (input$variable == 3){
            ggplot(bundesligaMaster, aes(x=GoalsScored, y=Wins)) + geom_point() + 
                stat_smooth(method=lm) + xlab("Goals Scored") +  theme(axis.title.x = element_text(vjust = 0)) +
                labs(title="Relationship between Goals Scored and Wins, 1990 to 2010") +
                theme(plot.title = element_text(face="bold", size = 18, vjust = 2.3))
        } else {
            ggplot(bundesligaMaster, aes(x=GoalsAgainst, y=Wins)) + geom_point() + 
                stat_smooth(method=lm) + xlab("Goals Against") +  theme(axis.title.x = element_text(vjust = 0)) +
                labs(title="Relationship between Goals Against and Wins, 1990 to 2010") +
                theme(plot.title = element_text(face="bold", size = 18, vjust = 2.3))
        }
    })
    output$Text <- renderPrint({
        if (input$variable == 1) {
            summary(lm(Wins ~ TransferSpending, bundesligaMaster))$coef
        } else if (input$variable == 2) {
            summary(lm(Wins ~ TransferIncome, bundesligaMaster))$coef
        } else if (input$variable == 3) {
            summary(lm(Wins ~ GoalsScored, bundesligaMaster))$coef
        } else { 
            summary(lm(Wins ~ GoalsAgainst, bundesligaMaster))$coef
        }
        
    })
    
})



