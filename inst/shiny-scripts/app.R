library(shiny)
library(MotifFunc)
library(MotifDb)

jaspar.scores <- MotifFunc:::jaspar.scores
exampleFile <- system.file("extdata", "MA0007.1.transfac", package = "MotifFunc")

ui <- fluidPage(
  titlePanel("Wordcloud Visualization of Motif Functions"),
  sidebarLayout( position = "right",
                 sidebarPanel(
                   helpText(h3("Input for motif classification. If both are provided, the file will be used")),
                   fileInput(inputId = "pcmFile",
                             label = "Input PCM .transfac file:"),
                 textInput(inputId = "seqText",
                           h3("Sequence input (i.e. Composed of A,C,T, or/and G):")),
                 textOutput(outputId = "inputMessage"),
                 textOutput(outputId = "loadMessage")
                 ), mainPanel(plotOutput("plot", width = "100%", height = "400px")))

)

server <- function(input, output) {
  output$loadMessage <- renderText({sprintf("Wordcloud visualization is loading...")})
  observe({
    if (is.null(input$pcmFile) || is.null(input$seqText)) {
      message <-
        sprintf("No uploaded PCM file, used default PCM file MA0007.1.transfac in extdata of MotifFunc package.")
      matchNames <- MotifFunc::classifyPcmMotifs(exampleFile)
    } else if (! is.null(input$pcmFile)) {
      message <-
        sprintf("Uploaded PCM file is %s.",
                input$pcmFile$name)
      matchNames <- MotifFunc::classifyPcmMotifs(input$pcmFile$datapath)
    } else {
      message <-
        sprintf("No uploaded PCM file, used sequence %s.", input$seqText$name)
      matchNames <- MotifFunc::classifySeqMotifs(input$seqText$datapath)
    }
    output$inputMessage <- renderText({message})
    output$plot <- renderPlot({MotifFunc::getFunctionWC(matchNames)})
    output$loadMessage <- renderText({sprintf("Wordcloud visualization is complete.")})

  })


}

shinyApp(ui = ui, server = server)
