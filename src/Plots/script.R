# Goal of this project is to collect together a number of beautiful R plots
# that we can use to show off the product

# Histogram
# http://www.r-graph-gallery.com/18-histogram/

par(bg = "grey90")
par(mar = c(0, 0, 0, 0))
a = rnorm(400, mean = -5, sd = 12)
b = rnorm(400, mean = 20, sd = 3)
c = rnorm(200, mean = -20, sd = 3)
hist(a, col = rgb(1, 0.2, 0.2, 0.7), breaks = 50, xlim = c(-40, 40), main = "", ylim = c(-20, 70))
hist(b, col = rgb(0, 1, 0.5, 1), breaks = 15, add = T)
hist(c, col = rgb(0.6, 0.4, 1, 1), breaks = 15, add = T)

# Stacked Density graph
# http://www.r-graph-gallery.com/135-stacked-density-graph/
# 3 plots here

library(ggplot2)

# Let's use the diamonds dataset
data(diamonds)
head(diamonds)

# plot 1: Density of price for each type of cut of the diamond:
ggplot(data = diamonds, aes(x = price, group = cut, fill = cut)) +
    geom_density(adjust = 1.5)

# plot 2: Density plot with transparency (using the alpha argument):
ggplot(data = diamonds, aes(x = price, group = cut, fill = cut)) +
    geom_density(adjust = 1.5, alpha = 0.2)

# plot 3: Stacked density plot:
ggplot(data = diamonds, aes(x = price, group = cut, fill = cut)) +
    geom_density(adjust = 1.5, position = "fill")

# Circular barplot
# http://www.r-graph-gallery.com/80-circular-barplot/

library(ggplot2)

# make data
data = data.frame(group = c("A ", "B ", "C ", "D "), value = c(33, 62, 56, 67))

# Usual bar plot :
ggplot(data, aes(x = group, y = value, fill = group)) +
    geom_bar(width = 0.85, stat = "identity")

# Circular one
ggplot(data, aes(x = group, y = value, fill = group)) +
    geom_bar(width = 0.85, stat = "identity") +

# To use a polar plot and not a basic barplot
coord_polar(theta = "y") +

#Remove useless labels of axis
xlab("") + ylab("") +

#Increase ylim to avoid having a complete circle
ylim(c(0, 75)) +

#Add group labels close to the bars :
geom_text(data = data, hjust = 1, size = 3, aes(x = group, y = 0, label = group)) +

#Remove useless legend, y axis ticks and y axis text
theme(legend.position = "none", axis.text.y = element_blank(), axis.ticks = element_blank())


# Boxplot with jitter
# http://www.r-graph-gallery.com/96-boxplot-with-jitter/

# Create data
names = c(rep("A", 80), rep("B", 50), rep("C", 70))
value = c(rnorm(80, mean = 10, sd = 9), rnorm(50, mean = 2, sd = 15), rnorm(70, mean = 30, sd = 10))
data = data.frame(names, value)

# Basic boxplot
boxplot(data$value ~ data$names, col = terrain.colors(4))

# Add data points
mylevels <- levels(data$names)
levelProportions <- summary(data$names) / nrow(data)

for (i in 1:length(mylevels)) {

    thislevel <- mylevels[i]
    thisvalues <- data[data$names == thislevel, "value"]

    # take the x-axis indices and add a jitter, proportional to the N in each level
    myjitter <- jitter(rep(i, length(thisvalues)), amount = levelProportions[i] / 2)
    points(myjitter, thisvalues, pch = 20, col = rgb(0, 0, 0, .2))

}

# Polynomial curve fitting
# http://www.r-graph-gallery.com/44-polynomial-curve-fitting/

# We create 2 vectors x and y
x <- runif(300, min = -10, max = 10)
y <- 0.1 * x ^ 3 - 0.5 * x ^ 2 - x + 10 + rnorm(length(x), 0, 8)

# plot of x and y :
plot(x, y, col = rgb(0.4, 0.4, 0.8, 0.6), pch = 16, cex = 1.3)

# Can we find a polynome that fit this function ?
model = lm(y ~ x + I(x ^ 2) + I(x ^ 3))

