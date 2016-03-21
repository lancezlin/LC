library(magrittr)
library(dplyr)
# reading excel from disk
setwd("~/Desktop/")
loan_listing <- read.csv("loan_listing.csv", sep = ",", header = TRUE)
loan_id <- read.csv("LOAN_ID.csv", sep = "\n", header = TRUE)
loan_listing$PTI <- loan_listing$INSTALLMENT/(loan_listing$ANNUAL_INCOME/12)*100
loan_listing$DTI_NUMERATOR <- loan_listing$DEBT_TO_INCOME_RATIO*(loan_listing$ANNUAL_INCOME/12)
loan_listing$DTI_GS2_NUMERATOR <- (loan_listing$DTI_NUMERATOR + pmax(loan_listing$MTG_PAYMENT/12, loan_listing$HOUSING_PAYMENT, na.rm = TRUE) + loan_listing$INSTALLMENT)
loan_listing$DTI_GS2 <- loan_listing$DTI_GS2_NUMERATOR/(loan_listing$ANNUAL_INCOME/12)

loan_id_all <- merge(loan_id, loan_listing, by = "LOAN_ID", all.x = TRUE)
# loan_id_all<- select(loan_id_all, LOAN_ID,GRADE,SUBGRADE,TERM, LOAN_AMOUNT,APPLICATION_TYPE, COLLECTIONS_12_MTHS_EXMED,ANNUAL_INCOME,MONTHS_SINCE_LAST_RECORD,
#        INQUIRIES_IN_LAST_6_MONTHS,FICO_RANGE_LOW,
#        TOTAL_ACCOUNTS,PTI,DTI_GS2,ADDRESS_STATE,DEBT_TO_INCOME_RATIO,INSTALLMENT,MTG_PAYMENT,HOUSING_PAYMENT,DTI_NUMERATOR, DTI_GS2_NUMERATOR)
loan_listing_output <- subset(loan_id_all,
       GRADE %in% c("C", "D", "E", "F", "G") &
         LOAN_AMOUNT <= 50000 & 
         APPLICATION_TYPE %in% c("INDIVIDUAL", "DIRECT_PAY") &
         COLLECTIONS_12_MTHS_EXMED<=0 &
         ANNUAL_INCOME > 18000 &
         PTI < 20 &
         INQUIRIES_IN_LAST_6_MONTHS < 5  &
         DTI_GS2 <= 70 &
         FICO_RANGE_LOW >= 660 &
         TOTAL_ACCOUNTS >= 2) %>%
  select(LOAN_ID,GRADE,SUBGRADE,TERM, LOAN_AMOUNT,APPLICATION_TYPE, COLLECTIONS_12_MTHS_EXMED,ANNUAL_INCOME,
         INQUIRIES_IN_LAST_6_MONTHS,FICO_RANGE_LOW,MONTHS_SINCE_LAST_RECORD,
         TOTAL_ACCOUNTS,PTI,DTI_GS2,ADDRESS_STATE,DEBT_TO_INCOME_RATIO,INSTALLMENT,MTG_PAYMENT,HOUSING_PAYMENT,
         DTI_NUMERATOR, DTI_GS2_NUMERATOR) %>%
  subset(., MONTHS_SINCE_LAST_RECORD > 36 | is.na(MONTHS_SINCE_LAST_RECORD))%>%
  subset(., !(ADDRESS_STATE %in% c("WV", "RI", "DE")) | (ifelse(ADDRESS_STATE=="GA" & LOAN_AMOUNT>=3000, TRUE, FALSE)))%>%
  subset(., (TERM==36 & LOAN_AMOUNT >= 1000 & LOAN_AMOUNT <= 1999 & SUBGRADE %in% c("A1", "A2", "A3", "A4")) 
  | (TERM==36 & LOAN_AMOUNT >= 2000 & LOAN_AMOUNT <= 2999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2")) 
  | (TERM==36 & LOAN_AMOUNT >= 3000 & LOAN_AMOUNT <= 3999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5")) 
  | (TERM==36 & LOAN_AMOUNT >= 4000 & LOAN_AMOUNT <= 4999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5","D1")) 
  | (TERM==36 & LOAN_AMOUNT >= 5000 & LOAN_AMOUNT <= 6999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5","D1","D2")) 
  | (TERM==36 & LOAN_AMOUNT >= 7000 & LOAN_AMOUNT <= 9999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5","D1","D2","D3")) 
  | (TERM==36 & LOAN_AMOUNT >= 10000 & LOAN_AMOUNT <= 15999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5","D1","D2","D3","D4")) 
  | (TERM==36 & LOAN_AMOUNT >= 16000 & LOAN_AMOUNT <= 32999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5","D1","D2","D3","D4","D5")) 
  | (TERM==36 & LOAN_AMOUNT >= 33000 & LOAN_AMOUNT <= 50000 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5","D1","D2","D3","D4","D5","E1")) 
  | (TERM==60 & LOAN_AMOUNT >= 1000 & LOAN_AMOUNT <=1999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","B1","B2"))
  | (TERM==60 & LOAN_AMOUNT >= 2000 & LOAN_AMOUNT <= 2999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5")) 
  | (TERM==60 & LOAN_AMOUNT >= 3000 & LOAN_AMOUNT <= 3999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5","D1","D2")) 
  | (TERM==60 & LOAN_AMOUNT >= 4000 & LOAN_AMOUNT <= 4999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5","D1","D2","D3")) 
  | (TERM==60 & LOAN_AMOUNT >= 5000 & LOAN_AMOUNT <= 5999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5","D1","D2","D3","D4")) 
  | (TERM==60 & LOAN_AMOUNT >= 6000 & LOAN_AMOUNT <= 6999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5","D1","D2","D3","D4","D5")) 
  | (TERM==60 & LOAN_AMOUNT >= 7000 & LOAN_AMOUNT <= 10999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5","D1","D2","D3","D4","D5","E1")) 
  | (TERM==60 & LOAN_AMOUNT >= 11000 & LOAN_AMOUNT <= 16999 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5","D1","D2","D3","D4","D5","E1","E2"))
  | (TERM==60 & LOAN_AMOUNT >= 17000 & LOAN_AMOUNT <= 50000 & SUBGRADE %in% c("A1", "A2", "A3", "A4","A5","C1","C2","C3","C4","C5","D1","D2","D3","D4","D5","E1","E2","E3"))  


  )

loan_id_not_pass <- subset(loan_id_all, !(loan_id_all$LOAN_ID %in% loan_listing_output$LOAN_ID))
# write.csv(loan_id_not_pass, file = "loan_id_not_pass.csv")
