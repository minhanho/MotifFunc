library(shiny)
library(MotifFunc)

jaspar.scores <- MotifFunc:::jaspar.scores
exampleFile <- system.file("extdata", "MA0007.1.transfac", package = "MotifFunc")

ui <- fluidPage(
  titlePanel("Wordcloud visualization of motif functions"),
  sidebarLayout( position = "right",
                 sidebarPanel(
                   helpText(h3("Input PCM .transfac file or sequence (i.e. composed of A,C,T, or G). If both are provided, the file will be used")),
                   fileInput(inputId = "pcmFile",
                             label = "Input PCM .transfac file:"),
                 textInput(inputId = "seqText", h3("Text input"),
                           value = "Enter text...")
                 )),
  mainPanel(ggiraphOutput("plot"))
)

server <- function(input, output) {
  observe({
    if (is.null(input$pcmFile) || is.null(input$seqText)) {
      message <-
        sprintf("Default PCM file is MA0007.1.transfac in extdata of MotifFunc package.")
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
  })
}

shinyApp(ui = ui, server = server)
