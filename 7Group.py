import os
import pandas as pd

folder = r"E:\temp\NewIdea\FIKData\data\Result\Result_Tables\Result_selection_compare"
out = r"E:\temp\NewIdea\FIKData\data\Result\Result_Tables\Result_selection_compare_Combine"

for i in range(1,13):
    SAE = pd.DataFrame()
    SBE = pd.DataFrame()
    SCE = pd.DataFrame()
    SDE = pd.DataFrame()
    SAR = pd.DataFrame()
    SBR = pd.DataFrame()
    SCR = pd.DataFrame()
    SDR = pd.DataFrame()
    for f in os.listdir(folder):
        data = pd.read_csv(folder + "\\" + f, header=None, skiprows=[0])
        if int(f[7:9]) == i:
            if f[0:3] == "SAE":
                SAE = SAE.append(data)
            elif f[0:3] == "SBE":
                SBE = SBE.append(data)
            elif f[0:3] == "SCE":
                SCE = SCE.append(data)
            elif f[0:3] == "SDE":
                SDE = SDE.append(data)
            elif f[0:3] == "SAR":
                SAR = SAR.append(data)
            elif f[0:3] == "SBR":
                SBR = SBR.append(data)
            elif f[0:3] == "SCR":
                SCR = SCR.append(data)
            elif f[0:3] == "SDR":
                SDR = SDR.append(data)
    SAE.to_csv(out + "\\" + "SAE" + str(i) + ".csv", index=None, header=None)
    SBE.to_csv(out + "\\" + "SBE" + str(i) + ".csv", index=None, header=None)
    SCE.to_csv(out + "\\" + "SCE" + str(i) + ".csv", index=None, header=None)
    SDE.to_csv(out + "\\" + "SDE" + str(i) + ".csv", index=None, header=None)
    SAR.to_csv(out + "\\" + "SAR" + str(i) + ".csv", index=None, header=None)
    SBR.to_csv(out + "\\" + "SBR" + str(i) + ".csv", index=None, header=None)
    SCR.to_csv(out + "\\" + "SCR" + str(i) + ".csv", index=None, header=None)
    SDR.to_csv(out + "\\" + "SDR" + str(i) + ".csv", index=None, header=None)



