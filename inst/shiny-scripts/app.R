library(shiny)
library(shinyjs)

#Function for printing messages to interface so user is notified of successful
#Wordcloud input and start of visual production
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

#UI set up - simple to follow
ui <- fluidPage(
  shinyjs::useShinyjs(),
  titlePanel("Wordcloud Visualization of Motif Functions"),
  sidebarLayout( position = "right",
                 sidebarPanel(
                   actionButton("defaultButton", "Load Default File Wordcloud"),
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

  #If the button is pressed to trigger wordcloud from default file
  observeEvent(input$defaultButton, {
    #Prints messages to user given the specific action
    #Adapted from: Attali, D. (2015). [Full reference in README]
    withCallingHandlers({
      shinyjs::html("text", "")
      #Sends input to print message for use of default pcm file
      loadMessage(1)
    },
    message = function(m) {
      shinyjs::html(id = "text", html = m$message, add = TRUE)
    })

  #Specifies input used
    message <-
      sprintf("No uploaded PCM file, used default PCM file MA0007.1.transfac")
    output$inputMessage <- renderText(message)
    data(jaspar.scores, package="MotifFunc")
    jaspar.scores
    transfacFilePath <- system.file("extdata", "new0007.txt", package = "MotifFunc")
    matchNames <- MotifFunc::classifyPcmMotifs(transfacFilePath)
    output$plot <- renderPlot({tempTable <- MotifFunc::getFunctionWC(matchNames)
    output$fTable <- renderTable(tempTable)
    })
  })

  #If the button is pressed to trigger wordcloud from given input
  observeEvent(input$inputButton, {
    #If a file is specified; this won't run if there is also a sequence
    #specified so sequence input must be empty to use a file

    if ((!is.null(input$pcmFile)) && (nchar(input$seqText) < 3)){
      #Prints messages to user given the specific action
      #Adapted from: Attali, D. (2015). [Full reference in README]
      withCallingHandlers({
        shinyjs::html("text", "")
        #Sends input to print message for use of given pcm file
        loadMessage(2)
      },
      message = function(m) {
        shinyjs::html(id = "text", html = m$message, add = TRUE)
      })
      message <-
        sprintf("Uploaded PCM file is %s.",
                input$pcmFile$name)
      data(jaspar.scores, package="MotifFunc")
      jaspar.scores
      matchNames <- MotifFunc::classifyPcmMotifs(input$pcmFile$datapath)
      output$inputMessage <- renderText(message)
      output$plot <- renderPlot({tempTable <- MotifFunc::getFunctionWC(matchNames)
      #Only sets table display if at least one function is found
      if (tempTable != 0){
        output$fTable <- renderTable(tempTable)
      }
      #Empty plot displayed
      else{
        plot.new()
      }
      })
    }
    #If a sequence of appropriate length is specified
    else if ((nchar(input$seqText) >= 3)){
      #Prints messages to user given the specific action
      #Adapted from: Attali, D. (2015). [Full reference in README]
      withCallingHandlers({
        shinyjs::html("text", "")
        #Sends input to print message for use of sequence
        loadMessage(3)
      },
      message = function(m) {
        shinyjs::html(id = "text", html = m$message, add = TRUE)
      })
      message <-
        sprintf("No uploaded PCM file, used sequence %s.", input$seqText)
      data(jaspar.scores, package="MotifFunc")
      jaspar.scores
      matchNames <- MotifFunc::classifySeqMotifs(input$seqText)
      output$inputMessage <- renderText(message)
      output$plot <- renderPlot({tempTable <- MotifFunc::getFunctionWC(matchNames)
      #Only sets table display if at least one function is found
      if (tempTable != 0){
        output$fTable <- renderTable(tempTable)
      }
      #Empty plot displayed
      else{
        plot.new()
      }
      })
    }
    #If no input is given
    else if ((is.null(input$pcmFile)) && (nchar(input$seqText) < 3)){
      #Prints messages to user given the specific action
      #Adapted from: Attali, D. (2015). [Full reference in README]
      withCallingHandlers({
        shinyjs::html("text", "")
        #Sends input to print message for no input
        loadMessage(4)
      },
      message = function(m) {
        shinyjs::html(id = "text", html = m$message, add = TRUE)
      })
    }
    })

}

#Run app
shinyApp(ui = ui, server = server)
