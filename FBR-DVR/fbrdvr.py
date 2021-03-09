#!/usr/bin/env python3
'''
Routines for generating the tranformation matrices for Finite Basis Representation (FBR)
to the Discrete Variable Representation (DVR)

Daniel Brue
March, 2021
'''
import math
import numpy as np
import scipy as sp
import scipy.special as sps

def Legendre(PolyDegreeP1,Xray):
    '''
    Note that Legendre polynomials have a normalization factor of 2/(2n+1) for the
    n-th degree polynomial. This factor will be applied in this definition to 
    construct an orthonormal function set.
    '''

    fbrdvr=np.zeros((PolyDegreeP1, len(Xray)),dtype=np.float64)
    for n in range(PolyDegreeP1):
        normConstant = math.sqrt(2/(2*n+1))
        Legendre = sps.legendre(n)
        Ln = Legendre(Xray)/normConstant
        fbrdvr[n,:] = Ln
    
    return fbrdvr

def Chebyshev(PolyDegreeP1,Xray):

def Hermite(Xray,sigma):
    fbrdvr=np.zeros((PolyDegreeP1, len(Xray)),dtype=np.float64)
    weightFunc = np.zeros_like(Xray)
    for i in range(len(Xray)):
        weightFunc[i] = math.sqrt(math.exp(-Xray[i]**2))
    for n in range(PolyDegreeP1):
        normConstant = math.sqrt(2/(2*n+1))
        Legendre = sps.hermite(n)
        Ln = Legendre(Xray)/normConstant
        fbrdvr[n,:] = Ln

def Laguerre(Xray):
    pass

##########################################################################################
if (__name__ == '__main__'):
    import re
    import random
    import matplotlib.pyplot as plt
    import argparse
    

    PolyOrder = 5
    PolyOrderP1 = PolyOrder + 1
    xray = np.linspace(-1,1,101)
    Ldvr = Legendre(PolyOrderP1,xray)
    fig0 = plt.figure()
    ax0 = fig0.add_subplot(1,1,1)
    for i in range(PolyOrderP1):
            plt.plot(xray,Ldvr[i])
    plt.show()
