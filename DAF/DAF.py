#!/usr/bin/env python3
'''
Module providing routines for Distributed Approximating Functionals numerical methods

Daniel Brue, 2021
'''

import numpy as np
import scipy as sp
import scipy.special as sps

def gen_Hermite(Xray, M, sigma, DerOrder):
    pass

def gen_Legendre(Xray, M, DerOrder):
    pass

def gen_Laguerre(Xray, M, sigma, DerOrder):
    pass


class DAF:

    def __init__(PolyBase='hermite':str,Xray:np.array,DerOrder=0:int,sigma=1.0:float,M=50:int):
        self.PolyBase = PolyBase
        self.Xray = Xray
        self.DerOrder = DerOrder
        self.sigma=1.0
        self.ExpOrder = M           
        if (PolyBase == 'hermite'):
            DAFMAT = gen_Hermite(Xray, M 
        elif (PolyBase == 'legendre'):
            DAFMAT = gen_Legendre(Xray, M)
        elif (PolyBase == 'laguerre'):
            DAFMAT = gen_Laguerre(Xray, M, sigma)
        elif (PolyBase == 'chebyshev'):
            DAFMAT = gen_Chebyshev(Xray, M
        else:
            raise('ERROR: Unidentified Polynomial Expansion : ', PolyBase)
            exit()

if (__name__ == '__main__'):
    import re
    import random
    import matplotlib.pyplot as plt
    
    
