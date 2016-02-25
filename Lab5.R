### R AVANÇADO

cv_tree$size[which.min(cv_tree$dev)]
plot(cv_tree)


##  RMySQL: Database Interface and 'MySQL' Driver for R


install.packages("magrittr")
install.packages("ggplot2")
install.packages("tidyr")
install.packages("dplyr")
install.packages("jpeg")
install.packages("tree")


library(magrittr)
library(ggplot2)
library(tidyr)
library(dplyr)
library(jpeg)
library(tree)


##img <- readJPEG("C:/Users/adm/Documents/curso-r-2016/purple_wave.jpg")

##Preparação do Banco de dados
##Para construir nossos bancos de dados, carregue as duas imagens abaixo (clique para download e salve na pasta do seu projeto):
##  purple_wave.jpg

img <- readJPEG("purple_wave.jpg")


img_dim <- dim(img)



img_df <- data.frame(
  x = rep(1:img_dim[2], each = img_dim[1]),
  y = rep(img_dim[1]:1, img_dim[2]),
  r = as.vector(img[,,1]),
  g = as.vector(img[,,2]),
  b = as.vector(img[,,3])
) %>%
  mutate(cor = rgb(r, g, b),
         id = 1:n()) 


set.seed(1) 

### parte1 b= 0

img_df_parte1 <- img_df %>% 
  sample_frac(3/5) %>% # separando 3/5 do banco
  mutate(b_backup = b, # backup do azul original
         b = 0, # retirando o azul da imagem
         cor = rgb(r, g, b)) # cor da imagem sem o azul


### total de pixel agora:
dim(img_df_parte1)


### filtra os que n?o est?o no img_df_parte1
img_df_parte2 <- img_df %>% filter(!id%in%img_df_parte1$id) 

ggplot(data = img_df_parte1, aes(x = x, y = y)) + 
  geom_point(colour = img_df_parte1$cor) +
  labs(x = "x", y = "y", title = "Imagem sem B (azul)") +
  coord_fixed(ratio = 1) +
  theme_bw()


ggplot(data = img_df_parte2, aes(x = x, y = y)) + 
  geom_point(colour = img_df_parte2$cor) +
  labs(x = "x", y = "y", title = "Imagem sem B (azul)") +
  coord_fixed(ratio = 1) +
  theme_bw()






img <- readJPEG("C:/temp/xadrez_colorido.jpg")

img <- readJPEG("xadrez_colorido.jpg")


img_dim <- dim(img)




ggplot(data = img)


plot(img)

img_df <- data.frame(
  x = rep(1:img_dim[2], each = img_dim[1]),
  y = rep(img_dim[1]:1, img_dim[2]),
  r = as.vector(img[,,1]),
  g = as.vector(img[,,2]),
  b = as.vector(img[,,3])
) %>%
  mutate(cor = rgb(r, g, b),
         id = 1:n())



## %>%  tbl_d



ggplot(img_df, aes(x = x, y = y)) +
  geom_point(colour = cor) +
  labs(x = "x", y = "y", title = "Imagem Original") +
  coord_fixed(ratio = 1) +
  theme_bw()



set.seed(1)

### parte1 b= 0

img_df_parte1 <- img_df %>%
  sample_frac(3/5) %>% # separando 3/5 do banco
  mutate(b_backup = b, # backup do azul original
         b = 0, # retirando o azul da imagem
         cor = rgb(r, g, b)) # cor da imagem sem o azul


### total de pixel agora:
dim(img_df_parte1)
##[1] 42336     8
##> 70560 * (3/5)
##[1] 42336

### filtra os que não estão no img_df_parte1
img_df_parte2 <- img_df %>% filter(!id%in%img_df_parte1$id)


img_df_parte2 


ggplot(data = img_df_parte1, aes(x = x, y = y)) +
  geom_point(colour = img_df_parte1$cor) +
  labs(x = "x", y = "y", title = "Imagem sem B (azul)") +
  coord_fixed(ratio = 1) +
  theme_bw()


ggplot(data = img_df_parte2, aes(x = x, y = y)) +
  geom_point(colour = img_df_parte2$cor) +
  labs(x = "x", y = "y", title = "Imagem sem B (azul)") +
  coord_fixed(ratio = 1) +
  theme_bw()



##########################################################


img_df_amostra <- img_df %>%
  sample_n(500,replace = FALSE)

dim(img_df_amostra)

cor(img_df_amostra)

cor(img_df_amostra %>%
      select(-cor, -id)) %>%
  round(2)

pairs (img_df_amostra %>%
         select(-cor, -id))
Apagar Responder Responder a todos Encaminhar Aplicar Anterior Próxima
Escrever




modelo_lm = lm(b~r+g+x+y,data=img_df_parte2)

modelo_tree = tree(b~r+g+x+y,data=img_df_parte2)


### parte1 b= 0
img_df_parte1 <- img_df %>%
  sample_frac(3/5) %>% # separando 3/5 do banco
  mutate(b_backup = b, # backup do azul original
         b = 0, # retirando o azul da imagem
         cor = rgb(r, g, b)) # cor da imagem sem o azul

dim(img_df_parte1)

predito_lm <- predict(modelo_lm,img_df_parte1)

summary(predito_lm)

predito_tree <- predict(modelo_tree,img_df_parte1)

summary(predito_tree)

summary(img_df_parte1)


mdf_predito_x <- img_df_parte1 %>%
  mutate(predito_lm,predito_tree)

summary(mdf_predito_x)

?summary

mean((mdf_predito_x$b_backup-mdf_predito_x$predito_lm)^2)

mean((mdf_predito_x$b_backup-mdf_predito_x$predito_tree)^2)
###summary((b_backup-predito_lm)^2)

mdf_predito_cores <- mdf_predito_x %>%
  mutate(predito_lm = ifelse(predito_lm < 0, 0, predito_lm),
         predito_tree = ifelse(predito_tree < 0, 0, predito_tree)) %>%
  mutate(cor_lm = rgb(r, g, predito_lm),
         cor_tree = rgb(r, g, predito_tree))


ggplot(mdf_predito_cores, aes(x = x, y = y)) +
  geom_point(colour = mdf_predito_cores$cor_lm) +
  labs(x = "x", y = "y", title = "Imagem sem B (azul)") +
  coord_fixed(ratio = 1) +
  theme_bw()


ggplot(mdf_predito_cores, aes(x = x, y = y)) +
  geom_point(colour = mdf_predito_cores$cor_tree) +
  labs(x = "x", y = "y", title = "Imagem sem B (azul)") +
  coord_fixed(ratio = 1) +
  theme_bw()

View(img_df_parte2)

head(img_df_parte2,100)
