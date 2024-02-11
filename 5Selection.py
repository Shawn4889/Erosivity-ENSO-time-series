import arcpy
#Setup
Ori = r"E:\temp\NewIdea\FIKData\data"
Rainfall = Ori + r"\Rainfall"
Erosivity = Ori + r"\Erosivity"
Climate = Ori + r"\Climate"
ClimateA = Climate + r"\A" + r"\A.shp"
ClimateB = Climate + r"\B" + r"\B.shp"
ClimateC = Climate + r"\C" + r"\C.shp"
ClimateD = Climate + r"\D" + r"\D.shp"
Clip = Ori + r"\Result_clip"
Point = Ori + r"\Result_points"
Selection = Ori + r"\Result\Result_selection"
SelectionA = Selection + r"\Buffer\PA.shp"
SelectionB = Selection + r"\Buffer\PB.shp"
SelectionC = Selection + r"\Buffer\PC.shp"
SelectionD = Selection + r"\Buffer\PD.shp"
Compare = Ori + r"\Result\Result_selection_compare"
CompareA = Compare + r"\Buffer\PA_R.shp"
CompareB = Compare + r"\Buffer\PB_R.shp"
CompareC = Compare + r"\Buffer\PC_R.shp"
CompareD = Compare + r"\Buffer\PD_R.shp"
a = 0
b = 0
c = 0
d = 0
e = 0

#Clip rainfall data $erosivity data
try:
    arcpy.env.workspace = Rainfall
    rss = arcpy.ListRasters("*", "tif")
    for rs in rss:
        arcpy.Clip_management(rs, "", Clip + r"\CAR" + str(rs[4:-4]) + ".tif", ClimateA, "#", "ClippingGeometry")
        arcpy.Clip_management(rs, "", Clip + r"\CBR" + str(rs[4:-4]) + ".tif", ClimateB, "#", "ClippingGeometry")
        arcpy.Clip_management(rs, "", Clip + r"\CCR" + str(rs[4:-4]) + ".tif", ClimateC, "#", "ClippingGeometry")
        arcpy.Clip_management(rs, "", Clip + r"\CDR" + str(rs[4:-4]) + ".tif", ClimateD, "#", "ClippingGeometry")
        a = a + 1
        print("a" + str(a))

    arcpy.env.workspace = Erosivity
    rss = arcpy.ListRasters("*", "tif")
    for rs in rss:
        arcpy.Clip_management(rs, "", Clip + r"\CAE" + str(rs[1:-4]) + ".tif", ClimateA, "#", "ClippingGeometry")
        arcpy.Clip_management(rs, "", Clip + r"\CBE" + str(rs[1:-4]) + ".tif", ClimateB, "#", "ClippingGeometry")
        arcpy.Clip_management(rs, "", Clip + r"\CCE" + str(rs[1:-4]) + ".tif", ClimateC, "#", "ClippingGeometry")
        arcpy.Clip_management(rs, "", Clip + r"\CDE" + str(rs[1:-4]) + ".tif", ClimateD, "#", "ClippingGeometry")
        b = b + 1
        print("b" + str(b))
except:
    print("Already exist")


# Raster to point
arcpy.env.workspace = Clip
rss = arcpy.ListRasters()
for rs in rss:
    arcpy.RasterToPoint_conversion(rs, Point + r"\P" + str(rs[1:-4]) + ".shp")
    c = c + 1
    print("c" + str(c))

#Random selection
arcpy.env.workspace = Point
fcs = arcpy.ListFeatureClasses()
for fc in fcs:
    if fc.startswith("PAE"):
        arcpy.Clip_analysis(fc, SelectionA, Selection + r"\SAE" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PAR"):
        arcpy.Clip_analysis(fc, SelectionA, Selection + r"\SAR" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PBE"):
        arcpy.Clip_analysis(fc, SelectionB, Selection + r"\SBE" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PBR"):
        arcpy.Clip_analysis(fc, SelectionB, Selection + r"\SBR" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PCE"):
        arcpy.Clip_analysis(fc, SelectionC, Selection + r"\SCE" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PCR"):
        arcpy.Clip_analysis(fc, SelectionC, Selection + r"\SCR" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PDE"):
        arcpy.Clip_analysis(fc, SelectionD, Selection + r"\SDE" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PDR"):
        arcpy.Clip_analysis(fc, SelectionD, Selection + r"\SDR" + str(fc[3:-4]) + ".shp")
    d = d + 1
    print("d" + str(d))

arcpy.env.workspace = Point
fcs = arcpy.ListFeatureClasses()
for fc in fcs:
    if fc.startswith("PAE"):
        arcpy.Clip_analysis(fc, CompareA, Compare + r"\SAE" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PAR"):
        arcpy.Clip_analysis(fc, CompareA, Compare + r"\SAR" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PBE"):
        arcpy.Clip_analysis(fc, CompareB, Compare + r"\SBE" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PBR"):
        arcpy.Clip_analysis(fc, CompareB, Compare + r"\SBR" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PCE"):
        arcpy.Clip_analysis(fc, CompareC, Compare + r"\SCE" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PCR"):
        arcpy.Clip_analysis(fc, CompareC, Compare + r"\SCR" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PDE"):
        arcpy.Clip_analysis(fc, CompareD, Compare + r"\SDE" + str(fc[3:-4]) + ".shp")
    elif fc.startswith("PDR"):
        arcpy.Clip_analysis(fc, CompareD, Compare + r"\SDR" + str(fc[3:-4]) + ".shp")
    e = e + 1
    print("e" + str(e))
