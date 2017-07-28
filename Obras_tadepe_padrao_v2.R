#Script padrão para verificação das obras do simec
#sempre baixar a planilha mais atualizada e alterar no read.table (linha 9)

library(dplyr)

setwd("C:/Users/jvoig/OneDrive/Documentos/Tá de pé/Planilhas/SCRIPT padrão")

obras <- read.table(file="obras300520172.csv", sep=";",  
                    header=T, encoding="UTF-8", comment.char = "", quote = "\"", as.is = TRUE,
                    na.strings="")    #verificar qual é a data da planilha de obras


filtro_google_tipodeprojeto <- c("Espaço Educativo - 12 Salas",
                                 "Espaço Educativo - 01 Sala",
                                 "Espaço Educativo - 02 Salas",
                                 "Espaço Educativo - 04 Salas",
                                 "Espaço Educativo - 06 Salas",
                                 "Projeto 1 Convencional",
                                 "Projeto 2 Convencional")  
  
  
filtro_google_situacao <- c("Inacabada",
                            "Planejamento pelo proponente",
                            "Execução",
                            "Paralisada",
                            "Contratação",
                            "Licitação",
                            "Em Reformulação")


                  
obras_google <- obras %>%
  filter(Tipo.do.Projeto %in% filtro_google_tipodeprojeto ) %>%
  filter(Situação %in% filtro_google_situacao ) %>%
  rename(id = X.U.FEFF.ID)


#Para ter uma lista de municípios com obras:
#aqui não precisa alterar nada


obras_google_munic <- obras_google %>%
  mutate(num=1) %>%
  group_by(Município, UF) %>%
  summarise(obras = sum(num))

write.table(obras_google_munic, file="obras_google_munic.csv", 
            sep=";", row.names=F, na="")


## PAra conseguir as escolas em um munic?pio X (substituir o X pelo nome do munic?pio e o Y pelo estado)

obras_google_X <- obras_google %>%                                      #substituir
  filter(Munic?pio %in% c("X")) %>%                                     #substituir
  select(id, Nome, Munic?pio, CEP, Logradouro, Bairro)

write.table(obras_google_al, file="obras_google_al.csv", 
            sep=";", row.names=F, na="", quote = F)

