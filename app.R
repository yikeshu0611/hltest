library(shiny)
# Define UI for application that draws a histogram
ui <- pageWithSidebar(
    headerPanel("Hosmer-Lemeshow Test"),
    sidebarPanel(
        h2('请选择SPSS数据'),
        h5('数据应该是sav格式'),
        h5('数据的第1列是Y(0,1)'),
        h5('数据的第2列是概率(0-1)'),
        fileInput('file',''),
        sliderInput(inputId = 'g',label = 'group number',
                    min = 1,max = 100,
                    value = 10,step = 1)
        
    ),
    mainPanel(
        verbatimTextOutput('contents')
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$contents <- renderPrint({
        
        inFile <- input$file
        if (is.null(inFile)) return(NULL)
        library(foreign)
        spss=read.spss(file = inFile$datapath,
                  to.data.frame = TRUE,
                  reencode = 'UTF-8',
                  use.value.labels = FALSE)
        library(ResourceSelection)
        x=spss[,1]
        y=spss[,2]
        hoslem.test(x, y, g = input$g)
    })
}
# Run the application 
shinyApp(ui = ui, server = server)
