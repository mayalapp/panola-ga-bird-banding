# load required libraries
library(shiny)
library(tidyverse)
library(readxl)
library(gridExtra)
library(patchwork)
library(shinyFiles)
library(directlabels)
library(colorspace)
library(lubridate)


# functions to extract data from xlsx files - do not require user inputted values
source("functions.R")


# -------------------------------------------------------------------------------------------#

#--------------------
# creates r shiny user interface
#--------------------

ui = fluidPage(
  
  verticalLayout(
    titlePanel(textOutput(outputId = "app.title")),
    
    # get user inputs
    wellPanel(
      
      # select files needed for report
      fileInput(inputId = "files",
                label = "Choose banding data file and recapture data file",
                multiple = TRUE, accept = c(".csv", ".xlsx", ".xls")),
      
      
      # if this is checked, extract the title name, notes, and/or group from the data file 
      #checkboxInput(inputId = "use.header", label = "Use header file", value = FALSE), 
      
      
      # dropdown with different cancer screening options. starts on blank. 
      # affects notes on which patients are used, report title, and graph titles
      #selectInput(inputId = "report.type", label = "Choose report type (if not extracting from header file)",
      #            choices = c("","Colorectal Cancer Screening", "Mammogram Screening", "Cervical Cancer Screening")),
      

      # button to download pdf report
      #downloadButton("download.report", "Download Report PDF")
      
      
    ),
  )
)



#--------------------
# CREATES THE OBJECTS THAT ARE OUTPUTTED/INPUTTED TO THE APP
#--------------------

server = function(input, output){
  
  output$app.title = renderText({ 
    paste("PANO bird stats")
  })
  
  data = reactive({
    all_data = data.frame()
    
    # get data from each file
    for(i in 1:length(input$files$name)){
        data_i = read_excel(input$files$datapath[[i]])    # read in data of file_i
        all_data = rbind(all_data, data_i)          
    }
 
})
  
}


# run app
shinyApp(ui = ui, server = server)

#sharing apps shinyapps.io

