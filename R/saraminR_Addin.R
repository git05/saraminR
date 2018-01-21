#' @title Launch an RStudio addin which allows to schedule an Rscript interactively.
#' @description Launch an RStudio addin which allows to schedule an Rscript interactively.
#'
#' @return the return of \code{\link[shiny]{runGadget}}
#' @export
#' @import shiny
#' @import miniUI
#' @import shinyFiles
#' @import utils
#' @import shinycssloaders
#' @examples
#' \dontrun{
#' cron_rstudioaddin()
#' }
#'
#'
#'

runsaramin = function(){
  download = "F"
  requireNamespace("shiny")
  requireNamespace("miniUI")
  requireNamespace("shinyFiles")

  check <- NULL

  ui <- miniUI::miniPage(
    # Shiny fileinput resethandler
    # shiny::tags$script('
    #                    Shiny.addCustomMessageHandler("resetFileInputHandler", function(x) {
    #                    var id = "#" + x + "_progress";
    #                    var idBar = id + " .bar";
    #                    $(id).css("visibility", "hidden");
    #                    $(idBar).css("width", "0%");
    #                    });
    #                    '),

    miniUI::gadgetTitleBar("Easy use Saramin API"),

    miniUI::miniTabstripPanel(
      miniUI::miniTabPanel(title = 'Data Export', icon = shiny::icon("table"),
                           miniUI::miniContentPanel(
                             shiny::fillRow(flex = c(6, 0),
                                            shiny::column(6,
                                                          shiny::h4("Search Saramin Data"),
                                                          shiny::textInput("keyword",label = "Input Keywords"),
                                                          shiny::actionButton("search", "Search Keywords", icon = shiny::icon("refresh")),
                                                          shiny::actionButton('excel', "Download Excel", icon = shiny::icon("table")),
                                                          shiny::br(),
                                                          shiny::br(),
                                                          shiny::dataTableOutput("data")

                                            )
                                          )
                           )
      )
    )
  )

  # Server code for the gadget.
  server <- function(input, output, session) {
    shiny::observeEvent(input$search, {
      if(input$keyword==""){
        shiny::showModal(shiny::modalDialog(
          title = "Saramin api","Please Insert Keywords"
        ))
        print("abc")
      } else {
      saramin.data = saraminR::saramin(input$keyword)
      output$data = shiny::renderDataTable({
        saramin.data
        })
      shiny::showModal(shiny::modalDialog(
        title = "Saramin api","Comlete!"
      ))
      }
    })

    shiny::observeEvent(input$excel, {

      if(input$keyword==""){
        shiny::showModal(shiny::modalDialog(
          title = "Saramin api","Please Insert Keywords"
        ))
      } else {
        saramin.data = saraminR::saramin(input$keyword)
        utils::write.csv(saramin.data,paste0("saramin_data_",input$keyword,"_",Sys.time(),".xlsx"))
        shiny::showModal(shiny::modalDialog(
          title = "Saramin api","Comlete!"
        ))
      }
    })

  }

  # Use a modal dialog as a viewr.
  viewer <- shiny::dialogViewer("Cron job scheduler", width = 1000, height = 800)
  #viewer <- shiny::paneViewer()
  shiny::runGadget(ui, server, viewer = viewer)}
