# REDCap Data Extraction Pipelines

This repo contains scripts that allow you to extract records from a REDCap project using its API and export the data to a CSV file. 

The script is written in R and utilizes the `dotenv` and `httr` libraries.

---

## Prerequisites

1. **R Installation**: Ensure that R is installed on your system.
2. **Required Libraries**: Install the following R libraries:
   - `dotenv`: For managing environment variables.
   - `httr`: For handling HTTP requests.

   You can install these libraries using:
   ```R
   install.packages("dotenv")
   install.packages("httr")
   ```

3. **REDCap API Token**: Obtain the API token for your REDCap project. Ensure the API is enabled for the project.

---

## Setup Instructions

1. **Create a `.env` File**: 
   In the working directory of your script, create a `.env` file and include the following line with your REDCap API token:
   ```
   REDCAP_API_TOKEN_SCREEN=your_redcap_api_token_here
   ```

2. **Set API URL**:
   Update the `url` variable in the script to match the API URL for your REDCap instance. Example:
   ```R
   url <- "https://redcap.einsteinmed.org/api/"
   ```

---

## How to Use

1. **Load the Environment Variables**:
   The script uses the `dotenv` library to load the token from the `.env` file.

2. **Run the Script**:
   Execute the script to extract records from the REDCap project and export them to a CSV file.

3. **CSV Output**:
   The exported CSV file is saved in the `./output/` directory with a timestamped filename:
   ```
   phone_screen_YYYYMMDD_HHMMSS.csv
   ```

---

## Script Breakdown

### Load Environment Variables
```R
library(dotenv)
load_dot_env()
```
Loads the `.env` file to access the `REDCAP_API_TOKEN_SCREEN` variable.

### API Request
```R
formData <- list("token"=token,
                 content='record',
                 action='export',
                 format='csv',
                 type='flat',
                 csvDelimiter='',
                 'forms[0]'='phone_screen',
                 rawOrLabel='raw',
                 rawOrLabelHeaders='raw',
                 exportCheckboxLabel='false',
                 exportSurveyFields='false',
                 exportDataAccessGroups='false',
                 returnFormat='csv'
)
response <- httr::POST(url, body = formData, encode = "form")
result <- httr::content(response)
```
This section sends a POST request to the REDCap API to export the records.

### Write Output
```R
ts_fn = format(Sys.time(), "%Y%m%d_%H%M%S")
write.csv(result, file = paste0("./output/phone_screen_",ts_fn,".csv"), row.names = FALSE)
```
Generates a timestamped filename and saves the extracted data as a CSV file.

---

## Notes

- Ensure the `output` directory exists in your working directory, or create it before running the script.
- Replace the `forms[0]` value with the form name you wish to export from your REDCap project.

---

## Troubleshooting

- **Invalid Token**: Verify that the `.env` file contains the correct API token.
- **Missing Output**: Check that the API URL and form name match your REDCap project configuration.
- **Network Issues**: Ensure your system can access the REDCap API URL.

For additional information on the REDCap API, refer to the [REDCap API Documentation](https://projectredcap.org).