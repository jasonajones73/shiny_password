require(shiny)
require(tidyverse)
require(stringi)
require(DT)
require(RSQLite)
require(DBI)

function(input, output, session) {
  
  source("create_login.R", local = TRUE)
  
  db_connect()
  
} # server-function