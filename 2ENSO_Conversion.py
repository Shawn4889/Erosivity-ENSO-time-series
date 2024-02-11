import arcpy
import glob
import sys
# Conversion NetCDF to Raster
in_file = sys.argv[1]
write_file = sys.argv[2]
variable = "PRECTOT"
XDimension = "lon"
YDimension = "lat"
BandDimension = "time"
DimensionValues = ""
valueSelectionMethod = "BY_VALUE"
layer = 'name'
arcpy.MakeNetCDFRasterLayer_md(in_file, variable, XDimension, YDimension,
                               layer, BandDimension, DimensionValues, valueSelectionMethod)
arcpy.CopyRaster_management(layer, write_file, "", "", "", "NONE", "NONE", "")
print(write_file)
#cdf[-9:-3]