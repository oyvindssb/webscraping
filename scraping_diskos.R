library(dplyr)
library(RSelenium)
library(stringr)
#library(readr)
#library(readxl)



remDr <- remoteDriver(port = 6991L,
                      remoteServerAddr = "localhost", browserName = "chrome")
remDr$open()
{
remDr$navigate("https://portal.diskos.cgg.com/prod-report-module/")
remDr$screenshot(display = TRUE)
button_element <- remDr$findElement(using = "xpath", '//*[@id="saleableProd"]') ##Saleable Production
button_element$clickElement()
remDr$screenshot(display = TRUE)
Sys.sleep(2)
address_element <- remDr$findElement(using = "xpath", '//*[@id="startDate"]')
address_element$clickElement()

aktuell_dato <- unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div[2]/table/thead/tr/th[2]')$getElementText())

link_list<- data.frame(matrix(NA, nrow = length(seq(1:12)), ncol = length(seq(1:3)))) ##Lager dataframe som brukes i loop

for(i in 1:12) {
  link_list$X1[[i]] <- paste0('/html/body/div[4]/div[2]/table/tbody/tr/td/span[', paste0(i, ']'))
  link_list$X2[[i]] <- tolower(unlist(remDr$findElement(using = "xpath", link_list$X1[[i]])$getElementText()))
}

link_list$X3 <- aktuell_dato
#link_list <- link_list %>% filter(X2 == str_sub(months(seq(Sys.Date(), length = 2, by = "-2 months")[2]), 1,3))

link_list_test <- link_list %>% filter(X2 == str_sub(months(seq(Sys.Date(), length = 2, by = "-3 months")[2]), 1,3))
Sys.sleep(2)

button_element <- remDr$findElement(using = "xpath", '//*[@id="mainSection"]/div[2]/div[2]/div[2]/button[2]')
button_element$clickElement()


###########################
#########FIL 2##################
remDr$navigate("https://portal.diskos.cgg.com/prod-report-module/")
remDr$screenshot(display = TRUE)

button_element <- remDr$findElement(using = "xpath", '//*[@id="consumptionField"]') ##Fuel, Flare and Cold Vent
button_element$clickElement()
remDr$screenshot(display = TRUE)
Sys.sleep(2)
address_element <- remDr$findElement(using = "xpath", '//*[@id="startDate"]')
address_element$clickElement()

aktuell_dato <- unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div[2]/table/thead/tr/th[2]')$getElementText())

link_list<- data.frame(matrix(NA, nrow = length(seq(1:12)), ncol = length(seq(1:3)))) ##Lager dataframe som brukes i loop

for(i in 1:12) {
  link_list$X1[[i]] <- paste0('/html/body/div[4]/div[2]/table/tbody/tr/td/span[', paste0(i, ']'))
  link_list$X2[[i]] <- tolower(unlist(remDr$findElement(using = "xpath", link_list$X1[[i]])$getElementText()))
}
Sys.sleep(2)
link_list$X3 <- aktuell_dato

#link_list <- link_list %>% filter(X2 == str_sub(months(seq(Sys.Date(), length = 2, by = "-2 months")[2]), 1,3))

link_list_test <- link_list %>% filter(X2 == str_sub(months(seq(Sys.Date(), length = 2, by = "-3 months")[2]), 1,3))


button_element <- remDr$findElement(using = "xpath", '//*[@id="mainSection"]/div[2]/div[2]/div[2]/button[2]')
button_element$clickElement()


###########################
#########FIL 3#########
remDr$navigate("https://portal.diskos.cgg.com/prod-report-module/")
remDr$screenshot(display = TRUE)

button_element <- remDr$findElement(using = "xpath", '//*[@id="fieldTankStockCompany"]') ##Fuel, Flare and Cold Vent
button_element$clickElement()
remDr$screenshot(display = TRUE)
Sys.sleep(2)
address_element <- remDr$findElement(using = "xpath", '//*[@id="startDate"]')
address_element$clickElement()

aktuell_dato <- unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div[2]/table/thead/tr/th[2]')$getElementText())

link_list<- data.frame(matrix(NA, nrow = length(seq(1:12)), ncol = length(seq(1:3)))) ##Lager dataframe som brukes i loop

for(i in 1:12) {
  link_list$X1[[i]] <- paste0('/html/body/div[4]/div[2]/table/tbody/tr/td/span[', paste0(i, ']'))
  link_list$X2[[i]] <- tolower(unlist(remDr$findElement(using = "xpath", link_list$X1[[i]])$getElementText()))
}
Sys.sleep(2)
link_list$X3 <- aktuell_dato

#link_list <- link_list %>% filter(X2 == str_sub(months(seq(Sys.Date(), length = 2, by = "-2 months")[2]), 1,3))

link_list_test <- link_list %>% filter(X2 == str_sub(months(seq(Sys.Date(), length = 2, by = "-3 months")[2]), 1,3))


button_element <- remDr$findElement(using = "xpath", '//*[@id="mainSection"]/div[2]/div[2]/div[2]/button[2]')
button_element$clickElement()


####################################
#########FIL 4 ##################
remDr$navigate("https://portal.diskos.cgg.com/prod-report-module/")
remDr$screenshot(display = TRUE)

button_element <- remDr$findElement(using = "xpath", '//*[@id="terminalTankStock"]') ##Fuel, Flare and Cold Vent
button_element$clickElement()
remDr$screenshot(display = TRUE)
Sys.sleep(2)
address_element <- remDr$findElement(using = "xpath", '//*[@id="startDate"]')
address_element$clickElement()

aktuell_dato <- unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div[2]/table/thead/tr/th[2]')$getElementText())

link_list<- data.frame(matrix(NA, nrow = length(seq(1:12)), ncol = length(seq(1:3)))) ##Lager dataframe som brukes i loop

for(i in 1:12) {
  link_list$X1[[i]] <- paste0('/html/body/div[4]/div[2]/table/tbody/tr/td/span[', paste0(i, ']'))
  link_list$X2[[i]] <- tolower(unlist(remDr$findElement(using = "xpath", link_list$X1[[i]])$getElementText()))
}
Sys.sleep(2)
link_list$X3 <- aktuell_dato

#link_list <- link_list %>% filter(X2 == str_sub(months(seq(Sys.Date(), length = 2, by = "-2 months")[2]), 1,3))

link_list_test <- link_list %>% filter(X2 == str_sub(months(seq(Sys.Date(), length = 2, by = "-3 months")[2]), 1,3))


button_element <- remDr$findElement(using = "xpath", '//*[@id="mainSection"]/div[2]/div[2]/div[2]/button[2]')
button_element$clickElement()
}
