:#!/usr/bin/env python3
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

    # NOTE: This is a good candidate for parrallelization with multiproc pool
    fbrdvr=np.zeros((PolyDegreeP1, len(Xray)),dtype=np.float64)
    for n in range(PolyDegreeP1+1):
        normConstant = math.sqrt(2/(2*n+1))
        Legendre = sps.legendre(n)
        Ln = Legendre(Xray)
        fbrdvr[n,:] = Ln
    
    return fbrdvr

def Hermite(Xray):
    pass

def Legendre(Xray):
    pass

##########################################################################################
if (__name__ == '__main__'):
    import re
    import random
    import matplotlib.pyplot as plt
    import argparse
    

    PolyOrder = 5
    PolyOrderP1 = PolyOrder + 1
