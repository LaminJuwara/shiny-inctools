  # Created by Lamin Juwara (McGill) 2017/18 
# This program is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your option)
# any later version.  This program is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.  You should have received a copy of the GNU
# General Public License along with this program.  If not, see
# <http://www.gnu.org/licenses/>.

#server.R
library(shiny)
library(ggplot2)
library(scales)
library(plyr)
library(dplyr)
library(grid)
library(inctools)
source('prev_inc_calc.R')


shinyServer(function(input, output, session){

  #shinyURL.server(session)
  data_prevalence <- reactive({ # for prevalence calculation
    temp <- prevalence_calc(N = input$N, N_H = input$N_H, 
                            N_testR = input$N_testR, N_R = input$N_R, 
                            DE_H = input$DE_H, DE_R = input$DE_R) 
    return(temp)
  })
  
  data_incidence <- reactive({ # for incidence calculiation
    temp <- incidence_calc(N = input$N, N_H = input$N_H, 
                           N_testR = input$N_testR, N_R = input$N_R, 
                           DE_H = input$DE_H, DE_R = input$DE_R,
                           MDRI = input$MDRI, RSE_MDRI = input$RSE_MDRI,
                           FRR = input$FRR, RSE_FRR = input$RSE_FRR,
                           BigT = input$BigT) 
    return(temp)
  })
  
  data_risk <- reactive({ # for risk of infection calculiation
    temp <- risk_of_infection_calc(N = input$N, N_H = input$N_H, 
                           N_testR = input$N_testR, N_R = input$N_R, 
                           DE_H = input$DE_H, DE_R = input$DE_R,
                           MDRI = input$MDRI, RSE_MDRI = input$RSE_MDRI,
                           FRR = input$FRR, RSE_FRR = input$RSE_FRR,
                           BigT = input$BigT) 
    return(temp)
  })
  
# Output value  
   

  # Produce an output table value.
  output$tab1 <- renderTable({
    data_prevalence()
    
  })
  output$tab2 <- renderTable({
    data_incidence()
    
  })
  output$tab3 <- renderTable({
    data_risk()
    
  })

  output$downloadData <- downloadHandler(
    filename = function() {
      paste("PrevInc-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(c(data_prevalence(),data_incidence(),data_risk()) , file)
    }
  )

 

})
