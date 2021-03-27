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

    Order = 11
    Xlimits = [-10,10]
    Npts = 1001
    sigma = 1.0
    X = np.linspace(Xlimits[0],Xlimits[-1],Npts,dtype=np.float64)
    H = OrthoBases.HermiteBasis(X, Xlimits, Order, sigma, normalized=False, derivatives=0)
    HBase = H.BasisMat

    figH = plt.figure()
    axH = figH.add_subplot(1,1,1)
    for i in range(Order):
        axH.plot(X,HBase[i])
    plt.show()

    ###################################################################################################
    Order = 10
    Xlimits = [-1,1]
    Npts = 1001
    X = np.linspace(Xlimits[0],Xlimits[-1],Npts,dtype=np.float64)
    P = OrthoBases.LegendreBasis(X, Xlimits, Order, normalized=False, derivatives=0)

    figP = plt.figure()
    axP = figP.add_subplot(1,1,1)
    for i in range(Order):
        axP.plot(X,P.BasisMat[i])
    plt.show()