library(magrittr)

# reading excel from disk
setwd("~/Documents/gitRepos/LC/")
loan.listing <- read.csv("loan_listing.csv", sep = ",", header = TRUE)
loan.listing$PTI <- loan.listing$INSTALLMENT/(loan.listing$ANNUAL_INCOME/12)
loan.listing$DTI_NUMERATOR <- loan.listing$DEBT_TO_INCOME_RATIO*(loan.listing$ANNUAL_INCOME/12)
loan.listing$DTI_GS2_NUMERATOR <- loan.listing$DTI_NUMERATOR+max(loan.listing$MTG_PAYMENT/12, HOUSING_PAYMENT) + loan.listing$INSTALLMENT
loan.listing$DTI_GS2 <- DTI_GS2_NUMERATOR/(loan.listing$ANNUAL_INCOME/12)

new_loan.listing <- subset(data.file, 
       GRADE %in% c("C", "D", "E", "F", "G") &
         LOAN_AMOUNT <= 50000 & 
         APPLICATION_TYPE %in% c("INDIVIDUAL", "DIRECT_PAY") &
         COLLECTION<=0 &
         INGUIRIES_IN_LAST_6_MONTHS < 5 &
         TOTAL_ACCOUNTS >= 2
         ) %>%
  filter(., MONTH_SINCE_LAST_RECORD > 36 | is.null(MONTH_SINCE_LAST_RECORD)) %>%
  filter(., !(STATE %in% c("WV", "RI", "DE")) | (ifelse(STATE=="GA" & LAON_AMOUNT>=3000, TRUE, FALSE))) %>%
  filter(., (TERM==36 & LOAN_AMOUNT >= 1000 & LOAN_AMOUNT <= 1999 & SUB_GRADE %in% C("A1", "A2", "A3", "A4")) |
           (TERM==60 & LOAN_AMOUNT ))
