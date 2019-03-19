require(Quandl)
library(KFAS)

currency = Quandl("FRED/DEXUSUK", start_date="2016-01-01",end_date="2016-12-31",type="xts")
currency=data.frame(currency)
currency=(log(currency$currency))

logmodel <- SSModel(currency ~ SSMtrend(1, Q = 0.01), H = 0.01)
out <- KFS(logmodel)

df<-data.frame(exp(currency),exp(out$a[1:251]),exp(out$att[1:251]),exp(out$alpha[1:251]))
View(df)
col_headings<-c("currency","a","att","alpha")
names(df)<-col_headings
View(df)
ts.plot(ts(exp(currency[100:150])), exp(out$a[100:150]), exp(out$att[100:150]), exp(out$alpha[100:150]), col = 1:4)
title("GBP/USD")

library(TTR)
sma10=data.frame(SMA(exp(currency),n=10))
col_headings<-c("sma10")
names(sma10)<-col_headings
View(sma10)

df<-data.frame(exp(currency[100:150]), exp(out$a[100:150]), exp(out$att[100:150]), exp(out$alpha[100:150]),sma10$sma10[100:150])
View(df)
col_headings<-c("currency","a","att","alpha","sma10")
names(df)<-col_headings
View(df)