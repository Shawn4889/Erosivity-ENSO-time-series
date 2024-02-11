import pandas as pd
import os
import numpy as np
folder = r"E:\temp\NewIdea\FIKData\data\Result\Result_Tables\Result_selection_compare_Combine"
out = r"E:\temp\NewIdea\FIKData\data\Result\Result_Tables\Result_selection_column"
SAE = pd.DataFrame()
SBE = pd.DataFrame()
SCE = pd.DataFrame()
SDE = pd.DataFrame()
SAR = pd.DataFrame()
SBR = pd.DataFrame()
SCR = pd.DataFrame()
SDR = pd.DataFrame()

for f in sorted(os.listdir(folder), key=lambda x: int(x.split('.')[0][3:])):
    data = pd.read_csv(folder + "\\" + f, header=None)
    print(f)
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
SAE.to_csv(out + "\\" + "SAE" + ".csv", index=None, header=None)
SBE.to_csv(out + "\\" + "SBE" + ".csv", index=None, header=None)
SCE.to_csv(out + "\\" + "SCE" + ".csv", index=None, header=None)
SDE.to_csv(out + "\\" + "SDE" + ".csv", index=None, header=None)
SAR.to_csv(out + "\\" + "SAR" + ".csv", index=None, header=None)
SBR.to_csv(out + "\\" + "SBR" + ".csv", index=None, header=None)
SCR.to_csv(out + "\\" + "SCR" + ".csv", index=None, header=None)
SDR.to_csv(out + "\\" + "SDR" + ".csv", index=None, header=None)
