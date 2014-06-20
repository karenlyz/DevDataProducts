library(shiny)
library(UsingR)
library(ggplot2)
fit<-lm(child~parent, data=galton)
ChildHeight<-function(father,mother){
    as.vector(predict(fit,data.frame(parent=mean(c(father,1.08*mother)))))
}

shinyServer(
    function(input, output) {
        output$inputFather <- renderPrint({input$father})
        output$inputMother <- renderPrint({input$mother})
        output$prediction <- renderPrint({ChildHeight(input$father,input$mother)})
        output$midheight <- renderPrint({mean(c(input$father,1.08*input$mother))})
                                        
        output$plot <- renderPlot({
            p<-ggplot(galton,aes(x=parent,y=child))+
                geom_point(alpha = I(1/10),colour="darkblue")+
                geom_smooth(method="lm")
            if(input$predict){
                p<-p+geom_point(
                    data=data.frame(predictx=mean(c(input$father,1.08*input$mother)),predicty=ChildHeight(input$father,input$mother)),
                    aes(predictx,predicty),colour="red",size=5,shape=17
                    )
            }
            print(p)

        })
    }
)