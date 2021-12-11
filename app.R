#app.R 

library(shiny)

source("app_ui.R", local=TRUE)
source("app_server.R", local=TRUE)

shinyApp(ui = ui, server = server)