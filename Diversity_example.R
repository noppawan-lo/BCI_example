#-------------------------------------------------------------------------------
##Calculate richness and diversity and report
#-------------------------------------------------------------------------------

#Folder
Folder = "D:/MC_Project/Example/"  

#Data_Name 
Data_Name = "Liana_Plot.xlsx"

#-------------------------------------------------------------------------------

## Read file

setwd(paste0(Folder))

library(openxlsx)
Data <- read.xlsx(Data_Name)

#-------------------------------------------------------------------------------

## Vegan package calculate 
library(vegan)

#Shannon diversity
H <- diversity(Data)

#Simpson diversity
simp <- diversity(Data, "simpson")

#Inverse Simpson diversity
invsimp <- diversity(Data, "inv")

#Density (number of stems)
D <- rowSums(Data)

#Species richness (number of species)
S <- specnumber(Data) 

#Pielou's evenness (J)
J <- H/log(S)

#-------------------------------------------------------------------------------

#create table of all index 
Index <- data.frame(H, simp, invsimp, D, S, J)
names(Index)<- c("Shannon","Simpson","Insimpson","Density",
                 "Richness","Pielou_Evenness")

#-------------------------------------------------------------------------------

##Calculate richness index
#Margeleff index = S-1 / In(N)
Index$Margeleff = ((Index$Richness)-1)/(log(Index$Density))

#Menhnick index = S / square root (N)
Index$Menhnick = (Index$Richness)/(sqrt(Index$Density))

#-------------------------------------------------------------------------------

##Save file 
write.xlsx(Index,paste0("Output_",Data_Name))

#-------------------------------------------------------------------------------
