library(shiny)
library(plotly)
source("css.R")

ui = fixedPage(
  titlePanel("Simple Plotly Viewer"),
  tags$head(tags$style(HTML(css))),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Drag and drop or choose a plotly .rds file", 
                accept = c(".rds"),
                multiple = FALSE,
                buttonLabel = "Browse...",
                placeholder = "No file selected"),
      sliderInput("width", "Width", 
                  min = 300, max = 1000, value = 600, step = 50),
      sliderInput("height", "Height", 
                  min = 300, max = 1000, value = 600, step = 50),
      radioButtons("radio", "Theme", c("Light", "Dark"), "Dark", T,)
    ),
    mainPanel(
      plotlyOutput("plot")
    )
  )
)

server = function(input, output) {
  output$plot = renderPlotly({
    req(input$file)
    plot_data = readRDS(input$file$datapath)
    plot_data |> plotly::layout(autosize = F, width = input$width, height = input$height)
  })
}

shinyApp(ui = ui, server = server)
