#!/usr/bin/python3
import numpy as np
import scipy as sp
import scipy.special as sps
import DAF
import OrthoBases
import matplotlib.pyplot as plt


if (__name__ == '__main__'):
    # Make plots for papers and documentation

    ###################################################################################################
    # HERMITE POLYNOMIAL PLOTS

    Order = 51
    Xlimits = [-10,10]
    Npts = 1001
    sigma = 1.0
    Xray = np.linspace(Xlimits[0],Xlimits[-1],Npts,dtype=np.float64)
    H = OrthoBases.HermiteBasis(Xray, Xlimits, Order, sigma, normalized=False, derivatives=0)
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
    H = DAF.DAF_Hermite(Xray,Xbar,DerOrder=2,sigma=1.0,M=51)

    print(H)
    figHD2 = plt.figure()
    axHD2 = figHD2.add_subplot(1,1,1)
    for i in range(len(H.delta_mat)):
        plt.plot(Xbar,H.delta_mat[i,:])
    #plt.show()
    

    ######################################################################################
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
    P = DAF.DAF_Legendre(Xray,Xbar)

    figPD2 = plt.figure()
    axPD2 = figPD2.add_subplot(1,1,1)
    for i in range(len(P.delta_mat)):
        plt.plot(Xbar,P.delta_mat[i,:])
    plt.show()
    


    ######################################################################################
