#R_general_cheat-sheet

#Shortcuts
#alt + minus = <-
#ctrl + enter = execute selected part

#BASIC_GRAPHING_____________________________________________________________####

#load basic R dataset
library(datasets)

#look at the first few lines
head(iris)

#get information on commands or datasets
?iris

#plotting
plot(iris$Species) #plot categorical variable
plot(iris$Petal.Length) #plot quantitative variable
plot(iris$Species, iris$Petal.Length) #cat x quant
plot(iris$Petal.Width, iris$Petal.Length) #quant x quant
plot(iris) #matrix for holistic overview

#plotting with options
plot(iris$Petal.Length, iris$Petal.Width,
     col = "#cc0000", #hex code for red
     main = "iris: pethal length vs. petal width", #header
     xlab = "petal length", #x axis lable
     ylab = "petal width" #y axis lable
)

#plot formulas
plot(sin, 0, 2 * pi,
     lwd = 5, #line width
     col = "blue",
     main = "sine curve"
)
plot(dnorm, -pi, pi, 
     lwd = 10,
     main = "standard normal distribution",
     xlab = "z-scores",
     ylab = "density",
     col = "green"
)
plot(exp, 0, 8)

#bar charts - simple is good
#bar charts are the most simple graphics
#for the most simple data
?mtcars
head(mtcars)

#bar chart
barplot(mtcars$cyl) #doesn't work
cylinders <- table(mtcars$cyl) #create table and assign it to variable
barplot(cylinders)

#PROBABILITY________________________________________________________________####

#sample
set.seed(4) #set seed to identify errors
x <- sample(6, 1000, replace = TRUE) #draw randint out of 6, 1000x, with replacing
barplot(table(x))

#roll a d6 1000 times and assign 80% probability to the number 6
x <- sample(6, 1000, replace = TRUE, c(rep(0.2 / 5, 5),0.80))
barplot(table(x),
        xlab = "Number",
        ylab = "Occurance")
#same experiment, fill results into matrix
mat <- matrix(NA, nrow = n, ncol = 2)
for(i in 1:1000){
  mat[i,] <- sample(1:6, size = 2, replace = T)
}

#graph the probabilities of the sum for a roll of two d6
p <- c(1:6, 5:1)/36
plot(2:12, p, type = "h", las = 1, xlab = "sum of two die")

#roll a dice 3 times. what is P("no 4")? - (5/6)^3 = 0.579
sample(1:6, 3, T) #simulation of the question above
#do the experiment x times and count the relative frequency of P("no four")
experiment_amount <- c(100000)
results_with_four <- c(0)
for(roll in 1:experiment_amount){
  result <- sample(1:6, 3, T)
  if(4 %in% result){
    results_with_four <- results_with_four + 1
  }
}
1 - (results_with_four/experiment_amount)
#same experiment
experiment_amount <- c(100000)
simulation_1 <- function(x){
  roll_3 <- sample(1:6, 3, T)
  no_four <- sum(roll_3 == 4) == 0
}
results_without_four <- sapply(1:experiment_amount, simulation_1)
sum(results_without_four)/experiment_amount

#what is the probability to get 7 or more sixes after 10 d6 rolls
n <- 100000 #experiment with 100000 rolls
y <- rep(NA, n)
for(i in 1:n){
  w <- sample(1:6, 10, T) #roll d6 10 times
  count_sixes <- sum(w == 6) #count amount of sixes
  y[i] <- (count_sixes >= 7)
}
100*(sum(y)/n)
#same experiment, with a matrix
n <- 100000 #experiment with 100000 rolls
w <- sample(1:6, 10 * n, T)
mat <- matrix(data = w, ncol = 10)
head(mat) #look at the structure of matrix
number_of_sixes <- apply(mat, 1, function(x){sum(x == 6)})
sum(number_of_sixes >= 7)/nrow(mat)

#for loop: Draw two spheres out of 4 without replacing them, repeat 10x
for (i in 1:10){
  print(sample(x = c("r", "g", "b", "o"), size = 2, replace = FALSE))}

