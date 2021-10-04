library(RSelenium)
library(tidyverse)
library(stringr)
#rm(list=ls())
#remDr$close()
{
  
  instrument_8 <- list()
  for (i in 1:3) {
    instrument_8[i] <- paste('//*[@id="root"]/div/main/div[2]/div[2]/div[1]/div[8]/ul/li[', paste(i, "]/a", sep=""), sep="") ##Lager paste for instrument 8 vedlegg 1-3
  }
  instrument_9 <- list()
  for (i in 1:3) {
    instrument_9[i] <- paste('//*[@id="root"]/div/main/div[2]/div[2]/div[1]/div[9]/ul/li[', paste(i, "]/a", sep=""), sep="") ##Lager paste for instrument 9 vedlegg 1-3
  }
  
  
  remDr <- remoteDriver(port = 6991L,
                        remoteServerAddr = "localhost", browserName = "chrome")
  Sys.sleep(3)
  remDr$open()
  Sys.sleep(3)
  remDr$navigate("https://newsweb.oslobors.no/search?category=1001&fromDate=2020-09-01&toDate=2020-09-30")   ##Navigerer til måned
  Sys.sleep(2)
  remDr$screenshot(display = TRUE)
  
  html <- list()
  for (i in 1:500) {
    html[[i]] <-paste('//*[@id="root"]/div/main/table/tbody/tr[', paste(i, "]/td[4]/a", sep=""), sep ="") ##Lager paste kode for å finne antall på siden
  }
  
  html_mtry <- list()
  for (i in 1:500) {
    html_mtry[[i]] <- try(new_click <- remDr$findElement(using = "xpath", html[[i]]), silent = TRUE) ##Sjekker hvilke som fungerer
  }
  try_error_html <- list()
  for (i in 1:500) {
    try_error_html[[i]] <- class(html_mtry[[i]]) == "try-error"  ##Klassifiserer hvorvidt den fungerer med true/false
  }
  
  df_2 <- cbind(html, html_mtry, try_error_html)
  df_2 <- as.data.frame(df_2)
  View(df_2)
  df_2 <- df_2 %>% filter(try_error_html == "FALSE") %>% nrow()  ##False kun de som fungerer
  
  for (i in 1:df_2) {       ##Bruker antall observasjoner fra true/false df_2
    tryCatch({
      Sys.sleep(3)
      click <- remDr$findElement(using = "xpath", html[[i]])
      remDr$screenshot(display = TRUE)
      click$mouseMoveToLocation(webElement = click)
      click$clickElement()
      remDr$screenshot(display = TRUE)
      mtry <- list()
      mtry8_1 <- try(new_click <- remDr$findElement(using = "xpath", instrument_8[[1]]), silent = TRUE) ##Sjekker hvilke vedlegg linker som fungerer
      Sys.sleep(0.5)
      mtry8_2 <- try(new_click <- remDr$findElement(using = "xpath", instrument_8[[2]]), silent = TRUE)
      Sys.sleep(0.5)
      mtry8_3 <- try(new_click <- remDr$findElement(using = "xpath", instrument_8[[3]]), silent = TRUE)
      Sys.sleep(0.5)
      mtry9_1 <- try(new_click <- remDr$findElement(using = "xpath", instrument_9[[1]]), silent = TRUE)
      Sys.sleep(0.5)
      mtry9_2 <- try(new_click <- remDr$findElement(using = "xpath", instrument_9[[2]]), silent = TRUE)
      Sys.sleep(0.5)
      mtry9_3 <- try(new_click <- remDr$findElement(using = "xpath", instrument_9[[3]]), silent = TRUE)
      mtry <- list()
      mtry[[1]] <- "mtry8_1"
      mtry[[2]] <- "mtry8_2"
      mtry[[3]] <- "mtry8_3"
      mtry[[4]] <- "mtry9_1"
      mtry[[5]] <- "mtry9_2"
      mtry[[6]] <- "mtry9_3"
      try_error <- list()
      try_error[[1]] <- class(mtry8_1) == "try-error"
      try_error[[2]] <- class(mtry8_2) == "try-error"
      try_error[[3]] <- class(mtry8_3) == "try-error"
      try_error[[4]] <- class(mtry9_1) == "try-error"
      try_error[[5]] <- class(mtry9_2) == "try-error"
      try_error[[6]] <- class(mtry9_3) == "try-error"
      df <- as.data.frame(cbind(mtry, try_error))
      test <- list()
      test[[1]] <- mtry8_1
      test[[2]] <- mtry8_2
      test[[3]] <- mtry8_3
      test[[4]] <- mtry9_1
      test[[5]] <- mtry9_2
      test[[6]] <- mtry9_3
      df <- cbind(mtry, try_error, test)
      df <- as.data.frame(df)
      df$nr <- as.numeric(1:6)
      df <- df %>% filter(try_error == "FALSE") %>% top_n(1, nr)  ##Velger den som fungerer med flest vedlegg
      df$loop <- str_sub(df$mtry,-1,-1) ##Substracter 1, 2 eller 3 utifra hvor mange vedlegger
      df$instrument <- str_sub(df$mtry, -3, -3) ##Substracter hvilket instrument
      temp_paste <- paste('//*[@id="root"]/div/main/div[2]/div[2]/div[1]/div[', paste(df$instrument, "]/ul/li[", sep=""), sep="")  ##Paste med instrument
      ferdig_instrument <- list()
      for (k in 1:df$loop) {
        ferdig_instrument[k] <- paste(temp_paste, paste(k, "]/a", sep=""), sep="") ##Paste med instrument og loop
      }
      for (j in 1:length(ferdig_instrument)) {  ##Looper igjennom alle vedleggene
        Sys.sleep(3)
        remDr$screenshot(display = TRUE)
        new_click <- remDr$findElement(using = "xpath", ferdig_instrument[[j]])
        remDr$mouseMoveToLocation(webElement = new_click)
        new_click$clickElement()
        remDr$screenshot(display = TRUE)
      } 
      remDr$navigate("https://newsweb.oslobors.no/search?category=1001&issuer=&fromDate=2020-09-01&toDate=2020-09-30&market=&messageTitle=") 
      remDr$screenshot(display = TRUE)},
      error=function(e){})
  }
}





