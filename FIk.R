library(sp)
library(raster)
library(rgdal)
path <- "E:/temp/NewIdea/FIKData/data/ori/raster"
output <- "E:/temp/NewIdea/FIKData/data/ori/Erosivity"
for (i in 2001:2018){
        
    for (j in 1:12){
        path1 <- file.path(path, toString(i))
        path2 <- file.path(path1, toString(j))
        list<-(list.files(path = path2, 
                          pattern = glob2rx('*.tif'),full.names = T))
        #indicator E: monthly accumulated storm kinetic energy
        E <- 0
        R <- 0
        #loop all rainfall rasters in a specific month
        for(ras in list){
            #x <- brick(ras)[[1]]
            #y <- brick(ras)[[1]]
            for(z in 1:24){
                #ek: unit rainfall energy
                #print(ras)
                #load file
                ori = brick(ras)*3600
                ek = brick(ras)*3600
                #identify pixels on either side of 76
                idx_lte76 = which(ek[]>=76)
                idx_gt76 = which(ek[]<76)
                idx_gt0 = which(log(ek[])<= -1.362)
                #if pixel value <= 76, replace with .283
                #if(length(idx_gt0)>0){
                #    ek[idx_gt0] = 0.119 + 0.0873 * log(n[z])
                #}
                if(length(idx_lte76)>0){
                    ek[idx_lte76] = 0.283
                }
                #otherwise, replace with the equation
                if(length(idx_gt76)>0){
                    ek[idx_gt76] = 0.119 + 0.0873 * log(ek[idx_gt76])
                }
                if(length(idx_gt0)>0){
                    ek[idx_gt0] = 0
                }
                #add all 24 bands together to create daily unit kinetic energy map
                x <- ek[[z]]
                #add all 24 bands together to create daily rainfall accumulation map
                y <- ori[[z]]
                fun <- function(b1, b2){
                    multi <- b2*b1
                    return(multi)}
                #E: monthly total storm kinetic energy: ek*ras
                E <- E + fun(x, y)
                #R: monthly erosivity: erosive rainfall events greater than MRI+++++++
                #maximum rainfall intensity: MRI=12.7 (I30),
                MRI = 12.7
                R = E*MRI
                print(R)
                print(basename(ras))
                print("hour")
                print(toString(z))
            }
            #x <- x - brick(ras)[[1]]
            #y <- y - brick(ras)[[1]]
            
        }
        #Output
        outfiles <- file.path(output,
                              paste0('R', basename(ras)))
        writeRaster(R, filename = outfiles, overwrite = T)
    } 
}
