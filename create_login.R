observeEvent(input$modal, {
  showModal(
    modalDialog(
      title = "Login", size = "m", easyClose = FALSE,
      
      textInput(
        inputId = "username", label = "Username:", value = NULL, placeholder = "Enter Username Here"
      ), # username-text-input
      passwordInput(
        inputId = "password", label = "Password:", value = NULL, placeholder = "Enter Password Here"
      ), # password-text-input
      actionButton("submit", label = "Submit", icon = icon(name = "unlock", class = "fa-2x", lib = "font-awesome"))
    ) # modal-dialog
  ) # show-modal
}) # observe-event


observeEvent(input$submit, {
  removeModal()
}) # observe-event-remove-modal

user <- reactiveVal()

user <- eventReactive(input$submit, {
  data_frame(unique_id = stri_rand_strings(n = 1, length = 10),
             username = input$username,
             password = input$password)
}) # user

DB_NAME <- "Self.sufficiency"
TBL_USER_DATA <- "users"

db_connect <- function(){
  db <- dbConnect(RSQLite::SQLite(), DB_NAME)
  
  print("#######################")
  print("- Connected to Database")
  
  # If a user data table doesn't already exist, create one
  if(!(TBL_USER_DATA %in% dbListTables(db))){
    print("- Warning: No 'users' table found. Creating table...")
    df <- data.frame(unique_id = character(),
                     username = character(),
                     password = character(),
                     stringsAsFactors = FALSE)
    dbWriteTable(db, TBL_USER_DATA, df)
  } 
  
  print("- Table exists.")
  print("#######################")
  dbDisconnect(db)
  print("Disconnected Successfully")
} # test database connection and create user table if one does not exist

db <- dbConnect(RSQLite::SQLite(), DB_NAME) # create database connection

add_user <- function(){
  dbWriteTable(db, "users", user(), append = TRUE)
  print("User Added Successfully!!!")
  print("####################")
  dbDisconnect(db)
  print("Disconnected Successfully")
} # add-user-function

observeEvent(input$submit, {
  add_user()
})

output$test <- renderDataTable({
    datatable(user())
  }) # render-table