#I can get the features of this model :
summary(model)
model$coefficients
summary(model)$adj.r.squared

#For each value of x, I can get the value of y estimated by the model, and add it to the current plot !
myPredict <- predict(model)
ix <- sort(x, index.return = T)$ix
lines(x[ix], myPredict[ix], col = 2, lwd = 2)
# I add the features of the model to the plot
coeff = round(model$coefficients, 2)
text(3, -70, paste("Model : ", coeff[1], " + ", coeff[2], "*x", "+", coeff[3], "*x^2", "+", coeff[4], "*x^3", "\n\n", "P-value adjusted = ", round(summary(model)$adj.r.squared, 2)))

# Correlation Ellipses
# http://www.r-graph-gallery.com/97-correlation-ellipses/

# Libraries
library(ellipse)
library(RColorBrewer)

# Use of the mtcars data proposed by R
data = cor(mtcars)

# Build a Pannel of 100 colors with Rcolor Brewer
my_colors <- brewer.pal(5, "Spectral")
my_colors = colorRampPalette(my_colors)(100)

# Order the correlation matrix
ord <- order(data[1,])
data_ord = data[ord, ord]
plotcorr(data_ord, col = my_colors[data_ord * 50 + 50], mar = c(1, 1, 1, 1))

#library(ggplot2)
# nmmaps <- read.csv("C:\\Users\\smortaz\\Documents\\conf\\Pass2016\\r\\chicago-nmmaps.csv", as.is = T)

#https: / / raw.githubusercontent.com / smortaz / NBANotebooks / master / chicago - nmmaps.csv

#install.packages('ggplot2')
library(ggplot2)

nmmaps <- read.csv(url("https://raw.githubusercontent.com/smortaz/NBANotebooks/master/chicago-nmmaps.csv"), as.is = T)


nmmaps$date <- as.Date(nmmaps$date)
nmmaps <- nmmaps[nmmaps$date > as.Date("1996-12-31"),]
nmmaps$year <- substring(nmmaps$date, 1, 4)


head(nmmaps)
##      city 


g <- ggplot(nmmaps, aes(date, temp)) + geom_point(color = "firebrick")
g

g + theme(plot.title = element_text(size = 20, face = "bold",
    margin = margin(10, 0, 10, 0)))


ggplot(nmmaps, aes(temp, temp + rnorm(nrow(nmmaps), sd = 20))) + geom_point() +
  xlim(c(0, 150)) + ylim(c(0, 150)) +
coord_equal()


g <- ggplot(nmmaps, aes(date, temp, color = factor(season))) + geom_point()
g

#here there is no legend automatically
ggplot(nmmaps, aes(x = date, y = o3)) + geom_line(color = "grey") + geom_point(color = "red")


ggplot(nmmaps, aes(x = date, y = o3)) + geom_line(aes(color = "Important line")) +
geom_point(aes(color = "My points"))


ggplot(nmmaps, aes(date, temp)) + geom_point(color = "firebrick") +
theme(panel.background = element_rect(fill = 'grey75'))

ggplot(nmmaps, aes(date, temp, color = factor(season))) +
  geom_point() +
scale_color_brewer(palette = "Set1")


library(grid)

my_grob = grobTree(textGrob("This text stays in place!", x = 0.1, y = 0.95, hjust = 0,
  gp = gpar(col = "blue", fontsize = 12, fontface = "italic")))

ggplot(nmmaps, aes(temp, o3)) + geom_point(color = "firebrick") + facet_wrap(~season, scales = "free") +
annotation_custom(my_grob)


g <- ggplot(nmmaps, aes(x = season, y = o3))
g + geom_boxplot(fill = "darkseagreen4")

g + geom_jitter(alpha = 0.5, aes(color = season), position = position_jitter(width = .2))

g + geom_violin(alpha = 0.5, color = "gray") + geom_jitter(alpha = 0.5, aes(color = season),
      position = position_jitter(width = 0.1)) + coord_flip()


ggplot(nmmaps, aes(date, temp)) + geom_point(color = "firebrick") +
stat_smooth()

ggplot(nmmaps, aes(temp, death)) + geom_point(color = "firebrick") +
stat_smooth(method = "lm", se = FALSE)
