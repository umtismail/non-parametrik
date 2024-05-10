fixed_acidity_samples <- read.csv("C:/Users/Eugeo/Desktop/non parametrik/bağımsız/fixed_acidity_samples.csv")
fix
summary(fixed_acidity_samples["bad"])
summary(fixed_acidity_samples["good"])
summary(fixed_acidity_samples["high"])

shapiro.test(fixed_acidity_samples$bad)
shapiro.test(fixed_acidity_samples$good)
shapiro.test(fixed_acidity_samples$high)

hist(fixed_acidity_samples$bad)
hist(fixed_acidity_samples$good)
hist(fixed_acidity_samples$high)

library(car)
qqPlot(fixed_acidity_samples$bad,
       distribution = "norm",
       main = "Normal Q-Q Plot of 'bad'")  

qqPlot(fixed_acidity_samples$good,
       distribution = "norm",
       main = "Normal Q-Q Plot of 'bad'")  

qqPlot(fixed_acidity_samples$high,
       distribution = "norm",
       main = "Normal Q-Q Plot of 'bad'")  

library(ggplot2)

data <- data.frame(
  category = rep(c("bad", "good", "high"), each = length(fixed_acidity_samples$bad)),
  value = c(fixed_acidity_samples$bad, fixed_acidity_samples$good, fixed_acidity_samples$high)
)


ggplot(data, aes(x = category, y = value)) +
  geom_boxplot() +
  labs(title = "Boxplots of 'bad', 'good', and 'high'") +
  theme_bw() + 
  theme(  #
    plot.margin = margin(10, 10, 10, 10),
    panel.spacing = unit(2, "lines")
  )


library(DescTools)
median_b <- median(fixed_acidity_samples$bad)
SignTest(x=fixed_acidity_samples$bad,mu=median_b,alternative="less",conf.level=0.99)

median_g <- median(fixed_acidity_samples$good)
SignTest(x=fixed_acidity_samples$good,mu=median_g,alternative="greater",conf.level=0.99)

median_h <- median(fixed_acidity_samples$high)
SignTest(x=fixed_acidity_samples$high,mu=median_h,alternative="two.sided",conf.level=0.99)


library(stats)
wilcox.test(fixed_acidity_samples$bad,mu=median_b,alternative="less") 
wilcox.test(fixed_acidity_samples$good,mu=median_g,alternative="greater") 
wilcox.test(fixed_acidity_samples$high,mu=median_h,alternative="two.sided") 


SiegelTukeyTest(fixed_acidity_samples$bad,fixed_acidity_samples$good,alternative="greater",conf.level=0.95)
SiegelTukeyTest(fixed_acidity_samples$bad,fixed_acidity_samples$high,alternative="less",conf.level=0.95)
SiegelTukeyTest(fixed_acidity_samples$good,fixed_acidity_samples$high,alternative="two.sided",conf.level=0.95)

kruskal.test(list(fixed_acidity_samples$bad, fixed_acidity_samples$good, fixed_acidity_samples$high))


library(FSA)
scoref <- c(fixed_acidity_samples$bad, fixed_acidity_samples$good, fixed_acidity_samples$high)
quality <- rep(c("bad", "good", "high"), each = 30)
dff <- data.frame(score = scoref, quality = quality)
DunnTest(score ~ quality, data = dff, method = "BH")


#Bağımsız


exams <- read.csv("C:/Users/Eugeo/Desktop/non parametrik/bağımlı/exams.csv")
samplea <- exams[exams$race.ethnicity == "group C", ]
head(samplea)

summary(samplea["math.score"])
summary(samplea["reading.score"])
summary(samplea["writing.score"])

shapiro.test(samplea$math.score)
shapiro.test(samplea$reading.score)
shapiro.test(samplea$writing.score)

hist(samplea$math.score)
hist(samplea$reading.score)
hist(samplea$writing.score)

library(car)
qqPlot(fixed_acidity_samples$bad,
       distribution = "norm",
       main = "Normal Q-Q Plot of 'math'")  

qqPlot(fixed_acidity_samples$good,
       distribution = "norm",
       main = "Normal Q-Q Plot of 'reading'")  

qqPlot(fixed_acidity_samples$high,
       distribution = "norm",
       main = "Normal Q-Q Plot of 'writing'")  

library(ggplot2)

data <- data.frame(
  category = rep(c("math", "reading", "writing"), each = length(samplea$math.score)),
  value = c(samplea$math.score, samplea$reading.score, samplea$writing.score)
)


ggplot(data, aes(x = category, y = value)) +
  geom_boxplot() +
  labs(title = "Boxplots of 'math', 'reading', and 'writing'") +
  theme_bw() + 
  theme(
    plot.margin = margin(10, 10, 10, 10),
    panel.spacing = unit(2, "lines")
  )


library(stats)
wilcox.test(samplea$math.score,samplea$reading.score,alternative="less") 
wilcox.test(samplea$math.score,samplea$writing.score,alternative="greater") 
wilcox.test(samplea$reading.score,samplea$writing.score,alternative="two.sided") 


dataf <- data.frame(prson=rep(1:323),
                   category = rep(c("1", "2", "3"), each = length(samplea$math.score)),
                   value = c(samplea$math.score, samplea$reading.score, samplea$writing.score)
)
friedman.test(y = dataf$value, groups = dataf$category, blocks = dataf$prson)


library(FSA)
scoref <- c(samplea$math.score, samplea$reading.score, samplea$writing.score)
quality <- rep(c("math", "read", "writing"), each = 323)
dff <- data.frame(score = scoref, quality = quality)
DunnTest(score ~ quality, data = dff, method = "BH")


library(readxl)
Kitap1 <- read_excel("C:/Users/Eugeo/Desktop/non parametrik/bağımsız/Kitap1.xlsx")
library(Kendall)
MannKendall(Kitap1$`en düşük sıcaklık ortalamaları`)

