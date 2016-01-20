x <- c(1,5) + c(1,10,100,1000,10000)
list(
  numeros = c(1:5),
  sexo = c("homem", "mulher"),
  logico = c(T, F, T),
  tabela_fipe = data.frame(preco = c(10000, 20000, 300000), carro = c("Fusca", "Gol 1.0", "Ferrari"))
)



diag(2)+diag(4)

typeof(dbl_var) # [1] "double"
typeof(int_var) # [1] "integer"
typeof(log_var) # [1] "logical"
typeof(chr_var) # [1] "character"

c("a", 1) # um 'character' e um 'integer' se transformam em dois 'characater'

c(T, 1) # um 'logical' e um 'integer' se transformam em dois 'integer'

sum(c(T, F, T, F, T))

f <- factor(c("aventura", "aventura", "aventura", "terror", "comédia", "drama"))
f

levels(f)

f <- factor(c("2", "3", "1", "10"))
as.numeric(f) # não funciona


as.numeric(as.character(f)) # funciona





f <- factor(c("02", "03", "01", "10"))
as.numeric(f) # não funciona



arr <- array(1:12, c(3,2,2))

/
dim(arr)    # [1] 3 2 2
length(arr) # [1] 12
nrow(arr)   # [1] 3
ncol(arr)   # [1] 2

dim(mat)    # [1] 2 3
length(mat) # [1] 6
nrow(mat)   # [1] 2
ncol(mat)   # [1] 3



list(
  numeros = c(1:5),
  sexo = c("homem", "mulher"),
  logico = c(T, F, T),
  tabela_fipe = data.frame(preco = c(10000, 20000, 300000), carro = c("Fusca", "Gol 1.0", "Ferrari"))
)


## $numeros
## [1] 1 2 3 4 5
## 
## $sexo
## [1] "homem"  "mulher"
## 
## $logico
## [1]  TRUE FALSE  TRUE
## 
## $tabela_fipe
##   preco   carro
## 1 1e+04   Fusca
## 2 2e+04 Gol 1.0
## 3 3e+05 Ferrari




df <- data.frame(x = 1:4, 
                 cor = c("amarelo", "vermelho", "azul", "verde"), 
                 z = T, 
                 stringsAsFactors = F)
df


names(df) <- c("a", "b", "c")
names(df)


df1 <- data.frame(x = 1:3, y = c("s", "s", "s"), z = T)
df2 <- data.frame(x = 1:2, y = c("n", "n"), z = F)
df3 <- data.frame(a = 3:1, b = c("?", "?", "?"))

rbind(df1, df2)


x <- c(13, 8, 5, 3, 2, 1, 1) 
x[c(3, 2, 1)] # seleciona os três primeiros elementos do vetor na ordem especificada.
x[-c(3, 2, 1)] 

m <- matrix(c(1:5, 11:15), nrow=5, ncol=2)
m




m[5,2] # Retorna o elemento da linha 5 e coluna 2.



m[,1] 

m[,2] 


m[c(1,5),] # Retorna somente as posições 1 e 5 da primeira coluna

mtcars

mtcars[,2]
mtcars[[2]]

mtcars$cyl

mtcars[c(2,3)]

mtcars$cyl

summary(mtcars)

mean(mtcars$mpg)
quantile(mtcars$mpg,0:10/10)

aggreate


data(diamonds, package='ggplot2')
str(diamonds)

table(diamonds$cut)


library(magrittr)

esfrie(asse(coloque(bata(acrescente(recipiente(rep("farinha", 2), "água", "fermento", "leite", "óleo"), "farinha", até = "macio"), duração = "3min"), lugar = "forma", tipo = "grande", untada = T), duração = "50min"), "geladeira", "20min")

recipiente(rep("farinha", 2), "água", "fermento", "leite", "óleo") %>%
  acrescente("farinha", até = "macio") %>%
  bata(duração = "3min") %>%
  coloque(lugar = "forma", tipo = "grande", untada = T) %>%
  asse(duração = "50min") %>%
  esfrie("geladeira", "20min")






T %>% mean(c(NA, rnorm(100)), na.rm = .)



> TRUE %>% 
  +   mean(c(1:101, NA), na.rm = .)

1:101 %>% c(NA) %>% mean(na.rm=TRUE)
1:101 %>% c(NA) %>% mean(na.rm=FALSE)
  
  
T %>% mean(c(NA, rnorm(100)), na.rm = .)  

F %>% mean(c(NA, rnorm(100)), na.rm = .)





# 10 ----------------------------------------------------------------------












