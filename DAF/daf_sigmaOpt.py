#!/usr/bin/env python3
'''
This routine finds an optimal sigma scaling and expansion degree for
expanding the delta function in orthogonal polynomials. 

The optimzation functions are designed to be called by a separate program
as needed, but herein is a set of testing functions also under main. 
'''
import numpy as np
import scipy as sp
import scipy.special as sps

def sigmaOptHermite(Xray,M=None, sigma=None):
    return sigma

def sigmaOptLaguerre(Xray,M=None, sigma=None):
    return sigma

if (__name__ == '__main__'):
    
    import matplotlib.pyplot as plt

    Xray = np.linspace(-1,1,101)

    SigmaH = SigmaOptHermite(Xray)
    SigmaL = SigmaOptLaguerre(Xray)

    print('Simga Hermite ', SigmaH)
    print('Sigma Laguerre', SigmaL)


