######################################################################################

##aula 3


?library

install.packages("nycflights13")

library(nycflights13)

library(dplyr)
flights %>% tbl_df

utils::View(flights)

utils::View(df[500:1000,]) 



## filter
## Atribua a uma tabela apenas os voos de janeiro de 2013.
tabela <- flights %>% select(1:16) %>% filter(year==2013)

tabela

## Atribua a uma tabela apenas os voos de janeiro ou fevereiro de 2013.

tabela2 <- flights %>% select(1:16) %>% filter(year==2013, (month==1|month==2))

View(tabela2)


## Atribua a uma tabela apenas os vôos com distância maior do que 1000 milhas.

?flights

tabela3 <- flights %>% select(year,month,day,dest,distance) %>% filter(distance > 1000)


## select
## Atribua a uma tabela apenas as colunas month e dep_delay.
tabela4 <- flights %>% select(month,dep_delay)
tabela4
## Atribua a uma tabela apenas as colunas month e dep_delay, os nomes dessas colunas devem ser mes e atraso.
names(tabela4)
names(tabela4)[1] <- "mes"
names(tabela4)[2] <- "atraso"

tabela4

## Retire da tabela as colunas tailnum, origin e dest

tabela5 <- flights %>% select(1:16) 

tabela5$tailnum <- NULL 
tabela5$origin <- NULL 
tabela5$dest <- NULL 

tabela5

## mutate
## Calcule as colunas ganho_de_tempo que é dado por dep_delay - arr_delay e velocidade dada por distance / air_time * 60.

tabela6 <- flights %>% select(year,month,dep_delay,arr_delay,distance,air_time) %>%
  mutate(ganho_de_tempo = (dep_delay - arr_delay),velocidade = (distance / air_time * 60))

tabela6

## Calcule o horário de chegada considerando as colunas hour, minute e air_time. A tabela deve conter duas 
## colunas novas: hour2 com a hora de chegada e minute2 com o minuto de chegada.

tabela7 <- flights %>% select(year,month,flight, air_time,hour,minute) %>%
  mutate(hour2 = ifelse(trunc((air_time+(hour*60)+minute)/60)>23,(trunc((air_time+(hour*60)+minute)/60)-24),(trunc((air_time+(hour*60)+minute)/60))),minute2 = (((air_time+(hour*60)+minute)/60)-trunc((air_time+(hour*60)+minute)/60))*60) %>% 
  print(n=1000)

tabela7

?flights

## [ reached getOption("max.print") -- omitted 335526 rows ]

getOption("max.print")

?getOption

## summarise
## Calcule a média da distância de todos os vôos.

tabela5

View(tabela5)

flights %>%
  group_by(year) %>%
  summarise(n=n(), 
            media_distancia=mean(distance)) %>%
  arrange(desc(year))

## Calcule a média da distância dos vôos por mês
flights %>%
  group_by(year,month) %>%
  summarise(n=n(), 
            media_distancia=mean(distance)) %>%
  arrange(desc(year),desc(month))


## Calcule a média, mediana, primeiro quartil e terceiro quartil do tempo de viagem por mês.

## mean(x) - mean value of vector x.
## median(x) - median value of vector x.
## quantile(x, p) - pth quantile of vector x.

summary(flights$arr_time)[4]
summary(flights$arr_time)[3]
summary(flights$arr_time)[2]
summary(flights$arr_time)[5]

flights %>%
  group_by(year,month,day) %>%
  summarise(n=n(), 
            media_tv=mean(arr_time,na.rm = TRUE),
            mediana_tv = median(arr_time,na.rm = TRUE),
            primeiro_Qu__tv=quantile(arr_time,prob = c(0.25),na.rm = TRUE),
            terceiro_Qu_tv=quantile(arr_time,prob = c(0.75),na.rm = TRUE)
  ) %>%
  arrange(desc(year),(month))


##prob = c(0.15, 0.25, 0.35)
##quantile(datad, prob = c(0.15, 0.25, 0.35))

## arrange
## Ordene a base de dados pelo atraso na partida em ordem crescente.
flights %>%
  arrange(dep_delay)


## Repita a questão anterior, porém na ordem decrescente.

flights %>%
  arrange(desc(dep_delay))

install.packages("tidyr")
library(tidyr)


## spread
## Crie uma tabela em que cada linha é um dia e cada coluna é o atraso médio de partida por mês.

## flights %>%
## group_by(day, ifelse(is.numeric(dep_delay),dep_delay,0)) %>%
##   summarise(atraso_medio = mean(ifelse(is.numeric(dep_delay),dep_delay,0))) %>%
##   ungroup() %>%
##   spread(day, atraso_medio)

## flights %>%
##   group_by(day, ifelse(is.numeric(dep_delay),dep_delay,0)) %>%
##   summarise(atraso_medio = mean(ifelse(is.numeric(dep_delay),dep_delay,0))) %>%
##   spread(day, atraso_medio)

## flights %>%
##   group_by(month,day, ifelse(is.numeric(dep_delay),dep_delay,0)) %>%
##   summarise(atraso_medio = mean(ifelse(is.numeric(dep_delay),dep_delay,0))) %>% 
##   spread(month, atraso_medio)



## flights %>%
##   group_by(month,day) %>%
## summarise(atraso_medio = mean(ifelse(is.numeric(dep_delay),dep_delay,0))) %>% 
## spread(month, atraso_medio) %>% print(n=100)


flights %>%
  group_by(month,day) %>%
  summarise(atraso_medio = mean(dep_delay,na.rm = TRUE)) %>% 
  spread(month, atraso_medio) %>% print(n=100)


## Dica: você precisará usar group_by, summarisee spread. Lembre-se também do argumento na.rm.
## Repita a mesma operação, mas dessa vez cada coluna será uma hora do dia.

flights %>%
  group_by(month,day,hour) %>%
  summarise(hour) %>% 
  spread(day,hour) 


flights %>%
  filter(month==1) %>%  
  group_by(flight,month,hour,day) %>%
  summarise(populacao = mean(dep_delay,na.rm = TRUE)
  ) %>%
  ungroup() %>% 
  spread(month,populacao, fill = 0) %>% print(n=100)



flights %>%
  ##  filter(month==1) %>%  
  group_by(hour,day) %>%
  summarise(atraso_medio = mean(dep_delay,na.rm = TRUE)
  ) %>%
  ungroup() %>% 
  spread(day,atraso_medio, fill = 0) %>% print(n=100)



## gather
## Considerando as tabelas criadas nas perguntas sobre o spread:
## Transforme-as em um formato tidy.

tabela10 <-  flights %>%
  group_by(month,day) %>%
  summarise(atraso_medio = mean(dep_delay,na.rm = TRUE)) %>% 
  spread(month, atraso_medio) %>% print(n=100)

gather(tabela10,month,atraso_medio,-day) %>% print(n=100)








##library(dplyr)
# From http://stackoverflow.com/questions/1181060
###stocks <- data_frame(
##  time = as.Date('2009-01-01') + 0:9,
##  X = rnorm(10, 0, 1),
##  Y = rnorm(10, 0, 2),
##  Z = rnorm(10, 0, 4)
##)

## gather(stocks, stock, price, -time)
## stocks %>% gather(stock, price, -time)

