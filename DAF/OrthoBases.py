#!/usr/bin/env python3
'''
Routines for generating orthonormal basis functions

Daniel Brue, 2021

This routine provides methods for calculating orthogonal polynomials and their derivatives
at given sets of points. This is different than what comes out of scipy.special in that
these functions are normalized for use as an orthonormal basis set. Whereever possible, 
exact formulae or recurrsion relations are used for calculations. 
'''
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
    def __init__(self, X, Order, normalized=False, derivatives=0):
        self.X = X
        self.Order = Order
        self.normalized = normalized
        self.derivatives = derivatives
        self.LegP = []
        
    def _gen_P(self,Order, X):

        orderp1 = Order+1
        P = np.zeros((orderp1,len(X)),dtype=np.float64)
        P[0,:] = 1.0
        P[1,:] = np.array(Xray)
        for n in range(2,orderp1):
            #for i in range(len(X)):
            P[n,:] = ((2*n-1)*X*P[n-1,:] - (n-1)*P[n-2,:]) / n
        return(P)

##########################################################################################
class HermiteBasis:
    '''
    '''
    def __init__(self, X, Order, sigma, normalized=False, derivatives=0):
        self.X = X
        self.Order = Order
        self.sigma = sigma
        self.normalized = normalized
        self.derivatives = derivatives

    def _gen_H():
        pass

##########################################################################################
if (__name__ == '__main__'):

    import matplotlib.pyplot as plt
    
    Xmin = -1
    Xmax =  1
    Nx   = 101
    dx = (Xmax-Xmin)/(Nx-1)
    Xray = np.linspace(Xmin,Xmax,Nx)
    Order = 5
    LegP = LegendreBasis(Xray, Order)
    Pfuncs = LegP._gen_P(Order, Xray)
    print(Pfuncs)

    fig0=plt.figure()
    ax0 = fig0.add_subplot(1,1,1)
    for i in range(Order):
        plt.plot(Xray,Pfuncs[i,:])
    plt.show()
