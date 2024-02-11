library(igraph)
library(Matrix)
library(MASS)



df1 <- read.table("E:\\temp\\NewIdea\\FIKData\\data\\Result\\Result_Tables\\Result_selection_compare_column\\SA.csv", sep=",", header=T)
df2 <- read.table("E:\\temp\\NewIdea\\FIKData\\data\\Result\\Result_Tables\\Result_selection_compare_column\\SB.csv", sep=",", header=T)
df3 <- read.table("E:\\temp\\NewIdea\\FIKData\\data\\Result\\Result_Tables\\Result_selection_compare_column\\SC.csv", sep=",", header=T)
df4 <- read.table("E:\\temp\\NewIdea\\FIKData\\data\\Result\\Result_Tables\\Result_selection_compare_column\\SD.csv", sep=",", header=T)

df_1 <- df1[sample(nrow(df1), 30000), ]
df_2 <- df2[sample(nrow(df2), 30000), ]
df_3 <- df3[sample(nrow(df3), 30000), ]
df_4 <- df4[sample(nrow(df4), 30000), ]
df <- unique(rbind(df_1, df_2, df_3, df_4))


write.table(df_1, file="E:\\temp\\NewIdea\\FIKData\\data\\Result\\Result_Tables\\Result_selection_compare_column_subset\\SA_subset.csv", sep=",", row.names = FALSE)
write.table(df_2, file="E:\\temp\\NewIdea\\FIKData\\data\\Result\\Result_Tables\\Result_selection_compare_column_subset\\SB_subset.csv", sep=",", row.names = FALSE)
write.table(df_3, file="E:\\temp\\NewIdea\\FIKData\\data\\Result\\Result_Tables\\Result_selection_compare_column_subset\\SC_subset.csv", sep=",", row.names = FALSE)
write.table(df_4, file="E:\\temp\\NewIdea\\FIKData\\data\\Result\\Result_Tables\\Result_selection_compare_column_subset\\SD_subset.csv", sep=",", row.names = FALSE)
