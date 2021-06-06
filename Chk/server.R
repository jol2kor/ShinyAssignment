library(plotly)
library(dplyr)

df <- read.csv("May_Weather.csv")
dfB <- subset(df, df$City == "Bangalore")
dfM <- subset(df, df$City == "Mumbai")
dfC <- subset(df, df$City == "Chennai")
df <- cbind(dfB, dfM, dfC)

y_label <- c('','','Max Temperature in Fahrenheit', 'Avg Temperature in Fahrenheit',
             'Min Temperature in Fahrenheit', 'Avg Humidity in %', 'Avg Wind Speed in mph')

server <- function(input, output) {
    filtered_data <- reactive({
        data <- df
        data <- subset(data, Date >= input$date[1] & Date <= input$date[2])
        data
        })
    sel_param <- reactive({
        param <- input$ylabel
        param
        })
    sel_city <- reactive({
        city <- input$city
        city
        })
    
        output$plot <- renderPlotly({
            data <- filtered_data()
            y_param <- as.numeric(sel_param())
            city <- sel_city()

            fig <- plot_ly(data, x = ~data$Date)
            fig <- fig %>% layout(
                xaxis = list(title = "Date"),
                yaxis = list(title = y_label[y_param]))
            
            if("1" %in% city){          
                fig <- fig %>% add_trace(y = ~data[[y_param]]
                           , name = 'Bangalore', 
                    type = 'scatter', mode = 'lines+markers',
                    marker = list(size = data[[6]]/7), hoverinfo = 'text',
                    
                    text = ~paste(data[[1]],'on May', data[[2]], 
                    '<br>Max Temp :', data[[3]],'F','<br>Min Temp :', data[[5]],
                    'F','<br>Avg Temp :', data[[4]],'F', '<br>Humidity :',
                    data[[6]],'%','<br>Wind Spd :', data[[7]],'mph')
                    )
            }

            
# Preparing for Mumbai

            if("2" %in% city){ 
            fig <- fig %>% add_trace(y = ~data[[y_param  + 7]], name = 'Mumbai', 
                           mode = 'lines+markers',
                           marker = list(size = data[[6 + 7]]/7), hoverinfo = 'text',
            
                           text = ~paste(data[[1 + 7]],'on May', data[[2 + 7]], 
            '<br>Max Temp :', data[[3 + 7]],'F','<br>Min Temp :', data[[5 + 7]],
            'F','<br>Avg Temp :', data[[4 + 7]],'F', '<br>Humidity :',
            data[[6 + 7]],'%','<br>Wind Spd :', data[[7 + 7]],'mph')
            )
            }
            
# Preparing for Chennai
            
            if("3" %in% city){ 
            fig <- fig %>% add_trace(y = ~data[[y_param  + 14]], name = 'Chennai', 
                            mode = 'lines+markers',
                            marker = list(size = data[[6 + 14]]/7), hoverinfo = 'text',
                                     
                            text = ~paste(data[[1 + 14]],'on May', data[[2 + 14]], 
            '<br>Max Temp :', data[[3 + 14]],'F','<br>Min Temp :', data[[5 + 14]],
            'F','<br>Avg Temp :', data[[4 + 14]],'F', '<br>Humidity :',
            data[[6 + 14]],'%','<br>Wind Spd :', data[[7 + 14]],'mph')
            )
            }
            if(!is.null(city))
            fig
            
                        })
#        })
    
}
