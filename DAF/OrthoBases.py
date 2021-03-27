#!/usr/bin/env python3
'''
Routines for generating orthonormal basis functions

Daniel A. Brue, 2021

This routine provides methods for calculating orthogonal polynomials and their derivatives
at given sets of points. This is different than what comes out of scipy.special in that
these functions are normalized for use as an orthonormal basis set. Whereever possible, 
exact formulae or recurrsion relations are used for calculations. 
'''

__author__ = 'Daniel Brue'
__date__   = 'Spring 2021'

import math
import numpy as np
import scipy as sp
import scipy.special as sps

##########################################################################################
class LegendreBasis:
    '''
    Recurrance Relations used in this routines for Legendre polynomials
    (n+1)*P[n+1](x) = (2*n+1)*x*P[n](x)-n*P[n-1]
    d(P[n+1](x))/dx = (n+1)P[n](x) + x * d(P[n](x))/dx
    d(P[n+1](x))/dx = (2*n+1)P[n](x) + (2*(n-2)+1)P[n-2](x) + (2*(n-4)+1)*P[n-4](x) + ...
    '''
    def __init__(self, X, Xlimits, Order, normalized=False, derivatives=0):
        self.X = X
        self.Xmin = Xlimits[0]
        self.Xmax = Xlimits[1]
        self.Order = Order
        self.normalized = normalized
        self.derivatives = derivatives
        self.Polys = self._gen_P()
        self.Wgts  = self._gen_wgt()
        self.BasisMat = self._gen_P()

        Sane, Errs  = self._Legendre_Init_Sanity_Check()
        if (not Sane):
            for i in range(len(Errs)):
                print(Errs[i])
            exit(1)
        
    def _gen_P(self):
        orderp1 = self.Order+1
        P = np.zeros((orderp1,len(self.X)),dtype=np.float64)
        P[0,:] = 1.0
        P[1,:] = np.array(self.X)
        # Now use recurrance relation to generate the rest of the functions
        for n in range(2,orderp1):
            #for i in range(len(X)):
            P[n,:] = ((2*n-1)*self.X*P[n-1,:] - (n-1)*P[n-2,:]) / n
        return(P)

    def _gen_wgt(self):
        wgts = np.ones_like(self.X)
        return wgts

    def _Legendre_Init_Sanity_Check(self):
        Sane = True
        Errors = []
        return Sane, Errors

##########################################################################################
class HermiteBasis:
    '''
    This routine generates Hermite Polynomial basis functions that are orthonormalized
    over the given region. 

    Here we use the following recurrance relationships:

    H[n+1] = 2*x*H[n] - 2*n*H[n-1]

    # Hermite Polynomials are an Appell Sequence and follow the derivative relation:

    H'[n] = 2*n*H[n-1]

    which can be generalized for any derivative order, d as

    H{d}[n] = 2^d * (n!/(n-d)!) * H[n-d]

    where H{0} is the Hermite polynomial, H{1} the first derivative, etc. 

    See accompanying documentation appendix for proofs. 
    
    '''
    def __init__(self, X, Xlimits, Order, sigma, normalized=False, derivatives=0):
        self.X = X
        self.Xmin = Xlimits[0]
        self.Xmax = Xlimits[1]
        self.Order = Order
        self.sigma = sigma
        self.normalized = normalized
        self.derivatives = derivatives
        Npts = len(X)
        self.Npts = Npts
        self.DAFMAT = [np.zeros((Npts,Npts),dtype=np.float64),]
        self.Polys = self._gen_H()
        self.Wgts  = self._gen_wgt()
        self.BasisMat = np.zeros_like(self.Polys)

        for i in range(len(self.Polys)):
            for j in range(len(self.Polys[i])):
                self.BasisMat[i,j] = self.Polys[i,j]*self.Wgts[j]

        self.weightf = _gen_H_weights()

        # Check that the inputs make sense...
        Sane, Errs = self._Hermite_Init_Sanity_Check()
        if (not Sane):
            exit()

    def _gen_H(self):
        orderp1 = self.Order + 1
        X = self.X
        H = np.zeros((orderp1,len(X)), dtype=np.float64)
        H[0,:] = 1.0
        H[1,:] = 2*self.X
        # Now use recurrance relation to generate the rest of the functions
        for n in range(2,orderp1):
            H[n,:] = 2*X*H[n-1,:] - 2*(n-1)*H[n-2,:]
        return H

    def _gen_H_weights(self):
        wgts = numpy.zeros_like(X)
        for i in range(self.Npts):
            x = self.X[i]/self.sigma
            wgts[i] = math.exp(-(x**2))
        return wgts

    def _Hermite_Init_Sanity_Check(self):
        Sane = True
        Errors = []
        return Sane, Errors

##########################################################################################
if (__name__ == '__main__'):

    import matplotlib.pyplot as plt
    
    Xmin = -10
    Xmax =  10
    Nx   = 101
    dx = (Xmax-Xmin)/(Nx-1)
    Xray = np.linspace(Xmin,Xmax,Nx)
    Order = 5

    Herm = HermiteBasis(Xray,[Xmin,Xmax],Order,1.0)
    Hfuncs = Herm.BasisMat

    fig1=plt.figure()
    ax1 = fig1.add_subplot(1,1,1)
    for i in range(Order):
        plt.plot(Xray,Hfuncs[i])


    Xmin = -1
    Xmax =  1
    Nx   = 101
    dx = (Xmax-Xmin)/(Nx-1)
    Xray = np.linspace(Xmin,Xmax,Nx)
    Order = 5
    LegP = LegendreBasis(Xray, [-1,1],Order)
    Pfuncs = LegP.BasisMat #LegP._gen_P(Order, Xray)

    fig0=plt.figure()
    ax0 = fig0.add_subplot(1,1,1)
    for i in range(Order):
        plt.plot(Xray,Pfuncs[i,:])


    plt.show()
