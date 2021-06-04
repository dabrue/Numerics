#!/usr/bin/python3
import numpy as np
import scipy as sp
import scipy.special as sps
import DAF
import OrthoBases
import matplotlib.pyplot as plt
import matplotlib.cm as mpcm
import random
import math

pi = math.pi
rtpi = math.sqrt(math.pi)


    # Make plots for papers and documentation

##########################################################################################
def hermite_plots():
    # HERMITE POLYNOMIAL PLOTS

    Order = 51
    Xlimits = [-10,10]
    Npts = 1001
    sigma = 1.0
    Xray = np.linspace(Xlimits[0],Xlimits[-1],Npts,dtype=np.float64)
    H = OrthoBases.HermiteBasis(Xray,Xlimits,Order,sigma,normalized=False,derivatives=0)
    HBase = H.BasisMat

    figH = plt.figure()
    axH = figH.add_subplot(1,1,1)
    for i in range(Order):
        axH.plot(Xray,HBase[i])
    #plt.show()

    # Construct delta function
    hco = DAF.HdeltaCoef_part
    hdelta = np.zeros_like(Xray)
    for m in range(Order):
        hdelta = hco[m]*HBase[m,:]

    figHD = plt.figure()
    axHD = figHD.add_subplot(1,1,1)
    plt.plot(Xray,hdelta)
    #plt.show()

    # Make plots of the dirac delta function 
    Xray = np.linspace(-10,10,11)
    Xbar = np.linspace(-10,10,1001)
    MaxM = 11
    sigma = 1.0
    DerOrder = 0
    HermExpSet = []
    H = DAF.DAF_1D_Hermite(Xray,Xbar,DerOrder=2,sigma=1.0,M=51)

    print(H)
    figHD2 = plt.figure()
    axHD2 = figHD2.add_subplot(1,1,1)
    for i in range(len(H.delta_mat)):
        plt.plot(Xbar,H.delta_mat[i,:])
    plt.show()
    return 0
    

##########################################################################################
def legendre_plots():
    # LEGENDRE POLYNOMIAL PLOTS
    Order = 10
    Xlimits = [-1,1]
    Npts = 101
    Xray = np.linspace(Xlimits[0],Xlimits[-1],Npts,dtype=np.float64)
    P = OrthoBases.LegendreBasis(Xray, Xlimits, Order, normalized=False, derivatives=0)

    figP = plt.figure()
    axP = figP.add_subplot(1,1,1)
    for i in range(Order):
        axP.plot(Xray,P.BasisMat[i])
    #plt.show()

    Nray = 11
    Nbar = 101
    Xray = np.linspace(Xlimits[0],Xlimits[-1],Nray,dtype=np.float64)
    Xbar = np.linspace(Xlimits[0],Xlimits[-1],Nbar,dtype=np.float64)
    P = DAF.DAF_1D_Legendre(Xray,Xbar)

    figPD2 = plt.figure()
    axPD2 = figPD2.add_subplot(1,1,1)
    for i in range(len(P.delta_mat)):
        plt.plot(Xbar,P.delta_mat[i,:])
    plt.show()
    
    return 0


