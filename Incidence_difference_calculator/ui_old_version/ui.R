# Created by and Copyright (C) 2017-2018 Lamin Juwara (McGill).
# This program is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your option)
# any later version.  This program is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.  You should have received a copy of the GNU
# General Public License along with this program.  If not, see
# <http://www.gnu.org/licenses/>.


library(shiny)
# Define UI

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Incidence Difference Calculator"),
  br(),
  sidebarLayout(
    sidebarPanel(
      fluidPage(
        fluidRow(column(9, downloadButton('downloadData', 'Download Results'))),

        fluidRow(column(9,
                        radioButtons("survey_number", label = h3("Number of surveys:"),
                                     c("Two surveys" = 2,
                                       "Three surveys" = 3)),
                        selected = 2)
        ),
        fluidRow(column(9,
                        radioButtons("case", label = h3("Scenario Type:"),
                                     c("Same MDRI, same FRR estimates in the two surveys" = 1,
                                       "Same MDRI, but different FRR estimates in the two surveys" = 2,
                                       "Different MDRI and FRR estimates in the two surveys" = 3)),
                        selected = 1))),
      #hr(),
      fluidPage(
        h3("Survey Parameters"),
        fluidRow(

          
          column(6, 
                 numericInput("PrevH_1", label = h5("Prevalence of HIV infection in survey 1 (%)"), value = 20, step = 0.1, min=0, max = 100),
                 numericInput("RSE_PrevH_1", label = h5("RSE of Prevalence HIV infection in survey 1 (%)"), value = 2.8, step = 0.1, min=0, max = 100)),
          column(6, 
                 numericInput("PrevR_1", label = h5("Prevalence of recent infections among positives in survey 1 (%)"), value = 10, step = 0.1, min=0, max = 100),
                 numericInput("RSE_PrevR_1", label = h5("RSE of Prevalence of recent infections among positives 1 (%)"), value = 9.8, step = 0.1, min=0, max = 100))
        ),
        fluidRow(
          
          
          column(6, 
                 numericInput("PrevH_2", label = h5("Prevalence of HIV infection in survey 2 (%)"), value = 21, step = 0.1, min=0, max = 100),
                 numericInput("RSE_PrevH_2", label = h5("RSE of Prevalence HIV infection in survey 2 (%)"), value = 3, step = 0.1, min=0, max = 100)),
          column(6, 
                 numericInput("PrevR_2", label = h5("Prevalence of recent infections among positives in survey 2 (%)"), value = 13, step = 0.1, min=0, max = 100),
                 numericInput("RSE_PrevR_2", label = h5("RSE of Prevalence of recent infections among positives 2 (%)"), value = 9.5, step = 0.1, min=0, max = 100))
        ),
        fluidRow(
          conditionalPanel(
            condition = "input.survey_number != 2",
            column(6, 
                   numericInput("PrevH_3", label = h5("Prevalence of HIV infection in survey 3 (%)"), value = 18, step = 0.1, min=0, max = 100),
                   numericInput("RSE_PrevH_3", label = h5("RSE of Prevalence HIV infection in survey 3 (%)"), value = 2.2, step = 0.1, min=0, max = 100)),
            column(6, 
                   numericInput("PrevR_3", label = h5("Prevalence of recent infections among positives in survey 3 (%)"), value = 12, step = 0.1, min=0, max = 100),
                   numericInput("RSE_PrevR_3", label = h5("RSE of Prevalence of recent infections among positives 3 (%)"), value = 5, step = 0.1, min=0, max = 100))
            
          )
          
          
          
        )
      ),
      
      # fluid page for the assay parameters
      #hr(),
      fluidPage(
        h3("Assay Parameters"),
        fluidRow(
          column(6, 
                 numericInput("MDRI_1",
                               label = h5("MDRI estimate of survey 1 (days)"),
                               step = 1,
                               value = 200 ),
                 numericInput("FRR_1",
                               label = h5("FRR estimate of survey 1 (%)"),
                               min = 0,
                               max = 100,
                               step = 0.1,
                               value = 1 )
                 ),
          column(6,
                 numericInput("RSE_MDRI_1", label = h5("RSE of MDRI estimate of survey 1 (%)"), value = 5, step = 0.1),
                 numericInput("RSE_FRR_1", label = h5("RSE of FRR estimate of survey 1 (%)"), value = 20, step = 0.1)
                 
          )),
        fluidRow(
          column(6, 
                 numericInput("MDRI_2",
                              label = h5("MDRI estimate of survey 2 (days)"),
                              step = 1,
                              value = 180 ),
                 numericInput("FRR_2",
                              label = h5("FRR estimate of survey 2 (%)"),
                              min = 0,
                              max = 100,
                              step = 0.1,
                              value = .9 )
          ),
          column(6,
                 numericInput("RSE_MDRI_2", label = h5("RSE of MDRI estimate of survey 2 (%)"), value = 7, step = 0.1),
                 numericInput("RSE_FRR_2", label = h5("RSE of FRR estimate of survey 2 (%)"), value = 20, step = 0.1)
                 
          )),
        ###
        fluidRow(
          conditionalPanel(
            condition = "input.survey_number != 2",
            column(6, 
                   numericInput("MDRI_3",
                                label = h5("MDRI estimate of survey 3 (days)"),
                                step = 1,
                                value = 180 ),
                   numericInput("FRR_3",
                                label = h5("FRR estimate of survey 3 (%)"),
                                min = 0,
                                max = 100,
                                step = 0.1,
                                value = 2 )
            ),
            column(6,
                   numericInput("RSE_MDRI_3", label = h5("RSE of MDRI estimate of survey 3 (%)"), value = 6, step = 0.1),
                   numericInput("RSE_FRR_3", label = h5("RSE of FRR estimate of survey 3 (%)"), value = 10, step = 0.1)
                   
            )
            
          )
          ),
        fluidRow(
          column(10,numericInput("BigT", label = h5("Cut-off time T (days)"), value = 730, step = 10)
          ))
        )


    ),
    mainPanel(
      img(src='SACEMA_logo.jpg', align = "right", height = "75px"),
      #img(src='mcgill.png', align = "right", height = "40px"),
      br(),
      tabsetPanel(type = "tabs",
                  tabPanel("Incidence Difference", tableOutput("tab"),
                           br(),
                           p(""),
                           p(style = "color:black", strong('Parameter Definitions')),
                           #p(strong('Parameter Definitions')),
                           br(style = "color:grey","compare: surveys compared"),
                           br(style = "color:grey","Diff: point estimate of the estimated difference (p.a)"),
                           br(style = "color:grey","CI.Diff.low: lower limit of confidence interval "),
                           br(style = "color:grey","CI.Diff.up: Upper limit of confidence interval"),
                           br(style = "color:grey","RSE.Diff: RSE of difference estimate"),
                           br(style = "color:grey","RSE.Diff.inf.SS: RSE of the difference estimate at the infinite sample size"),
                           br(style = "color:grey","p.value: P-value for incidence estimate "),
                           br(style = "color:grey","p.value.inf.SS: P-value at infinite sample size")
                           ),
                 
                  tabPanel("About", value='tab4_val', id = 'tab4',
                           wellPanel(
                             p("This tool calculates the point estimate of incidence difference, and the 
                               95% CI and p-value for incidence differenc from two or more surveys."),
                             p("Contributors:"),
                             tags$ul(
                               tags$li("Lamin Juwara"),
                               tags$li("Eduard Grebe"),
                               tags$li("Stefano Ongarello"),
                               tags$li("Cari van Schalkwyk"),
                               tags$li("Alex Welte")
                             ),
                             p(em("Built using ", a(strong("inctools"), href = "https://cran.r-project.org/web/packages/inctools/index.html", target = "_blank")))
                           )
                  )
      )
    )
  )
))
