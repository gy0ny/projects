# N queens problem by genetic algorithm

#Version 1. Simulation code
#Calculate the number of attacking queens
attacking <- function(subject){
  error <- 0
  for (i in 1: length(subject)){
    x <- i
    y <- subject[i]
    for(j in 1:length(subject)){
      if (i !=j){
        dx <- j
        dy <- subject[j]
        if (abs(dx-x)==abs(dy-y)){error = error+1}
      }
      
    }
  }
  return(error)
}

#Selection operator
selection <- function(population){
  candidate <- sample(population,3,replace = FALSE)
  fit <- list(candidate = NA, fitness = NA)
  for(i in 1:length(candidate)){
    fit$candidate[i] = list(candidate[[i]])
    fit$fitness[i] = 1/(attacking(candidate[[i]])+1)
  }
  
  # select two chromosomes among three chromosomes
  top2 <- which(fit$fitness %in% sort(fit$fitness,decreasing=TRUE)[1:2])
  parents = c(candidate[top2[1]], candidate[top2[2]])
  return(c(parents, fit))
}

#Compare two parents chromosomes 
noncommon <- function(par1,par2){
  noncommon <- which(!par1-par2 == 0)
}

#Crossover operator : 3- way crossover 
cross.operator<- function(par1,par2,nproblem){
  son <-c()
  offseed <- sample(par1[noncommon(par1,par2)])   # different indices of two parents
  for (i in 1:nproblem){
    if (i %in% noncommon(par1,par2)) {
      son[i] <- offseed[1]
      offseed <- offseed[-1]
    }
    else {son[i] <- par1[i]}
  }
  return (son)
}

#Mutation operator
mutation.operator <- function(son,nproblem){
  n.mut <- sample(1:nproblem,2)
  son.mut <- son
  son.mut[n.mut[1]] <- son[n.mut[2]]
  son.mut[n.mut[2]] <- son[n.mut[1]]
  return(son.mut)
}

#N-Queens function
n_queens <- function(nproblem,n_sol){
  # Initial Population ------------
  ipop <- n_sol
  son <-c()
  sol <- c()
  population1 <- c()
  for(i in 1:ipop){
    population1[[i]] <- sample(seq(1:nproblem), replace = FALSE)
  }
  solution <- data.frame(solution = rep(0,n_sol) , iter = rep(0,n_sol), total_iter = rep(0,n_sol))
  i <- 0
  total_iter <- 0
  repeat{
    population <- population1
    iter <- 0
    # Creating further population ---------------------------------------------------
    repeat{
      result<- selection(population)   # Simulate selection and save the result
      par1 <- result[[1]]
      par2 <- result[[2]]
      if (max(result$fitness) == 1) break
      # If parents chromosomes are same, one of them should change the position of each genome 
      com1 <- as.numeric(paste(par1,collapse=""))
      com2 <- as.numeric(paste(par2,collapse=""))
      if(com1 == com2){par1 <- sample(seq(1:nproblem), replace = FALSE)}
      
      crossed <- cross.operator(par1,par2,nproblem)
      son <- mutation.operator(crossed,nproblem) 
      population <- c()
      population <- list(par1,par2,son)
      
      iter <- iter+1
      result
    }
    sol_idx <- which(result$fitness == 1)
    sol = result$candidate[[sol_idx]]
    sol <- as.numeric(paste(sol,collapse=""))
    total_iter <- total_iter + iter
    if(sol %in% solution$solution){}else{ i <- i+1 ;solution$solution[i] <- sol;solution$iter[i] <- iter; solution$total_iter[i] <- total_iter} 
    if (i == n_sol) break
    
  }
  return(solution)
}

#Example 1 : 5x5 Queens
sol5 <- n_queens(5,10)
q5 <- system.time(n_queens(5,10))

#Example 2 : 6x6 Queens
sol6 <- n_queens(6,4)
q6 <- system.time(n_queens(6,4))

#Example 3 : 7x7 Queens
sol7 <- n_queens(7,40)
q7 <- system.time(n_queens(7,40))

#Example 4 : 8x8 Queens
sol8 <- n_queens(8,92)
q8 <- system.time(n_queens(8,92))

#Example 5 : 9x9 Queens
sol9 <- n_queens(9,352)






#Version 2. Using GA Package
#Library
library(GA)

#Calculate the number of attacking queens
attacking <- function(subject){
  error <- 0
  for (i in 1: length(subject)){
    x <- i
    y <- subject[i]
    for(j in 1:length(subject)){
      if (i !=j){
        dx <- j
        dy <- subject[j]
        if (abs(dx-x)==abs(dy-y)){error = error+1}
      }
    }
  }
  return(error)
}

Fitness function
fitness <- function(subject){
  fit = 1/(attacking(subject)+1)
  return(fit)
}

#Generate random initial solution
gaperm_Population(GA)

#OX Crossover operator
system.time(GA0 <- ga(type = "permutation", fitness = fitness,  maxiter = 72, seed = 2021, lower = 1, upper = 8 , popSize = 2000, keepBest = TRUE, pmutation = 1))
summary(GA0)
View(GA0@bestSol)

#PMX Crossover operator
system.time(GA <- ga(type = "permutation", fitness = fitness, crossover = "gaperm_pmxCrossover", maxiter = 69, seed = 2021, lower = 1, upper = 8 , popSize = 2000, keepBest = TRUE, pmutation = 1))
summary(GA)
View(GA@bestSol)

#Example - 9 x 9 Queens
q9 <- system.time(n_queens(9,352))
