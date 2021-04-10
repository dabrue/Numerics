#!/usr/bin/env python3
import math
import numpy as np
import scipy as sp
import scipy.spatial as spspace
import scipy.special as sps
import matplotlib.pyplot as plt
import random
import tess
#from mpl_toolkits.mplot3d import Axes3D

random.seed()

Ntess = 104

# Set up grid for visualization
NXray = 101
NYray = 101
Xmin  = 0.0
Xmax  = 10.0
Ymin  = 0.0
Ymax  = 10.0
Xlim  = [Xmin,Xmax]
Ylim  = [Ymin,Ymax]
Xray = np.linspace(Xmin,Xmax,NXray,dtype=np.double)
Yray = np.linspace(Ymin,Ymax,NYray,dtype=np.double)

tessPts = np.zeros([Ntess,2],dtype=np.double)
i=-1
for x in Xlim:
    for y in Ylim:
        i += 1
        tessPts[i,0]=x
        tessPts[i,1]=y

for i in range(4,Ntess):
    x = random.random()*(Xmax-Xmin)+Xmin
    y = random.random()*(Ymax-Ymin)+Ymin
    tessPts[i,0] = x
    tessPts[i,1] = y

Tess = spspace.Delaunay(tessPts)

def intTess(tessPts,Tess):
    wgts = np.zeros(Ntess,dtype=np.double)
    for i in range(len(Tess.simplices)):
        a = Tess.points[Tess.simplices[i,0]]
        b = Tess.points[Tess.simplices[i,1]]
        c = Tess.points[Tess.simplices[i,2]]
        ar = tess.triangle_area(a,b,c)
        wgts[Tess.simplices[i,0]] += ar/3.0
        wgts[Tess.simplices[i,1]] += ar/3.0
        wgts[Tess.simplices[i,2]] += ar/3.0

    return wgts

def f_simple(pts):
    f = np.zeros(len(pts))
    for i in range(len(pts)):
        f[i] = pts[i,0]+pts[i,1] 
    return f

def f_trig(pts):
    f = np.zeros(len(pts))
    for i in range(len(pts)):
        f[i] = math.sin(pts[i,0])+math.cos(pts[i,1])
    return f

if (__name__ == '__main__'):

    figT0 = plt.figure(figsize=(10,10))
    plt.triplot(tessPts[:,0],tessPts[:,1],Tess.simplices)
    plt.plot(tessPts[:,0],tessPts[:,1],'go')

    wgts=intTess(tessPts,Tess)
    areaCalc = np.sum(wgts)
    areaGivn = (Xmax-Xmin)*(Ymax-Ymin)
    print('Areas: ',areaGivn,areaCalc)

    F_Simple = f_simple(Tess.points)

    figT1 =plt.figure(figsize=(10,10))
    axT1 = figT1.add_subplot(projection='3d')
    axT1.scatter(Tess.points[:,0],Tess.points[:,1],F_Simple,marker='o')

    figT2 =plt.figure(figsize=(10,10))
    axT2 = figT2.add_subplot(projection='3d')
    lines=[]
    for i in range(len(Tess.simplices)):
        ia = Tess.simplices[i,0]
        ib = Tess.simplices[i,1]
        ic = Tess.simplices[i,2]
        a = Tess.points[ia]
        b = Tess.points[ib]
        c = Tess.points[ic]
        line1x = [a[0],b[0]]
        line1y = [a[1],b[1]]
        line1z = [F_Simple[ia],F_Simple[ib]]
        lines.append([line1x,line1y,line1z])
        line1x = [b[0],c[0]]
        line1y = [b[1],c[1]]
        line1z = [F_Simple[ib],F_Simple[ic]]
        lines.append([line1x,line1y,line1z])
        line1x = [c[0],a[0]]
        line1y = [c[1],a[1]]
        line1z = [F_Simple[ic],F_Simple[ia]]
        lines.append([line1x,line1y,line1z])
    for i in range(len(lines)):
        plt.plot(lines[i][0],lines[i][1],lines[i][2],'k-')
    axT2.scatter(Tess.points[:,0],Tess.points[:,1],F_Simple,marker='o')

    F_Trig = f_trig(Tess.points)

    figT3 =plt.figure(figsize=(10,10))
    axT3 = figT1.add_subplot(projection='3d')
    axT3.scatter(Tess.points[:,0],Tess.points[:,1],F_Trig,marker='o')

    figT4 =plt.figure(figsize=(10,10))
    axT4 = figT4.add_subplot(projection='3d')
    lines=[]
    for i in range(len(Tess.simplices)):
        ia = Tess.simplices[i,0]
        ib = Tess.simplices[i,1]
        ic = Tess.simplices[i,2]
        a = Tess.points[ia]
        b = Tess.points[ib]
        c = Tess.points[ic]
        line1x = [a[0],b[0]]
        line1y = [a[1],b[1]]
        line1z = [F_Trig[ia],F_Trig[ib]]
        lines.append([line1x,line1y,line1z])
        line1x = [b[0],c[0]]
        line1y = [b[1],c[1]]
        line1z = [F_Trig[ib],F_Trig[ic]]
        lines.append([line1x,line1y,line1z])
        line1x = [c[0],a[0]]
        line1y = [c[1],a[1]]
        line1z = [F_Trig[ic],F_Trig[ia]]
        lines.append([line1x,line1y,line1z])
    for i in range(len(lines)):
        plt.plot(lines[i][0],lines[i][1],lines[i][2],'k-')

    axT4.scatter(Tess.points[:,0],Tess.points[:,1],F_Trig,marker='o')
    plt.show()
