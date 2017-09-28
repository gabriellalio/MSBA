# -*- coding: utf-8 -*-
"""
Created on Thu Aug 10 13:37:51 2017

@author: Ali Prasla
"""
import pandas as pd
from pandas import Series,DataFrame
import numpy as np
import matplotlib.pyplot as plt


Crime = pd.read_csv("Crime.csv")
#Arrest Rates By District
ArrestDistrict = pd.pivot_table(Crime[["ID","District","Arrest","Year"]],index = ['District','Year'],columns = ['Arrest'],aggfunc = np.count_nonzero)
ArrestDistrict = pd.DataFrame(ArrestDistrict.to_records())
ArrestDistrict.columns = ["District","Year","Arrest False","Arrest True"]
ArrestDistrict["Arrest Rate"] = ArrestDistrict["Arrest True"]/(ArrestDistrict["Arrest False"] + ArrestDistrict["Arrest True"])
ArrestDistrict["Total Crime"] = ArrestDistrict["Arrest True"] + ArrestDistrict["Arrest False"]


ArrestDistrict = ArrestDistrict[ArrestDistrict["Year"] != 2017]

##problem change num plots depending on AnalysisDistricts length
AnalysisDistricts = [8,11,25]
InterestThreshold = 0
ArrestDistrict = ArrestDistrict[ArrestDistrict["District"].isin(AnalysisDistricts)]
fig, axarr = plt.subplots(len(AnalysisDistricts),sharex = True,sharey = True)
plt.tight_layout()

#print plots and construct yearsOfInterest
yearList = []
for idx,axes in enumerate(axarr):
    xSer = ArrestDistrict[ArrestDistrict["District"] == AnalysisDistricts[idx]]["Year"]
    ySer = ArrestDistrict[ArrestDistrict["District"] == AnalysisDistricts[idx]]["Arrest Rate"]
    percentChange = (ySer - ySer.shift())/ySer.shift()
    percentChange.index = xSer
    yearList.append(list(percentChange[(percentChange >= InterestThreshold) | (percentChange <= -InterestThreshold)].index))
    axes.plot(xSer,ySer)
    titleStr = "Arrest Rate for Police District " + str(AnalysisDistricts[idx]) + " from 2001 -2016"
    axes.set_title(titleStr)
plt.show()


#Look at the top crimes for each year of District
CrimeDfs = []
for idx,yearDistrict in enumerate(yearList):
    releventCrime = Crime[Crime["District"] == AnalysisDistricts[idx] & Crime["Year"].isin(yearList[idx])]
    pivot = pd.pivot_table(releventCrime[["ID","Year","Primary Type"]],index = ['Year'],columns = ['Primary Type'], aggfunc = np.count_nonzero)
    pivot = pd.DataFrame(pivot.to_records())
    colList = []
    for i in range(len(pivot.columns)):
        if i == 0:
            colList.append(pivot.columns[i])
        else:
            colList.append(pivot.columns[i].split("'")[3])
    pivot.columns = colList
    pivot["sum"] = pivot.loc[:,"ASSAULT":"THEFT"].sum(axis = 1)
    pivot = pivot.loc[:,"ASSAULT":"THEFT"].div(pivot["sum"],axis = 0)
    if not pivot.empty:
        pivot.index = yearList[idx]
    #build plots
    CrimeDfs.append([AnalysisDistricts[idx],pivot])
    
    