##########################################################################################
def hermite_2D_plots():

    M = 51 

    Xmin = -10.0
    Xmax =  10.0
    Ymin = -10.0
    Ymax =  10.0

    Nxb = 201
    Nyb = 201

    Nxr = 5
    Nyr = 5

    Xray = np.linspace(Xmin,Xmax,Nxr)
    Yray = np.linspace(Ymin,Ymax,Nyr)
    Xbar = np.linspace(Xmin,Xmax,Nxb)
    Ybar = np.linspace(Ymin,Ymax,Nyb)

    HX = DAF.DAF_1D_Hermite(Xray,Xbar,sigma=1.0,M=M)
    HY = DAF.DAF_1D_Hermite(Yray,Ybar,sigma=1.0,M=M)


    X=np.zeros([Nxb,Nyb],dtype=np.float32)
    Y=np.zeros([Nxb,Nyb],dtype=np.float32)
    Z=np.zeros([Nxb,Nyb],dtype=np.float32)
    for ixr in range(Nxr):
        for iyr in range(Nyr):
            for ixb in range(Nxb):
                for iyb in range(Nyb):
                    Z[ixb,iyb] += HX.delta_mat[ixr,ixb]*HY.delta_mat[iyr,iyb]

    for i in range(Nxb):
        for j in range(Nyb):
            X[i,j] = Xbar[i]
            Y[i,j] = Ybar[j]

    X=np.array(X)
    Y=np.array(Y)
    Z1=np.array(Z)

    fig0=plt.figure(figsize=(10,10))
    ax0 = fig0.add_subplot(projection='3d')
    #ax0.plot_surface(X,Y,Z,cmap=mpcm.viridis)
    #ax0.plot_surface(X,Y,Z,cmap=mpcm.RdYlBu)
    #ax0.plot_surface(X,Y,Z,cmap=mpcm.bwr)
    ax0.plot_surface(X,Y,Z1,cmap=mpcm.seismic)

    # ------------------------------------------------
    # next lets make one from a random tessellation
    random.seed()
    Ndeltas = 10
    Xrand = np.zeros(Ndeltas)
    Yrand = np.zeros(Ndeltas)
    for i in range(Ndeltas):
        Xrand[i] = random.random()*(Xmax-Xmin)+Xmin
        Yrand[i] = random.random()*(Ymax-Ymin)+Ymin

    HX1 = DAF.DAF_1D_Hermite(Xrand,Xbar,sigma=1.0,M=M)
    HY1 = DAF.DAF_1D_Hermite(Yrand,Ybar,sigma=1.0,M=M)
    Z2=np.zeros([Nxb,Nyb],dtype=np.float32)
    print('SHAPES HX,HY',HX1.delta_mat.shape, HY1.delta_mat.shape)
    for k in range(Ndeltas):
        for ixb in range(Nxb):
            for iyb in range(Nyb):
                Z2[ixb,iyb] += HX1.delta_mat[k,ixb]*HY1.delta_mat[k,iyb]

    figt = plt.figure(figsize=(10,10))
    #axt = figt.add_subplot(projection='3d')
    axt = figt.add_subplot(1,1,1)
    for k in range(Ndeltas):
        plt.plot(Xbar,HX1.delta_mat[k,:],label=str(k))
    plt.legend()

    fig1 = plt.figure(figsize=(10,10))
    ax1 = fig1.add_subplot(projection='3d')
    Z0s = np.zeros_like(Xrand)
    ax1.scatter(Xrand,Yrand,Z0s,'ko')

    fig2 = plt.figure(figsize=(10,10))
    ax2 = fig2.add_subplot(projection='3d')
    ax2.plot_surface(X,Y,Z2,cmap=mpcm.seismic)


    plt.show()

    return 0

def hermite_1D_compare(X,Fgiven,Fcalc):
    fig0 = plt.figure(figsize=(10,10))
    ax0 = fig0.add_subplot(1,1,1)
    ax0.plot(X,Fgiven,label='Given')
    ax0.plot(X,Fcalc,label='Calc')

    diff = abs(Fgiven-Fcalc)
    rms = np.sqrt(np.sum((diff**2)))
    print("1D RMS Diff:",rms)

    figE = plt.figure(figsize=(10,10))
    axE = figE.add_subplot(1,1,1)
    axE.plot(X,diff)
    plt.show()
    
    return 0

def hermite_2D_compare(X,Y,Fgiven,Fcalc):
    pass

def trig_plots():
    Xmin = -pi
    Xmax = pi
    Order = 100
    Nray = 11
    Nbar = 1001
    Xray = np.linspace(Xmin,Xmax,Nray)
    Xbar = np.linspace(Xmin,Xmax,Nbar)

    scdaf = DAF.DAF_1D_Trig(Xray,Xbar)
    fig0 = plt.figure(figsize=(10,10))
    ax0 = fig0.add_subplot(1,1,1)
    for i in range(Nray):
        plt.plot(Xbar,scdaf.delta_mat[i,:])
    plt.show()


if (__name__ == '__main__'):
    rtn = hermite_plots()
    rtn = legendre_plots()
    rtn = hermite_2D_plots()
    rtn = trig_plots()


