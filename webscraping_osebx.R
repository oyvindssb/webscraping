library(dplyr)
library(RSelenium)
library(stringr)
library(rvest)
library(utils)
library(lubridate)


remDr <- remoteDriver(port = 6990L,
                      remoteServerAddr = "localhost", browserName = "chrome")

{
links_month <- list()
links_month[1] <- "https://newsweb.oslobors.no/search?category=1001&issuer=&fromDate=2020-01-01&toDate=2020-01-31&market=&messageTitle="
links_month[2] <- "https://newsweb.oslobors.no/search?category=1001&issuer=&fromDate=2020-02-01&toDate=2020-02-29&market=&messageTitle="
links_month[3] <- "https://newsweb.oslobors.no/search?category=1001&issuer=&fromDate=2020-03-01&toDate=2020-03-31&market=&messageTitle="
links_month[4] <- "https://newsweb.oslobors.no/search?category=1001&issuer=&fromDate=2020-04-01&toDate=2020-04-30&market=&messageTitle="
links_month[5] <- "https://newsweb.oslobors.no/search?category=1001&issuer=&fromDate=2020-05-01&toDate=2020-05-31&market=&messageTitle="
links_month[6] <- "https://newsweb.oslobors.no/search?category=1001&issuer=&fromDate=2020-06-01&toDate=2020-06-30&market=&messageTitle="
links_month[7] <- "https://newsweb.oslobors.no/search?category=1001&issuer=&fromDate=2020-07-01&toDate=2020-07-31&market=&messageTitle="
links_month[8] <- "https://newsweb.oslobors.no/search?category=1001&issuer=&fromDate=2020-08-01&toDate=2020-08-31&market=&messageTitle="
links_month[9] <- "https://newsweb.oslobors.no/search?category=1001&issuer=&fromDate=2020-09-01&toDate=2020-09-30&market=&messageTitle="
links_month[10] <- "https://newsweb.oslobors.no/search?category=1001&issuer=&fromDate=2020-10-01&toDate=2020-10-31&market=&messageTitle="
links_month[11] <- "https://newsweb.oslobors.no/search?category=1001&issuer=&fromDate=2020-11-01&toDate=2020-11-30&market=&messageTitle="
links_month[12] <- "https://newsweb.oslobors.no/search?category=1001&issuer=&fromDate=2020-12-01&toDate=2020-12-31&market=&messageTitle="
}


