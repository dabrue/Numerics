#!/usr/bin/env python3
'''
Routines for generating orthonormal basis functions
'''
import math
import numpy as np
import scipy as sp
import scipy.special as sps

##########################################################################################
class Legendre_Basis:
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
        
        if (derivatives > 0):
            P

    def _gen_P(Order, X):

##########################################################################################
class Hermite_Basis:
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
    pass
