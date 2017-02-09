# This file demonstrates calling SQL in an ad-hoc manner

source("dependencies.R")
source("Settings.R")

library(RODBC)

conn <- odbcDriverConnect(dbConnection)
df <- sqlQuery(conn, iconv(paste(readLines('c:/users/jflam/src/connect/sqlquery.sql', encoding = 'UTF-8', warn = FALSE), collapse = '\n'), from = 'UTF-8', to = 'ASCII', sub = ''))

View(df)