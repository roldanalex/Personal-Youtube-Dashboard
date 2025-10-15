# Personal YouTube Feed Dashboard

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![R Version](https://img.shields.io/badge/R-%3E%3D%204.0-blue)](https://www.r-project.org/)
[![Shiny](https://img.shields.io/badge/Powered%20by-Shiny-brightgreen)](https://shiny.rstudio.com/)

## Overview

The Personal YouTube Feed Dashboard is an interactive web application built with R/Shiny that aggregates and displays the latest videos from curated YouTube channels in a clean, organized interface. This dashboard automatically refreshes daily to provide an up-to-date feed of content from your favorite creators.

### Key Features

- **Automated Data Pipeline**: Daily ETL process that fetches the latest videos using the YouTube Data API
- **Responsive Design**: Optimized for both desktop and mobile viewing
- **Interactive Interface**: Browse videos with sortable tables and detailed metadata
- **Theme Support**: Toggle between light and dark themes for comfortable viewing
- **Cloud Integration**: Utilizes AWS S3 for data storage and processing
- **Real-time Updates**: Fresh content delivered automatically without manual intervention

### Technology Stack

- **Frontend**: R Shiny with Bootstrap theming
- **Backend**: R with automated Quarto reporting pipeline
- **Data Storage**: AWS S3
- **APIs**: YouTube Data API v3
- **Deployment**: Shiny Server / shinyapps.io

## Screenshots

### Desktop Version
![Personal YouTube Feed Dashboard - Web Version](figs/personal_yt_dashboard_web.png)

### Mobile Version
<img width="400px" src="figs/personal_yt_dashboard_mobile.png" alt="Personal YouTube Feed Dashboard - Mobile Version">

## Prerequisites

Before setting up this project, ensure you have:

- R (≥ 4.0.0)
- RStudio (recommended)
- YouTube Data API v3 key
- AWS account with S3 access credentials

## Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/roldanalex/Personal-Youtube-Dashboard.git
cd Personal-Youtube-Dashboard
```

### 2. Install Dependencies
```r
# Install required packages
install.packages(c("shiny", "DT", "dplyr", "httr2", "aws.s3", 
                   "readr", "stringr", "tidyr", "plyr", "tidyselect"))
```

### 3. Environment Configuration
Create a `.Renviron` file in the project root and add your API credentials:

```r
youtube_api_key=your_youtube_api_key_here
aws_secret_key=your_aws_secret_key_here
aws_key=your_aws_access_key_here
```

**Important**: Never commit your `.Renviron` file to version control. Ensure it's included in your `.gitignore`.

### 4. Channel Configuration
Update the channel list in `etl_pipeline/data/personal-channels-yt.csv` with your preferred YouTube channels.

## Usage

### Running the Dashboard
```r
# Navigate to the app directory
setwd("app/")

# Launch the Shiny application
shiny::runApp()
```

### ETL Pipeline
The data pipeline runs automatically, but you can also execute it manually:

```r
# Run the ETL pipeline
quarto::quarto_render("etl_pipeline/ETL-Pipeline.qmd")
```

## Project Structure

```
Personal-Youtube-Dashboard/
├── app/                    # Shiny application files
│   ├── ui.R               # User interface definition
│   ├── server.R           # Server logic
│   └── global.R           # Global variables and functions
├── etl_pipeline/          # Data processing pipeline
│   ├── ETL-Pipeline.qmd   # Main ETL script
│   ├── functions.R        # Helper functions
│   └── data/              # Data sources and outputs
├── figs/                  # Application screenshots
└── README.md              # Project documentation
```

## Contributing

This is a personal project, but suggestions and improvements are welcome! Please feel free to:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

**Alexis Roldan**  
📧 [alexis.m.roldan.ds@gmail.com](mailto:alexis.m.roldan.ds@gmail.com)  
🌐 [GitHub Profile](https://github.com/roldanalex)

---

*Built with ❤️ using R and Shiny*
