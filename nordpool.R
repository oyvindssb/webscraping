## FJERN "#" foran linjene hvis pakkene ikke allerede er installert
#install.packages("dplyr")
#install.packages("RSelenium")
#install.packages("stringr")
#install.packages("utils")
#install.packages("openxlsx")
#install.packages("seleniumPipes")

library(dplyr)
library(RSelenium)
library(stringr)
library(utils)
library(openxlsx)
library(rstudioapi)


//*[@id="datepicker-00R-3602-16"]/button
//*[@id="datepicker-00R-3602-23"]/button/span
//*[@id="datepicker-00R-3602-31"]/button/span
//*[@id="datepicker-00R-3602-31"]/button/span
//*[@id="datepicker-00R-3602-41"]/button/span


option <- remDr$findElement(using = 'xpath', '//*[@id="data-end-date"]')  ##Velger valuta NOK
#remDr$switchToWindow(option)

option$clickElement() ##Klikker endrer til NOK
navLinks <- option$findChildElements(using = "class", 'pure-button pure-button-default pure-button-sm')

iframe <- remDr$findElement(using = 'xpath', '//*[@id="dashboard-column"]/div/div[3]/div[1]/div[3]/div[2]/div/div[1]/ul/li[1]/div/table')
remDr$switchToFrame(iframe)

navLinks2 <- option$findElements(using = "class", 'pure-button pure-button-default pure-button-sm')
navLinks2$`element-6066-11e4-a52e-4f735466cecf`

remDr$screenshot(display = TRUE) ##Viser siden
option <- remDr$findElement(using = 'xpath', '//*[@id="datepicker-00R-3602-16"]')  ##Velger valuta NOK

option <- remDr$findElement(using = 'xpath', '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div[1]/ul/li[1]/div/table/tbody/tr[5]/td[2]/button')  ##Velger valuta NOK
option$clickElement() ##Klikker endrer til NOK
/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div[1]/ul/li[1]/div/table/tbody/tr[4]/td[4]/button

onsket_mnd <- tolower(rstudioapi::showPrompt("Onsket maned", "Skriv inn maned (på engelsk) du onsker data for:"))

remDr$navigate("https://www.nordpoolgroup.com/Market-data1/Dayahead/Volumes/NO/Hourly2/?view=table")  ##Navigerer til siden for volum
remDr$maxWindowSize(winHand = "current") ##Forstørrer vinduet
option <- remDr$findElement(using = 'xpath', '//*[@id="data-end-date"]')  ##Finner dato element


option$clickElement() ##Klikker på denne (meny åpnes på nettsiden)
remDr$screenshot(display = TRUE) ##Viser siden

