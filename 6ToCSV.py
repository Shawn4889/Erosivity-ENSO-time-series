import arcpy, csv

Ori = r"E:\temp\NewIdea\FIKData\data\Result"
Selection = Ori + r"\Result_selection"
Compare = Ori + r"\Result_selection_compare"
arcpy.env.workspace = Selection
fcs = arcpy.ListFeatureClasses()
a = 0
for fc in fcs:
    CSV = r"E:\temp\NewIdea\FIKData\data\Result\Result_Tables\Result_selection" + "\\" + str(fc[:-4]) + ".csv"
    rows = arcpy.SearchCursor(fc, fields="grid_code")
    with open(CSV, 'w') as f:
        f.write("{}\n".format("grid_code"))
        for row in rows:
            f.write("{}\n".format(row.getValue("grid_code")))
        a = a + 1
        print(a)
