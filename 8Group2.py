import pandas as pd
import os
import numpy as np
folder = r"E:\temp\NewIdea\FIKData\data\Result\Result_Tables\Result_selection"
out = r"E:\temp\NewIdea\FIKData\data\Result\Result_Tables\Result_selection_Matrix"
SAE = np.zeros((39, 12))
SBE = np.zeros((39, 12))
SCE = np.zeros((39, 12))
SDE = np.zeros((39, 12))
SAR = np.zeros((39, 12))
SBR = np.zeros((39, 12))
SCR = np.zeros((39, 12))
SDR = np.zeros((39, 12))
for f in sorted(os.listdir(folder)):
    data = pd.read_csv(folder + "\\" + f)
    average = data["grid_code"].mean()
    year = int(f[3:7])
    month = int(f[7:9])
    i = year - 1980
    j = month - 1
    if f[0:3] == "SAE":
        SAE[i, j] = average
    if f[0:3] == "SBE":
        SBE[i, j] = average
    if f[0:3] == "SCE":
        SCE[i, j] = average
    if f[0:3] == "SDE":
        SDE[i, j] = average
    if f[0:3] == "SAR":
        SAR[i, j] = average
    if f[0:3] == "SBR":
        SBR[i, j] = average
    if f[0:3] == "SCR":
        SCR[i, j] = average
    if f[0:3] == "SDR":
        SDR[i, j] = average
SAE = pd.DataFrame(SAE)
SAE.to_csv(out + "\\" + "SAE.csv",index = None, header=None)
SBE = pd.DataFrame(SBE)
SBE.to_csv(out + "\\" + "SBE.csv",index = None, header=None)
SCE = pd.DataFrame(SCE)
SCE.to_csv(out + "\\" + "SCE.csv",index = None, header=None)
SDE = pd.DataFrame(SDE)
SDE.to_csv(out + "\\" + "SDE.csv",index = None, header=None)
SAR = pd.DataFrame(SAR)
SAR.to_csv(out + "\\" + "SAR.csv",index = None, header=None)
SBR = pd.DataFrame(SBR)
SBR.to_csv(out + "\\" + "SBR.csv",index = None, header=None)
SCR = pd.DataFrame(SCR)
SCR.to_csv(out + "\\" + "SCR.csv",index = None, header=None)
SDR = pd.DataFrame(SDR)
SDR.to_csv(out + "\\" + "SDR.csv",index = None, header=None)