library(shiny)
library(semantic.dashboard)
library(ggplot2)
library(DT)
library(leaflet)
library(tidyverse)


# Define UI for app that draws a histogram ----
ui <- fluidPage(
  titlePanel(h1("Common Trees Around Fitzroy Gardens", align= 'center')),
  sidebarLayout(
    sidebarPanel = splitLayout( plotOutput('bar'), verticalLayout(selectInput(inputId = "select_plant_type",label = "choose_plant_type",list("Corymbia","Ficus", "Platanus", "Quercus", "Ulmus"),multiple = F, selected= "Ulmus"),p("Map is showing the distribution of top 5 plants on the basis of count respectively:"), leafletOutput('map'))),
    mainPanel(
      plotOutput('bar1')
      
    )  
  )
)








# Define server logic required to draw a histogram ----
server <- function(input, output, session) {
  treedata<- read_csv("Data/PE2_R_Tree_Data.csv")
  data1<- reactive({
    req(input$select_plant_type)
    treedata2<- treedata %>% filter(Genus %in% input$select_plant_type)
  })
  output$bar<- renderPlot({
    treedata1<- treedata %>% 
      select("Genus", "Useful.Life.Expectancy.Value") %>%
      group_by(Genus) %>%
      summarize(number_of_plants= n())%>%
      top_n(n=5, wt= number_of_plants)
    ggplot(treedata1,aes(x=reorder(Genus,-number_of_plants), y= number_of_plants , fill= Genus))+
      geom_bar(stat = 'identity', position = 'dodge')+
      theme_bw()+
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +   # 1pt
      xlab("Genus") +   # 1pt
      ylab("Number_of_plants") +   # 1pt
      ggtitle("Top 5 Trees On The Basis Of Count") +
      theme(plot.title = element_text(hjust = 0.5))+
      geom_text(aes(label= number_of_plants))
      
  }) 
  
  output$bar1<- renderPlot({
    treedata1<- treedata %>% 
      select("Genus", "Useful.Life.Expectancy.Value") %>%
      group_by(Genus) %>%
      summarize(Useful.Life.Expectancy.Value= mean(Useful.Life.Expectancy.Value))  %>%
      top_n(n=5, wt= Useful.Life.Expectancy.Value)
    ggplot(treedata1,aes(x=reorder(Genus,-Useful.Life.Expectancy.Value), y=Useful.Life.Expectancy.Value  , fill= Genus, label= Useful.Life.Expectancy.Value))+
      geom_bar(stat = 'identity', position = 'dodge',)+
      theme_bw()+
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +   # 1pt
      xlab("Genus") +   # 1pt
      ylab("Life_Expectancy") +   # 1pt
      ggtitle("Top 5 trees On The Basis Of Average Life Expectancy") +
      theme(plot.title = element_text(hjust = 0.5))+
      geom_text(aes(label=round(Useful.Life.Expectancy.Value)))
  }) 
  
  output$map<- renderLeaflet({
    leaflet(data1()) %>% addTiles() %>%
      addMarkers(~Longitude, ~Latitude,
                 clusterOptions= markerClusterOptions(), label= input$select_plant_type, popup =  ~ as.character( Diameter.Breast.Height))
  })  
  
}  

# Create Shiny app ----
shinyApp(ui = ui, server = server)