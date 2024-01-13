page_sidebar(
  title = h3(" Alexis' Personal Youtube Feed"),
  theme = my_theme,
  sidebar = sidebar(
    open = "open",
    div(
      align = "left",
      h5("This dashboard provides an updated list of the new videos from my favorite Youtube chanels."),
      br(),
      h5("Currently, the feed includes the following channels:")
    ),
    br(),
    uiOutput("channel_list"),
    br(),
    br(),
    radioButtons(
      "current_theme", "App Theme:",
      c("Light" = "zephyr", "Dark" = "darkly"),
      selected = "darkly",
      inline = TRUE
    )
  ),
  h4("Please see below for list of videos. The list is sorted by latest video."),
  div(
    style = "max-height: 100%;",
    DT::dataTableOutput("youtube_video_list")
  ),
  div(style = "margin-bottom: 30px;"), # this adds breathing space between content and footer
  tags$footer(
    fluidRow(
      column(4, "© Alexis Roldan - 2023"),
      column(4, "Personal Youtube Dashboard v1.0.3"),
      column(
        4,
        tags$a(
          href = "mailto:alexis.m.roldan.ds@gmail.com",
          tags$b("Email me"),
          class = "externallink",
          style = "color: white; text-decoration: none"
        )
      ),
      style = "
        position:fixed;
        text-align:center;
        left: 0;
        bottom:0;
        width:100%;
        z-index:1000;  
        height:30px; /* Height of the footer */
        color: white;
        padding: 3px;
        font-weight: bold;
        background-color: #333333"
    )
  )
)