library(shiny)
library(plotly)

ui <- fluidPage(
    
    # App title ----
    titlePanel("Weather Conditions in Cities during May 2021"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            sliderInput(inputId = "date", label = "Date Range",
                        min = 1, max = 31,
                        value = c(1, 31)),
            radioButtons(inputId = "ylabel", label = "Choose Param",
                         choices = list("Max Temp" = 3, "Min Temp" = 5, "Avg Temp" = 4,
                                        "Avg Humidity" = 6, "Avg Wind Speed" = 7),
                         selected = 4),
            checkboxGroupInput(inputId = "city", label = "Choose Cities",
                         choices = list("Bangalore" = 1, "Mumbai" = 2, "Chennai" = 3),
                         selected = 1),
            tags$a(href="https://jol2kor.shinyapps.io/Shiny_Docu/", 
                   "Link to User Document here")
          
        ),

        # Main panel for displaying outputs ----
        mainPanel(
            plotlyOutput("plot")
            )
            
        )
    )
