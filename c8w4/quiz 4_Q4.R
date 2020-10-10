library(lubridate) # For year() function below
library(forecast)
dat = read.csv("gaData.csv")

training = dat[year(dat$date) < 2012,]

testing = dat[(year(dat$date)) > 2011,]

tstrain = ts(training$visitsTumblr)

modFit<-bats(tstrain)
plot(tstrain, xlab="time", ylab="visits")
fcast <- forecast(modFit, h=nrow(testing))
plot(fcast)
fcast_lower95 <- fcast$lower[,2]
fcast_upper95 <- fcast$upper[,2]
table( (testing$visitsTumblr>fcast_lower95) & 
         (testing$visitsTumblr<fcast_upper95) )