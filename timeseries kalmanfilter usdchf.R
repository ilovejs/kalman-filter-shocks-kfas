require(Quandl)
library(KFAS)

currency = Quandl("FRED/DEXSZUS", start_date="2010-01-01",end_date="2018-09-29",type="xts")
currency=data.frame(currency)
currency=(log(currency$currency))

logmodel <- SSModel(currency ~ SSMtrend(1, Q = 0.01), H = 0.01)
out <- KFS(logmodel)

df<-data.frame(exp(currency[1232:1274]), exp(out$a[1232:1274]), exp(out$att[1232:1274]), exp(out$alpha[1232:1274]))
View(df)
col_headings<-c("currency","a","att","alpha")
names(df)<-col_headings
View(df)
ts.plot(ts(exp(currency[1232:1274])), exp(out$a[1232:1274]), exp(out$att[1232:1274]), exp(out$alpha[1232:1274]), col = 1:4)
title("USD/CHF")

library(TTR)
sma10=data.frame(SMA(exp(currency),n=10))
col_headings<-c("sma10")
names(sma10)<-col_headings
View(sma10)

df<-data.frame(exp(currency[1232:1274]), exp(out$a[1232:1274]), exp(out$att[1232:1274]), exp(out$alpha[1232:1274]),sma10$sma10[1232:1274])
View(df)
col_headings<-c("currency","a","att","alpha","sma10")
names(df)<-col_headings
View(df)