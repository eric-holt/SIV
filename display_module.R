display_module_ui = function(id){
  ns = NS(id)
  sidebarLayout(
    sidebarPanel(
      fileInput(ns("file"), "Drag and drop or choose a plotly .rds file", 
                accept = c(".rds"),
                multiple = FALSE,
                buttonLabel = "Browse...",
                placeholder = "No file selected"),
      uiOutput(ns("options")),
      textOutput(ns("file_type")),
    ),
    mainPanel(
      uiOutput(ns("out")),
    )
  )
}

display_module_server = function(id) {
  moduleServer(id, function(input, output, session){
    ns = session$ns
    
    data = reactive({
      req(input$file)
      readRDS(input$file$datapath)
    })
    
    d_class = reactive({
      req(data())
      class(data())
    })
    
    output$file_type = renderText({
      req(d_class())
      paste(d_class(), collapse = ", ")
    })
    
    output$options = renderUI({
      req(d_class())
      if(any(c("ggplot", "plotly") %in% d_class())){
        tagList(
          sliderInput(ns("width"), "Width", 
                      min = 300, max = 800, value = 500, step = 50),
          sliderInput(ns("height"), "Height", 
                      min = 300, max = 800, value = 500, step = 50),
        )
      }
    })
    
    output$out = renderUI({
      req(d_class())
      if(any(c("ggplot", "plotly") %in% d_class())){
        plotlyOutput(ns("plotly"), width = input$width, height = input$height) 
      }
      else if(any(c("datatables", "data.frame") %in% d_class())) DTOutput(ns("DT"))
    })
    
    output$plotly = renderPlotly({
      req(data(), d_class())
      if("ggplot" %in% d_class()) ggplotly(data(), input$width, input$height)
      else if ("plotly" %in% d_class()) data() |> plotly::layout(autosize = F, width = input$width, height = input$height)
    })
    
    output$DT = renderDT({
      req(data(), d_class())
      if("data.frame" %in% d_class()) datatable(data())
      else if ("datatables" %in% d_class()) data()
    })
  })
}

