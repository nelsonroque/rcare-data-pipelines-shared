# Load the dotenv library
library(dotenv)

# Load the .env file
load_dot_env()

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# set your token in this working directory
# by creating a .env file that has the following variable
# e.g., 
# REDCAP_API_TOKEN_SCREEN=XXXXXXXX

token <- Sys.getenv("REDCAP_API_TOKEN_SCREEN")
url <- "https://redcap.einsteinmed.org/api/"

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# extract records -----
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

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# write CSV ----
ts_fn = format(Sys.time(), "%Y%m%d_%H%M%S")
write.csv(result, file = paste0("phone_screen_",ts_fn,".csv"), row.names = FALSE)