markert_mnd <-tolower(word(unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[2]/button/strong')$getElementText()), 1))

if(identical(onsket_mnd, markert_mnd) == FALSE) { ##Går igjennom månedene til den finner ønsket mnd
  option <- remDr$findElement(using = 'xpath', '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[1]/button')  ##Finner dato element
  option$clickElement() ##Klikker på denne (meny åpnes på nettsiden)
  markert_mnd <-tolower(word(unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[2]/button/strong')$getElementText()), 1))
  if(identical(onsket_mnd, markert_mnd) == FALSE) {
    option <- remDr$findElement(using = 'xpath', '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[1]/button')  ##Finner dato element
    option$clickElement() ##Klikker på denne (meny åpnes på nettsiden)
    markert_mnd <-tolower(word(unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[2]/button/strong')$getElementText()), 1))
    if(identical(onsket_mnd, markert_mnd) == FALSE) {
      option <- remDr$findElement(using = 'xpath', '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[1]/button')  ##Finner dato element
      option$clickElement() ##Klikker på denne (meny åpnes på nettsiden)
      markert_mnd <-tolower(word(unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[2]/button/strong')$getElementText()), 1))
      if(identical(onsket_mnd, markert_mnd) == FALSE) {
        option <- remDr$findElement(using = 'xpath', '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[1]/button')  ##Finner dato element
        option$clickElement() ##Klikker på denne (meny åpnes på nettsiden)
        markert_mnd <-tolower(word(unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[2]/button/strong')$getElementText()), 1))
        if(identical(onsket_mnd, markert_mnd) == FALSE) {
          option <- remDr$findElement(using = 'xpath', '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[1]/button')  ##Finner dato element
          option$clickElement() ##Klikker på denne (meny åpnes på nettsiden)
          markert_mnd <-tolower(word(unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[2]/button/strong')$getElementText()), 1))
          if(identical(onsket_mnd, markert_mnd) == FALSE) {
            option <- remDr$findElement(using = 'xpath', '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[1]/button')  ##Finner dato element
            option$clickElement() ##Klikker på denne (meny åpnes på nettsiden)
            markert_mnd <-tolower(word(unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[2]/button/strong')$getElementText()), 1))
            if(identical(onsket_mnd, markert_mnd) == FALSE) {
              option <- remDr$findElement(using = 'xpath', '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[1]/button')  ##Finner dato element
              option$clickElement() ##Klikker på denne (meny åpnes på nettsiden)
              markert_mnd <-tolower(word(unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[2]/button/strong')$getElementText()), 1))
              if(identical(onsket_mnd, markert_mnd) == FALSE) {
                option <- remDr$findElement(using = 'xpath', '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[1]/button')  ##Finner dato element
                option$clickElement() ##Klikker på denne (meny åpnes på nettsiden)
                markert_mnd <-tolower(word(unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[2]/button/strong')$getElementText()), 1))
                if(identical(onsket_mnd, markert_mnd) == FALSE) {
                  option <- remDr$findElement(using = 'xpath', '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[1]/button')  ##Finner dato element
                  option$clickElement() ##Klikker på denne (meny åpnes på nettsiden)
                  markert_mnd <-tolower(word(unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[2]/button/strong')$getElementText()), 1))
                  if(identical(onsket_mnd, markert_mnd) == FALSE) {
                    option <- remDr$findElement(using = 'xpath', '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[1]/button')  ##Finner dato element
                    option$clickElement() ##Klikker på denne (meny åpnes på nettsiden)
                    markert_mnd <-tolower(word(unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[2]/button/strong')$getElementText()), 1))
                    if(identical(onsket_mnd, markert_mnd) == FALSE) {
                      option <- remDr$findElement(using = 'xpath', '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[1]/button')  ##Finner dato element
                      option$clickElement() ##Klikker på denne (meny åpnes på nettsiden)
                      markert_mnd <-tolower(word(unlist(remDr$findElement(using = "xpath", '/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/thead/tr[1]/th[2]/button/strong')$getElementText()), 1))
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

datoer <- data.frame(matrix(NA, nrow = length(seq(1:6)), ncol = length(seq(1:7)))) ##Lager dataframe som brukes i loop

for(i in 1:6) {
  datoer$X1[[i]] <- paste0('/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/tbody/tr[', paste0(i, ']/td[2]/button')) 
  datoer$X2[[i]] <- paste0('/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/tbody/tr[', paste0(i, ']/td[3]/button')) 
  datoer$X3[[i]] <- paste0('/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/tbody/tr[', paste0(i, ']/td[4]/button')) 
  datoer$X4[[i]] <- paste0('/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/tbody/tr[', paste0(i, ']/td[5]/button')) 
  datoer$X5[[i]] <- paste0('/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/tbody/tr[', paste0(i, ']/td[6]/button')) 
  datoer$X6[[i]] <- paste0('/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/tbody/tr[', paste0(i, ']/td[7]/button'))
  datoer$X7[[i]] <- paste0('/html/body/div[4]/div/div/div/div[3]/div/div[3]/div[1]/div[3]/div[2]/div/div/ul/li[1]/div/table/tbody/tr[', paste0(i, ']/td[8]/button'))
}

datoer<-as.data.frame((t(datoer)))
datoer <- gather(datoer)

for(i in 1:nrow(datoer)) {
  datoer$dato[[i]] <- unlist(remDr$findElement(using = "xpath", datoer$value[[i]])$getElementText())
}

datoer$dato <- as.numeric(datoer$dato)
datoer <- datoer %>% filter(key != "V1") %>% top_n(dato, n = 1)

option <- remDr$findElement(using = 'xpath', datoer$value[[1]])  ##Velger valuta NOK
option$clickElement() ##Klikker endrer til NOK
remDr$screenshot(display = TRUE) ##Viser siden

##Skrevet av Ãyvind KlÃ¦boe NordgÃ¥rd 01.09.2021
############################################
############################################
############################################
############################################

{
  remDr <- remoteDriver(port = 6991L,
                        remoteServerAddr = "localhost", browserName = "chrome")  ##Lager remotedriver
  remDr$open() ##Ãpner denne
  
  nordpool_data <- data.frame(matrix(NA, nrow = length(seq(1:31)), ncol = length(seq(1:17))))  ##Lager dataframe
  colnames(nordpool_data) <- c("UKE", "VOL_NO1","VOL_NO2","VOL_NO3", "VOL_NO4", "VOL_NO5", "UKE_PRIS", "PRI_OSLO", 
                               "PRI_KRSAND", "PRI_BERGEN", "PRI_TRHEIM", "PRI_TROMSO", "OMSETNING_NO1", "OMSETNING_NO2", "OMSETNING_NO3",
                               "OMSETNING_NO4", "OMSETNING_NO5")  ##Endrer kolonnenavn
  
  remDr$navigate("https://www.nordpoolgroup.com/Market-data1/Dayahead/Volumes/NO/Hourly2/?view=table")  ##Navigerer til siden for volum
  Sys.sleep(1)
  remDr$screenshot(display = TRUE) ##Viser siden
  link_list<- data.frame(matrix(NA, nrow = length(seq(1:31)), ncol = length(seq(1:6)))) ##Lager dataframe som brukes i loop
  
  for (i in 1:nrow(nordpool_data)) {  ##Input til dataframe som skal brukes til loop
    link_list$X1[[i]] <- paste0('//*[@id="datatable"]/tbody/tr[', paste0(i, ']/td[1]')) 
    link_list$X2[[i]] <- paste0('//*[@id="datatable"]/tbody/tr[', paste0(i, ']/td[2]'))
    link_list$X3[[i]] <- paste0('//*[@id="datatable"]/tbody/tr[', paste0(i, ']/td[4]'))
    link_list$X4[[i]] <- paste0('//*[@id="datatable"]/tbody/tr[', paste0(i, ']/td[6]'))
    link_list$X5[[i]] <- paste0('//*[@id="datatable"]/tbody/tr[', paste0(i, ']/td[8]'))
    link_list$X6[[i]] <- paste0('//*[@id="datatable"]/tbody/tr[', paste0(i, ']/td[10]'))
  }
  
  for (j in 1:nrow(nordpool_data)) {  ##Henter data fra siden vha. loop og putter dette i nordpool_data dataframe
    nordpool_data$UKE[[j]] <-unlist(remDr$findElement(using = "xpath", link_list$X1[[j]])$getElementText())
    nordpool_data$VOL_NO1[[j]] <-unlist(remDr$findElement(using = "xpath", link_list$X2[[j]])$getElementText())
    nordpool_data$VOL_NO2[[j]] <-unlist(remDr$findElement(using = "xpath", link_list$X3[[j]])$getElementText())
    nordpool_data$VOL_NO3[[j]] <-unlist(remDr$findElement(using = "xpath", link_list$X4[[j]])$getElementText())
    nordpool_data$VOL_NO4[[j]] <-unlist(remDr$findElement(using = "xpath", link_list$X5[[j]])$getElementText())
    nordpool_data$VOL_NO5[[j]] <-unlist(remDr$findElement(using = "xpath", link_list$X6[[j]])$getElementText())
  }
  
  Sys.sleep(3) ##Tre sekund pause
  
  #####HENTER PRISENE FOR OSLO, KR. SAND, BERGEN, TR.HEIM og TROMSÃ i NOK
  remDr$navigate("https://www.nordpoolgroup.com/Market-data1/Dayahead/Area-Prices/NO/Daily/?view=table") ##Laster inn siden
  Sys.sleep(1)
  remDr$screenshot(display = TRUE) ##Viser siden
  Sys.sleep(2)
  option <- remDr$findElement(using = 'xpath', '//*[@id="data-currency-select"]/option[4]')  ##Velger valuta NOK
  option$clickElement() ##Klikker endrer til NOK
  Sys.sleep(2)
  remDr$screenshot(display = TRUE) ##Viser siden
  
  pris_link<- data.frame(matrix(NA, nrow = length(seq(1:31)), ncol = length(seq(1:6))))  ##Lager dataframe som brukes i loop
  
  for (i in 1:nrow(nordpool_data)) { ##Input til dataframe som skal brukes til loop
    pris_link$X1[[i]] <- paste0('//*[@id="datatable"]/tbody/tr[', paste0(i, ']/td[1]'))
    pris_link$X2[[i]] <- paste0('//*[@id="datatable"]/tbody/tr[', paste0(i, ']/td[2]'))
    pris_link$X3[[i]] <- paste0('//*[@id="datatable"]/tbody/tr[', paste0(i, ']/td[3]'))
    pris_link$X4[[i]] <- paste0('//*[@id="datatable"]/tbody/tr[', paste0(i, ']/td[4]'))
    pris_link$X5[[i]] <- paste0('//*[@id="datatable"]/tbody/tr[', paste0(i, ']/td[6]'))
    pris_link$X6[[i]] <- paste0('//*[@id="datatable"]/tbody/tr[', paste0(i, ']/td[7]'))
  }
  
  for (j in 1:nrow(nordpool_data)) {  ##Henter data fra siden vha. loop og putter dette i nordpool_data dataframe
    nordpool_data$UKE_PRIS[[j]] <-unlist(remDr$findElement(using = "xpath", pris_link$X1[[j]])$getElementText())
    nordpool_data$PRI_OSLO[[j]] <-unlist(remDr$findElement(using = "xpath", pris_link$X2[[j]])$getElementText())
    nordpool_data$PRI_KRSAND[[j]] <-unlist(remDr$findElement(using = "xpath", pris_link$X3[[j]])$getElementText())
    nordpool_data$PRI_BERGEN[[j]] <-unlist(remDr$findElement(using = "xpath", pris_link$X4[[j]])$getElementText())
    nordpool_data$PRI_TRHEIM[[j]] <-unlist(remDr$findElement(using = "xpath", pris_link$X5[[j]])$getElementText())
    nordpool_data$PRI_TROMSO[[j]] <-unlist(remDr$findElement(using = "xpath", pris_link$X6[[j]])$getElementText())
  }
  
  if(identical(nordpool_data$UKE, nordpool_data$UKE_PRIS) == TRUE) {  ##Sjekker at uke kolonner er lik, printer feilmelding hvis ikke
    nordpool_data$UKE_PRIS <- NULL
  } else {
    print("Ulike uker pÃ¥ pris og volum, sjekk data!")
  }
  
  nordpool_data %>% filter(str_sub(nordpool_data$UKE, 5,5) == match(str_to_title(onsket_mnd), month.name)) ##Sjekker at data er samme som ønsket data og fjerner evt. andre observasjoner
  
  for(i in 2:11) {
    nordpool_data[,i] <- str_replace_all(nordpool_data[,i], fixed(" "), "")  ##Fjerner whitespace
    nordpool_data[,i] <- gsub(",", ".", nordpool_data[,i])  ##Erstatter "," med "."
    nordpool_data[,i] <- as.numeric(nordpool_data[,i])  ##Kolonner gjÃ¸res om fra "character" til "numeric"
  }
  
  for(i in 12:16) {
    nordpool_data[,i] <- nordpool_data[,i-10] * nordpool_data[,i-5]  ##Regner ut total omsetning for de fem ulike omrÃ¥dene
  }
  
  nordpool_data[32,] <- NA   ##Legger til en ekstra rad med NA verdier
  nordpool_data[32,1] <- "Sum"  ##Sum blir plassert i samme kolonne som dag
  for(i in 12:16) {
    nordpool_data[32,i] <- sum(nordpool_data[1:31,i]) ##Summerer rad 12:16 som er daglig total omsetning (regnet ut i rad 97-99)
  }  

}
#####SKRIVE EXCEL FIL
getwd() ##Filplassering, i.e. hvor filen kommer til Ã¥ bli lagret.
#setwd("C:/Users/****") ##Fjern # for Ã¥ kjÃ¸re. Skriv inn evt. Ã¸nsket mappe 
write.xlsx(nordpool_data, paste0('nordpool_data_', Sys.Date(), '.xlsx'))  ##Lager excelfil og merker med dagens dato i filnavn
#list.files() Fjern # for Ã¥ kjÃ¸re. Lister filer i mappen
