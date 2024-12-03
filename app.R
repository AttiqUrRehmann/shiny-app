# Simple Shiny App with Linear Regression and Prediction

# Install Shiny if not installed
if (!require(shiny)) install.packages("shiny")

library(shiny)

# Simulate data
set.seed(123)
x <- rnorm(100, mean = 50, sd = 10)
y <- 5 + 2 * x + rnorm(100, sd = 15)
data <- data.frame(x, y)

# Perform linear regression
model <- lm(y ~ x, data = data)

# Define UI
ui <- fluidPage(
  titlePanel("Linear Regression Prediction App"),
  sidebarLayout(
    sidebarPanel(
      numericInput("inputX", 
                   "Enter a value for x:", 
                   value = 50,
                   min = 10,
                   max = 100,
                   step = 1)
    ),
    mainPanel(
      h4("Prediction for y:"),
      textOutput("prediction"),
      plotOutput("scatterPlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Predict y based on user input
  output$prediction <- renderText({
    pred <- predict(model, newdata = data.frame(x = input$inputX))
    paste("Predicted value of y:", round(pred, 2))
  })
  
  # Plot data and regression line
  output$scatterPlot <- renderPlot({
    plot(data$x, data$y, pch = 16, col = "blue",
         xlab = "x", ylab = "y", main = "Scatterplot with Regression Line")
    abline(model, col = "red", lwd = 2)
    points(input$inputX, predict(model, newdata = data.frame(x = input$inputX)), 
           col = "green", pch = 19, cex = 2)
  })
}

# Run the application
shinyApp(ui = ui, server = server)