#binomial distribution
#example: historically have 68.4% of the student passed a certain class
k <- 15 #what is the probability that 15 will pass?
n <- 20 #given we have 20 students this semester
p <- 0.684
dbinom(x = k, size = n, prob = p)
#distribution of all possible values the bernoulli random variable X can take
k <- 0:20
pk <- dbinom(k, 20, 0.684)
plot(k, pk, type = "h",
     main = "Bin(n = 20, p = 0.684)")
#for p = 5 or as n grows: symmetrical graph
#rule of thumb: if np(1-p) > 10, symmetrical Bin(n,p)

#binomial distribution: cumulative distribution function
#example: what's the probability that 4 or less students pass the class? P(X<=3)
pbinom(4, 20, 0.684)
#example: what's the probability that 15 or more students pass the class? P(X>=15)
sum(dbinom(16:20, 20, 0.684))
1 - pbinom(15, 20, 0.684) #same resultas above: P(X>15) = 1-P(X<=15)
#example: what's the probability that between 13 and 16 students pass the class? P(13<=X<=16)
sum(dbinom(13:16, 20, 0.684))

#binomial distribution: quantiles
#example: 90%-quantile to pass class: what's the maximum of students passing in 90% of the cases?
alpha <- 0.9 #alpha-quantiles: P(X<=x)>=alpha
qbinom(alpha, 20, 0.684)

#binomial distribution: simulation
#example: simulate a semester outcome for the class
set.seed(4)
rbinom(n = 1, 20, 0.684) #13 students have passed the class

#geometrical distribution
#example: what's the probability of getting a 5 with a d6 after the 4 throw? (3 fails followed by 1 success)
dgeom(3, prob = 1/6) #ATTENTION: first argument in the function is the count of fails!

#geometrical distribution: cumulative distribution function
#example: what's the probability of having 3 or less fails while trying to roll a 5 with a d6?
pgeom(3, 1/6) #P(X<=3)
#example: what's the probability of rolling more than 3 fails?
1 - pgeom(3, 1/6) #P(X>3)

#geometrical distribution: quantiles
#example: what's the maximum of fails we are going to see in 90% of the cases?
qgeom(0.9, 1/6)

#geometrical distribution
#example: simulate fails given a probability
set.seed(4)
rgeom(1, 1/6) #in this case we rolled a five with the first try

#negative binomial distribution
dnbinom(x = , size = r, prob = p) #probability function
pnbinom(x = , size = r, prob = p) #cummulative probability function
qnbinom(x = , size = r, prob = p) #quantile function
rnbinom(x = , size = r, prob = p) #random number
#example: number of fails X until the third win at a lottery with p = 0.05. what's the maximum of tickets one needs to buy in 99% of the cases?
qnbinom(0.99, 3, 0.05) + 3

#FACTORS & LEVELS___________________________________________________________####

#factor()
#factors are used to store categorical variables
blood_types <-  c("B", "AB", "O", "A", "O", "O", "A", "B")
blood_types_factor <-  factor(blood_types) #scans through vector and identifies different categories
blood_types_factor #R sorts the character values alphabetically
str(blood_types_factor)#R encodes factors as integers, to save memory in case of long strings
blood_types_factor <-  factor(blood_types, #levels argument can be defined
                              levels = c("O", "A", "B", "AB")) #r encoding is now different
#nominal vs. ordinal factors
#nominal = no inherent/meaningful order
blood_types_factor[1] < blood_types_factor[2] #throws an ERROR because factor is nominal
#ordinal = meaningful/natural order
tshirt <- c("M", "L", "S", "S", "L", "M", "L", "M")
tshirt_factor <- factor(tshirt, ordered = T,
                        levels = c("S", "M", "L"),
                        labels = c("size_S", "size_M", "size_L")) #names the factor levels, order important!
tshirt_factor #< signs now that this is an ordered factor
tshirt_factor[1] < tshirt_factor[2] #evaluates TRUE because factor is ordinal

#MISCELLANEOUS______________________________________________________________####

#check the time for used for code
n <- 50000
system.time({
  w <- NULL
  for (i in 1:n) {
    w <- rbind(w, sample(1:6, 2, TRUE))
  }
})