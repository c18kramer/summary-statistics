### Summary Statistics

require(countrycode)
require(stargazer)
require(httr)
require(esquisse)
require(ggplot2)

# set the working directory
setwd("C:/Users/1kkra/Dropbox/School Stuff/Social Data Analytics 496")

# read in the datasets we need
Religion <- read.csv("RCMSMGCY.csv")
GTD <- read.csv("globalterrorismdb_0718dist.csv")
cities <- read.csv("uscities.csv")

# clean them up
rel <- Religion[c("ADHERENT", "CONGREG", "RELTRAD", "CNTYNM", "STATEAB", "YEAR")]
clean_gtd <- GTD[c("iyear", "country", "city", "motive", "summary")]
clean_gtd <- clean_gtd[clean_gtd$iyear >= 1980,]
clean_gtd <- clean_gtd[clean_gtd$country == 217,]
clean_cities <- cities[c("city", "county_name", "population")]

# every county in religion data says "county" at the end so we have to remove it so they match up with the city data
rel$CNTYNM <- substr(rel$CNTYNM,1,nchar(rel$CNTYNM)-7)

# finally going to merge them, must do two mergers
df = merge(rel, clean_cities, by.x = c("CNTYNM"), by.y = c("county_name"))
df2 = merge(df, clean_gtd, by = "city")

# now that we have the complete dataset, make a quick visualization
ggplot(data = df2, aes(x=YEAR, y=ADHERENT, group=1)) +
  geom_line()+
  geom_point()

# not the most useful graph for this data, because with religiosity, it is only given 4 data points
# since it is split up by decade
# In the future, I want to break up each decade so I have yearly data,
# and if I can't find that I will estimate each year by averaging growth or decay
# over that particular decade.
