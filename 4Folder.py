import os, shutil
import arcpy
from arcpy import env
env.workspace = r"E:\temp\NewIdea\FIKData\data\raster"

for i in range(1980,2019):
    for j in range(1, 13):
        if not os.path.exists(env.workspace + "\\" + str(i)):
            os.mkdir(env.workspace + "\\" + str(i))
            print(i)
        if not os.path.exists(env.workspace + "\\" + str(i) + "\\" + str(j)):
            os.mkdir(env.workspace + "\\" + str(i)+ "\\" + str(j))
            print(j)

print(int("01"))

#daily
#rasters = arcpy.ListRasters()
#for m in range(1980,2019):
#    print(m)
#    folderName = str(m)
#    for inRaster in rasters:
#        if folderName in inRaster:
#            shutil.copy(env.workspace + "\\" + inRaster, env.workspace + "\\" + folderName)
#monthly

for i in range(1980,2019):
    print(i)
    env.workspace = r"E:\temp\NewIdea\FIKData\data\raster" + "\\" + str(i)
    rasters = arcpy.ListRasters()
    for m in range(1,13):
        print(m)
        monthName = str(m)
        for inRaster in rasters:
            if int(inRaster[4:6]) == int(m):
                shutil.copy(env.workspace + "\\" + inRaster, env.workspace + "\\" + monthName)


