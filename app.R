#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("Laboratório Aula 8"),
  
  
  sidebarLayout(
    sidebarPanel(
      
      # coloque aqui um seletor de qual variável do banco de dados será a resposta
      # (somente 'price', 'carat', 'x', 'y', 'z')
      # Um seletor da variável resposta que será considerada pelo modelo.
      selectInput(inputId = "resposta", label = h3("Variável Resposta:"),
                  choices = c("Preço" = "price", "caracter" = "carat", "x" = "x","y" = "y","z" = "z"),
                  selected = 1),
      
      # coloque aqui um seletor de qual variável será a explicativa
      # (somente 'price', 'carat', 'x', 'y', 'z')
      # Um seletor de uma covariável para o modelo
      selectInput(inputId = "x", label = h3("Covariável:"),
                  choices = c("Preço" = "price", "caracter" = "carat", "x" = "x","y" = "y","z" = "z"),
                  selected = 1)
      
      
    ),
    
    mainPanel(
      tags$h2('Gráfico!'),
      plotOutput("reta_ajustada"),
      
      h2('Tabela Diamonds'),
      dataTableOutput('mytable')
      
    )
  )
  
)

)

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
  
  ajustar_modelo <- function(y, x){
    form <- as.formula(paste(y, x, sep='~'))
    modelo <- lm(form, data = diamonds)
    return(modelo)
  }
  
  
  
  # faça um gráfico da variável resposta pela variável selecionada para o eixo X
  # inclua a reta de regressão ajustada.
  # Um gráfico da variável resposta (eixo y) pela variável utilizadas no modelo, incluindo a reta ajustada.
  
  #pairs(diamonds[1:input$n])
  
  #                   aes_string()
  #    ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar()
  
  output$reta_ajustada <- renderPlot({
    # definição das variáveis
    y <- input$resposta
    x <- input$x
    ### é meu modelo
    q <-  ajustar_modelo(y,x)
    ### guardar os coeficientes
    r <- coef(q)
    
    ggplot(diamonds, aes_string(x=x,y=y)) +
      geom_point() +
      geom_abline(slope = r[2], intercept = r[1])
  })
  
  output$mytable = renderDataTable({
    diamonds
  })
  
  
})

# Run the application
shinyApp(ui = ui, server = server)