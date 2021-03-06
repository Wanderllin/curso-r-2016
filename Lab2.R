

######################################################################################
## laboratório 2

arq <- 'C:\\Users\\Unifesp\\Documents\\curso-r-2016\\arq.txt'

arq <- 'arq.txt'
dados <- read.table(file = arq, header=TRUE, fill = TRUE)
dados <- read.table(file = arq, sep = ";") 
str(dados)


dados <- read.table(file = arq, sep = ";", dec = ",") 
str(dados) 

dados <- read.table(file = arq, sep = ";", dec = ",", header = T)

str(dados)


dados <- read.table(file = arq, sep = ";", dec = ",", header = T, stringsAsFactors = F)
str(dados)

summary(dados)


install.packages("readr")
library(readr)


install.packages("dplyr")
library(dplyr)

install.packages("httr")
library(httr)

link_pnud <- 'https://www.dropbox.com/s/seqctcl46qeemgu/pnud_simplificado.rds?dl=1'
tmp <- tempfile()
httr::GET(link_pnud, httr::write_disk(tmp))
pnud <- readRDS(tmp)
file.remove(tmp)

summary(pnud)


pnud %>%
  select(1:10)


## Quais são os seis municípios com os maiores IDH municipais em 2010.

pnud2 <- pnud[order(pnud$idhm,decreasing=TRUE),]

pnud2 %>%
  ##pnud2[order(pnud2$idhm,decreasing=TRUE),]  %>%
  filter(ano==2010)  %>%
  select(municipio,idhm)

## Qual é a unidade federativa com menor expectativa de vida média, 

pnud3 <- pnud[order(pnud$espvida,  decreasing=FALSE),]
pnud3 %>%
  ##  filter(ano==2010)  %>%
  group_by(ano, ufn, espvida) %>%
  select(ano,ufn,espvida)



pnud_muni %>%
  group_by(ano, ufn) %>%
  summarise(populacao = sum(popt)) %>%
  ungroup() %>%
  spread(ano, populacao)


## ponderada pela população dos municípios em 2000.


pnud %>%
  filter(ano==2000) %>%  
  group_by(ufn) %>%
  summarise(n=n(), 
            idhm_medio=mean(idhm),
            espvida_medio=mean(espvida),
            pesotot_medio=mean(pesotot),
            gini_medio=mean(gini),
            rdpc_medio=mean(rdpc),
            mort1_medio=mean(mort1),
            razdep_medio=mean(razdep),
            t_analf15m_medio=mean(t_analf15m)) %>%
  arrange(desc(idhm_medio))


## Quais são os municípios outliers com relação ao índice de Gini em 1991 
## e em 2010 (Dica: utilize como critério para determinar outliers valores 
## maiores que a média mais duas vezes o desvio padrão).

summary(pnud$gini)

sqrt(pnud$gini)*2

pnud %>%
  select(ano, ufn, municipio, gini) %>%
  filter(ufn=='São Paulo', ano==1991, (gini < summary(pnud$gini)[2] | gini > summary(pnud$gini)[5]))

pnud %>%
  select(ano, ufn, municipio, gini) %>%
  filter(ano==1991, (gini < summary(pnud$gini)[2] | gini > summary(pnud$gini)[5]))

pnud %>%
  select(ano, ufn, municipio, gini) %>%
  filter(ano==2010, (gini < summary(pnud$gini)[2] | gini > summary(pnud$gini)[5]))


pnud %>%
  select(ano, ufn, municipio, gini) %>%
  filter(ano==1991, (gini > (summary(pnud$gini)[4]+(2*sd(pnud$gini)))))


pesquisa <- pnud %>%
  select(ano, ufn, municipio, gini) %>%
  filter(ano==2010, (gini > (summary(pnud$gini)[4]+(2*sd(pnud$gini)))))

head(pesquisa,61)

tail(pesquisa,5)
pesquisa[1:100,]

?head
View(pesquisa)?
?save
history(max.show)

summary(pnud$gini)[4]


install.packages("ggplot2")
library(ggplot2)


ggplot(pesquisa, aes(x = municipio, y = gini)) + 
  geom_point()

ggplot(pesquisa, aes(x = municipio, y = gini)) + geom_point()
------------------------------------------------------
  
  
  
  ## Outras atividades:
  
  ## Categorize a renda per capita e associe com a expectativa de vida.
  ## No nordeste o aumento de distribuição de renda foi maior do que no sudeste?
  ## Insira mais pelo menos 3 estudos que você ache interessante.
  
  