remDr$open()
for (i in 1:length(links_month)) {
  remDr$navigate(links_month[[i]]) ##Navigates to month i
  Sys.sleep(2) ##sleep while page loads
  remDr$screenshot(display = TRUE)  
  html <- list()
  for (i in 1:500) {
    html[[i]] <-paste('//*[@id="root"]/div/main/table/tbody/tr[', paste(i, "]/td[4]/a", sep=""), sep ="") ##xpath's to find number of pages
  }

  html_mtry <- list()
  for (i in 1:500) {
    html_mtry[[i]] <- try(new_click <- remDr$findElement(using = "xpath", html[[i]]), silent = TRUE) ##Testing which pages that work
  }
  try_error_html <- list()
  for (i in 1:500) {
    try_error_html[[i]] <- class(html_mtry[[i]]) == "try-error"  ##Classifies true/false whether it works
  }

  df_2 <- cbind(html, html_mtry, try_error_html)
  df_2 <- as.data.frame(df_2)
  df_2 <- df_2 %>% filter(try_error_html == "FALSE")  ##Only pages marked with FALSE works

  linker_mtry <- data.frame(matrix(NA, nrow = length(seq(1:nrow(df_2))), ncol = length(seq(1:5))))  ##Dataframe to extract information to
  colnames(linker_mtry) <- c("click_link", "link_head", "text_head", "link_attach", "text_attach") ##Change column names
  linker_mtry$click_link <- df_2$html ##defining working links into click_link

    for (i in 1:nrow(df_2)) {
      linker_mtry$link_head[[i]] <- paste0('//*[@id="root"]/div/main/table/tbody/tr[', paste0(i, ']/td[4]/a/div/span/span[1]'))  ##Makes new paste for text of link
      linker_mtry$text_head[[i]] <- tolower(unlist(remDr$findElement(using = "xpath", linker_mtry$link_head[[i]])$getElementText())) ##Extract link text
      linker_mtry$link_attach[[i]] <- paste0('//*[@id="root"]/div/main/table/tbody/tr[', paste0(i, ']/td[6]')) ##Makes new paste for number of attachments
      linker_mtry$text_attach[[i]] <- tolower(unlist(remDr$findElement(using = "xpath", linker_mtry$link_attach[[i]])$getElementText())) ##Extract number of attachments
    }
  linker_mtry <- linker_mtry %>% filter(str_detect(text_head, "annual report | årsrapport | annual | årsrekneskap")) %>% ##detect wheter it is an annual report or not
  mutate(text_attach = as.numeric(text_attach)) %>% filter(text_attach > 0 & text_attach < 4) ##Define attachment as numeric, and number of attachments is 1-3

    for(i in 1:nrow(linker_mtry)) {
      click <- remDr$findElement(using = "xpath", linker_mtry$click_link[[i]])  ##Defines next click
      remDr$screenshot(display = TRUE)
      remDr$mouseMoveToLocation(webElement = click) ##Marks page to navigate to
      click$clickElement() ##Moves to page i (company page)
      Sys.sleep(2)
      remDr$screenshot(display = TRUE)  ### ABOVE LINES NAVIGATES TO THE PAGE
  
  #### PROGRAM DOWNLOADS/SCRAPE DATA FROM THIS
      instrument <- data.frame(matrix(NA, nrow = length(seq(1:(linker_mtry$text_attach[[i]]*2))), ncol = length(seq(1:2))))  ##Makes df based on number of attachments (files)
      colnames(instrument) <- c("mtry", "test_attachment") ##adds column names
      instru_8 <- list() ##Makes two lists to paste xpath links into
      instru_9 <- list()
      for (j in 1:linker_mtry$text_attach[[i]]) {
        instru_8[[j]] <- paste('//*[@id="root"]/div/main/div[2]/div[2]/div[1]/div[8]/ul/li[', paste(j, "]/a", sep=""), sep="") ##Xpath for div[8]
      }
      for (j in 1:linker_mtry$text_attach[[i]]) {
        instru_9[[j]] <- paste('//*[@id="root"]/div/main/div[2]/div[2]/div[1]/div[9]/ul/li[', paste(j, "]/a", sep=""), sep="") ##Xpath for div[9]
      }
      instru_comb <- append(instru_8, instru_9)
      instrument$mtry <- instru_comb
      
        if(linker_mtry$text_attach[[i]] == 1) { ##If 1 attachment
        instrument_8 <-try(new_click <- remDr$findElement(using = "xpath", instrument$mtry[[1]]), silent = TRUE)  ##Tests whether attachment is in div[8] or div[9]
        instrument_9 <-try(new_click <- remDr$findElement(using = "xpath", instrument$mtry[[2]]), silent = TRUE)
        instrument$test_attachment[[1]] <- class(instrument_8) == "try-error"  ##Classifies which one that works
        instrument$test_attachment[[2]] <- class(instrument_9) == "try-error"
        Sys.sleep(1)
        instrument <- instrument %>% filter(test_attachment == "FALSE")
        for (k in 1:nrow(instrument)) {  ##Loops through all attachments
          remDr$screenshot(display = TRUE)
          new_click <- remDr$findElement(using = "xpath", instrument$mtry[[k]])
          remDr$mouseMoveToLocation(webElement = new_click)
          new_click$clickElement()
          remDr$screenshot(display = TRUE)
          Sys.sleep(2)  }
        remDr$goBack()
        } else if(linker_mtry$text_attach[[i]] == 2) { ##If 2 attachments
        instrument_8_1 <-try(new_click <- remDr$findElement(using = "xpath", instrument$mtry[[1]]), silent = TRUE)
        instrument_8_2 <-try(new_click <- remDr$findElement(using = "xpath", instrument$mtry[[2]]), silent = TRUE)
        instrument_9_1 <-try(new_click <- remDr$findElement(using = "xpath", instrument$mtry[[3]]), silent = TRUE)
        instrument_9_2 <-try(new_click <- remDr$findElement(using = "xpath", instrument$mtry[[4]]), silent = TRUE)
        instrument$test_attachment[[1]] <- class(instrument_8_1) == "try-error"
        instrument$test_attachment[[2]] <- class(instrument_8_2) == "try-error"
        instrument$test_attachment[[3]] <- class(instrument_9_1) == "try-error"
        instrument$test_attachment[[4]] <- class(instrument_9_2) == "try-error"
        instrument <- instrument %>% filter(test_attachment == "FALSE")
        Sys.sleep(1)
        for (k in 1:nrow(instrument)) {  ##Loops through all attachments
          remDr$screenshot(display = TRUE)
          new_click <- remDr$findElement(using = "xpath", instrument$mtry[[k]])
          remDr$mouseMoveToLocation(webElement = new_click)
          new_click$clickElement()
          remDr$screenshot(display = TRUE)
          Sys.sleep(2) }
        remDr$goBack()
        } else if(linker_mtry$text_attach[[i]] == 3) { ##If 3 attachments
        instrument_8_1 <-try(new_click <- remDr$findElement(using = "xpath", instrument$mtry[[1]]), silent = TRUE)
        instrument_8_2 <-try(new_click <- remDr$findElement(using = "xpath", instrument$mtry[[2]]), silent = TRUE)
        instrument_8_3 <-try(new_click <- remDr$findElement(using = "xpath", instrument$mtry[[3]]), silent = TRUE)
        instrument_9_1 <-try(new_click <- remDr$findElement(using = "xpath", instrument$mtry[[4]]), silent = TRUE)
        instrument_9_2 <-try(new_click <- remDr$findElement(using = "xpath", instrument$mtry[[5]]), silent = TRUE)
        instrument_9_3 <-try(new_click <- remDr$findElement(using = "xpath", instrument$mtry[[6]]), silent = TRUE)
        Sys.sleep(2)
        instrument$test_attachment[[1]] <- class(instrument_8_1) == "try-error"
        instrument$test_attachment[[2]] <- class(instrument_8_2) == "try-error"
        instrument$test_attachment[[3]] <- class(instrument_8_3) == "try-error"
        instrument$test_attachment[[4]] <- class(instrument_9_1) == "try-error"
        instrument$test_attachment[[5]] <- class(instrument_9_2) == "try-error"
        instrument$test_attachment[[6]] <- class(instrument_9_3) == "try-error"
        Sys.sleep(1)
        instrument <- instrument %>% filter(test_attachment == "FALSE")
        for (k in 1:nrow(instrument)) {  ##Loops through all attachments
          remDr$screenshot(display = TRUE)
          new_click <- remDr$findElement(using = "xpath", instrument$mtry[[k]])
          remDr$mouseMoveToLocation(webElement = new_click)
          new_click$clickElement()
          remDr$screenshot(display = TRUE)
          Sys.sleep(2)
        } 
        remDr$goBack() ## #GOES BACK TO INITIAL PAGE
      }
  Sys.sleep(1)
  remDr$screenshot(display = TRUE)
  }
}

