library(shiny)

shinyUI(
    pageWithSidebar(
        # Application title
        headerPanel("Child Height Prediction"),
        
        sidebarPanel(
            numericInput('father', 'Father Height (inches)', 67, min = 64, max = 73, step = 0.1),
            numericInput('mother', 'Mother Height (inches)', 67, min = 64, max = 73, step = 0.1),
            checkboxInput("predict", "Show prediction on plot", TRUE),
            submitButton('Submit'),
            p('This shiny application contains two tabs on the right. Instructions are shown within each tab.'),
            p('The preditcion algorithm uses galton data set in the library UsingR. A linear regression model is fit to make the prediction.')
        ),

        mainPanel(
            tabsetPanel(
                tabPanel("Prediction", 
                         p('Please enter or use the arrow to adjust the father and mother height in the left box. Then press submit.'),
                         p('The algorithm will calculate parent\'s height as an average of the father\'s height and 1.08 times the mother\'s and then use parent height to predict child height.'),
                         p('The prediction works when parent height is between 64 and 73.'),
                         h4('You entered father height:'),
                         verbatimTextOutput("inputFather"),
                         h4('You entered mother height:'),
                         verbatimTextOutput("inputMother"),
                         h4('Calculated parent height is:'),
                         verbatimTextOutput("midheight"),
                         h4('Child\'s height is predited to be: '),
                         verbatimTextOutput("prediction")),
                tabPanel("Plot",
                         p('This is a scatter plot of child height vs. parent height. Since some data points overlap each other, darker or lighter color are used to represent the frequency of the data points. Darker color means more frequency. The straight line is the linear regression line.'),
                         p('The predicted child height will be shown on the plot as a red triangle when:'),
                         p('1. \"Show preditcion on plot\" box is checked and submitted.'),
                         p('2. Parent height is between 64 and 73.'),
                         p('Uncheck \"Show preditcion on plot\" box and submit will remove the red triangle.'),
                         plotOutput("plot")) 
                
            )
        )
        
    )
)