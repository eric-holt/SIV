library(shiny)
library(plotly)
library(DT)
source("css.R")
source("display_module.R")

options(shiny.maxRequestSize = 2^30)

ui = fixedPage(
  titlePanel("Simple Interactive Viewer"),
  tags$head(tags$style(HTML(css))),
  uiOutput("UI"),
  actionButton("add", "", icon("plus"))
)

server = function(input, output) {
  num_module = reactiveVal(1)
  
  observe({
    num_module(num_module() + 1)
  }) |> bindEvent(input$add)
  
  output$UI = renderUI({
    module_list = 1:num_module() |> lapply(function(i){
      display_module_ui(i)
    })
    do.call(tagList, module_list)
  })
  
  observe({
    for(i in 1:num_module()){
      display_module_server(i)
    }
  })
}

shinyApp(ui = ui, server = server)
