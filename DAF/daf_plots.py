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
    plt.show()

    # Construct delta function
    hco = DAF.HdeltaCoef_part
    hdelta = np.zeros_like(Xray)
    for m in range(Order):
        hdelta = hco[m]*HBase[m,:]

    figHD = plt.figure()
    axHD = figHD.add_subplot(1,1,1)
    plt.plot(Xray,hdelta)
    plt.show()
    

    ###################################################################################################
    # LEGENDRE POLYNOMIAL PLOTS
    Order = 10
    Xlimits = [-1,1]
    Npts = 1001
    Xray = np.linspace(Xlimits[0],Xlimits[-1],Npts,dtype=np.float64)
    P = OrthoBases.LegendreBasis(Xray, Xlimits, Order, normalized=False, derivatives=0)

    figP = plt.figure()
    axP = figP.add_subplot(1,1,1)
    for i in range(Order):
        axP.plot(Xray,P.BasisMat[i])
    plt.show()
