import os
import subprocess
import arcpy
import_path = r'E:\temp\NewIdea\FIKData\data\rainfall'
outLoc = r"E:\temp\NewIdea\FIKData\data\raster"
i = 0
for root, dirs, files, in os.walk(os.path.abspath(import_path)):
    for f in files:
        in_file = os.path.join(root, f)
        write_file = os.path.join(outLoc,f[-11:-3] + ".tif")
        layer = "name"
        i = i + 1
        if i < 500:
            variable = "PRECTOT"
            XDimension = "lon"
            YDimension = "lat"
            BandDimension = "time"
            DimensionValues = ""
            valueSelectionMethod = "BY_VALUE"
            arcpy.MakeNetCDFRasterLayer_md(in_file, variable, XDimension, YDimension,
                                           layer, BandDimension, DimensionValues, valueSelectionMethod)
            arcpy.CopyRaster_management(layer, write_file, "", "", "", "NONE", "NONE", "")
            print(f[-11:-3])
        else:
            i = 0
            call = [r'E:\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe',
                    r'E:\temp\NewIdea\FIK\ENSO_Conversion.py', in_file, write_file]
            subprocess.call(call)
print('Done')