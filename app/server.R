function(input, output, session) {

  observeEvent(input$current_theme, {
    
    # Make sure theme is kept current with desired
    session$setCurrentTheme(
      bs_theme_update(
        my_theme, bootswatch = input$current_theme)
    )

  })

  output$channel_list <- renderUI({

    yt_data_wrangled |>
    dplyr::arrange(chapter) |>
    dplyr::distinct(channel_image_url) |>
    dplyr::pull() |>
    htmltools::HTML(.noWS = "outside")

  })
  
  output$youtube_video_list <- DT::renderDataTable({

    yt_data_wrangled |>
      dplyr::select(-chapter, -channel_image_url) |>
      dplyr::arrange(desc(date))

  },
  colnames = c("Date", "Channel", "Video"),
  filter = "top",
  escape = FALSE,
  height = "1000",
  options = list(
    scrollX = TRUE,
    # pageLength = 9,
    dom = "Bfrtip",
    searching = TRUE,
    columnDefs = list(
      list(
        className = "dt-middle",
        targets = "_all"
      )
    )
  )
  
)}