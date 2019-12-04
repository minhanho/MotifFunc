library(shiny)
library(shinyjs)#ADD THIS TO DESCRIPTION AND ADD ROXYGEN TAGS
library(tools)

jaspar.scores <- MotifFunc:::jaspar.scores
exampleFile <- system.file("extdata", "MA0007.1.transfac", package = "MotifFunc")

loadMessage <- function(input){
  if (input == 1){
    message("Default PCM file Wordcloud is loading...")
  }
  else if (input == 2){
    message("New PCM file Wordcloud is loading...")
  }
  else if (input == 3){
    message("New Sequence Wordcloud is loading...")
  }
  else{
    message("No input given. Try again.")
  }
}

ui <- fluidPage(
  shinyjs::useShinyjs(),
  titlePanel("Wordcloud Visualization of Motif Functions"),
  sidebarLayout( position = "right",
                 sidebarPanel(
                   actionButton("defaultButton", "Load Default File Wordcloud"),
                   br(),
                   helpText(h4("Input for motif matching. If both are provided, the sequence will be used")),
                   fileInput(inputId = "pcmFile",
                             label = "Input PCM .transfac file:",
                             placeholder = "MA0007.1.transfac (Default)"),
                   textInput(inputId = "seqText",
                           label = "Sequence input (i.e. Composed of A,C,T, or/and G):",
                           value = NULL),
                   actionButton("inputButton", "Create Wordcloud from Input"),
                   textOutput(outputId = "inputMessage")

                 ), mainPanel(textOutput("text"), plotOutput("plot", width = "100%",
                                         height = "400px"),
                 h4("Match Function Frequencies"), tableOutput("fTable")))

)

server <- function(input, output) {

  observeEvent(input$defaultButton, {
    withCallingHandlers({
      shinyjs::html("text", "")
      loadMessage(1)
    },
    message = function(m) {
      shinyjs::html(id = "text", html = m$message, add = TRUE)
    })
    message <-
      sprintf("No uploaded PCM file, used default PCM file MA0007.1.transfac")
    matchNames <- MotifFunc:::matchNames
    output$inputMessage <- renderText(message)
    output$plot <- renderPlot({tempTable <- MotifFunc::getFunctionWC(matchNames)
    output$fTable <- renderTable(tempTable)
    })
  })
  observeEvent(input$inputButton, {
    if ((!is.null(input$pcmFile)) && (nchar(input$seqText) >= 3)){
      withCallingHandlers({
        shinyjs::html("text", "")
        loadMessage(2)
      },
      message = function(m) {
        shinyjs::html(id = "text", html = m$message, add = TRUE)
      })
      message <-
        sprintf("Uploaded PCM file is %s.",
                input$pcmFile$name)
      matchNames <- MotifFunc::classifyPcmMotifs(input$pcmFile$datapath)
      output$inputMessage <- renderText(message)
      output$plot <- renderPlot({tempTable <- MotifFunc::getFunctionWC(matchNames)
      output$fTable <- renderTable(tempTable)
      })
    }
    else if ((nchar(input$seqText) >= 3)){
      withCallingHandlers({
        shinyjs::html("text", "")
        loadMessage(3)
      },
      message = function(m) {
        shinyjs::html(id = "text", html = m$message, add = TRUE)
      })
      message <-
        sprintf("No uploaded PCM file, used sequence %s.", input$seqText)
      matchNames <- MotifFunc::classifySeqMotifs(input$seqText)
      output$inputMessage <- renderText(message)
      output$plot <- renderPlot({tempTable <- MotifFunc::getFunctionWC(matchNames)
      output$fTable <- renderTable(tempTable)
      })
    }
    else if ((is.null(input$pcmFile)) && (nchar(input$seqText) < 3)){
      withCallingHandlers({
        shinyjs::html("text", "")
        loadMessage(4)
      },
      message = function(m) {
        shinyjs::html(id = "text", html = m$message, add = TRUE)
      })
    }
    })

}

shinyApp(ui = ui, server = server)
