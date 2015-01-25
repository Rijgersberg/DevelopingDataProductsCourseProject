library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Gas usage by outside temperature"),
    sidebarPanel(
        h3('Parameters'),
        numericInput('heating_temperature', 'Heating temperature (deg C)', 18, min=0,
                     max=25, step=0.5)
#         submitButton('Submit')
    ),
    mainPanel(
        tabsetPanel(
            tabPanel('Introduction',
                h3('Introduction'),
                p('In the Netherlands, most houses are heated by burning of natural
gas, delivered by a nation-wide network. The amount of gas burned depends heavily on the
temperature outside. Therefore, it is hard to determine whether or not your energy
consumption pattern has improved based on the gas bill alone. To be able to compare
energy use, the concept of degree-days has been in wide use.'),
                p('A day is assigned a number of degree-days based on the difference
between the 24-hour average outside temperature and a ficticious temperature called
the heating temperature, via the following formula:'),
                code('degee_days = max(0, heating_temperature - outside_temperature)'),
                p('The idea is that when the outside temperatue is above the heating_temperature,
no heating of the house is required, and gas consumption is at the baseline for heating
water only. Below that temperature, gas consumption for heating is thought to scale
linearly with degree-days.'),
                p('In this app, we will show the linear fit relating degree-days and 
                  gas usage, and will interactively show the effect of changing
                  the heating temperature.'),
                p('For this shiny app, we use open data measuring gas consumption by the
utility Liander (source: https://www.liander.nl/over-liander/innovatie/open-data/data) and temperature
                  data from the Royal Netherlands Meteorological Institute 
                  (KNMI, http://www.knmi.nl/klimatologie/daggegevens/index.cgi).')
            ),
            tabPanel('Temperatures',
                h3('Temperatures'),
                p('This is a static plot of the recorded daily 24-hour average temperature (in degrees C)
                  in De Bilt, the main weather station of the KNMI.'),
                plotOutput('temperaturePlot')
            ),
            tabPanel('Consumption and Prediction',
                h3('Gas consumption and prediction'),
                p('Measured daily gas consumption of a household (Klant 1 in the open dataset) in
                  red, and the predicted consumption based on the linear model and the 
                  degree-days in green. You can see it live-update when you change the
                  heating temperature on the left.'),
                plotOutput('gasPlot')
            ),
            tabPanel('Scatterplot and Fit',
                h3('Scatterplot and Fit'),
                p('Scatterplot of degree-days vs gas usage, which is live-updated with the setting
                  for the heating temperature.'),
                plotOutput('gasTempScatter'),
                verbatimTextOutput('linmod')
            )
        )
    )
))