shinyUI(bootstrapPage(
    fluidPage(
    titlePanel("What Contributes to Success in the German Bundesliga?"),
    sidebarLayout(
        sidebarPanel(position="left", 
                     helpText("The German Bundesliga is one of the most competitive professoinal soccer leagues in the world.
                               This web application examines the effect transfer spending, transfer income, goals scored,
                              and goals against have had on success in this league between 1990 and 2010. Choose a variable 
                              from the drop down menu below to see the relationship each of these 
                              variables has on success as measured by wins:"),
                     selectInput("variable", label = h5("Select Variable"), 
                                 choices = list("Transfer Spending" = 1,
                                                "Transfer Income" = 2, "Goals Scored" = 3,
                                                "Goals Against" = 4), selected = 1),
                     helpText("To your right, you can observe the scatterplot, regression line, and shaded 
                              95% confidence interval depicting each relationship. The associated regression coefficients and measures of statistical 
                              significance are also provided. The data supporting this application were taken from the datasets BundeligaFinalStandings 
                              and BundesligaTransferSums, both of which are found in the R package", 
                              a(href = "http://cran.r-project.org/web/packages/SportsAnalytics/SportsAnalytics.pdf", 
                              "Sports Analytics."))
        ),
        
        mainPanel(
                  plotOutput("Plot"), 
                  br(),
                  verbatimTextOutput("Text"),
                  position="center")
    )
)
)
)



