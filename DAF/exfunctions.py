#!/usr/bin/env python3
'''
This routine generates test functions for studying and stress testing the DAF methods

Daniel Brue, March 2021
'''
import math
import numpy as np
import scipy as sp
import scipy.special as sps

def rmsError(Xray, Yray, Fray, Wray=None):
    '''
    Calculate difference as an rms error between two functions, Yray and Fray. 
    Yray is though of as the analytic solution, Fray the numeric, but it doesn't matter. 

    Wray is an optional weighting array and is set to 1 unless specified. 
    '''

    err = 0.0

    if (not Wray):
        Wray=np.ones_like(Fray)
    for i in range(len(Xray)):
        err += Wray[i]*(Yray[i]-Fray[i])**2

    return(err)

def Legendre_Eval(P_order, Xray, normalized=False):
    '''
    # This routine makes use of the following recurrance relationships
    # 
    '''
    import scipy.special as sps


def F1():

    # Multiplying a Gaussian and Legendre Polynomials

    Porder = 19  # order of the legendre polynomial to be used. 

    def _f1gen(Xray):
        Nx = len(Xray)
        Y0ray = numpy.zeros_like(Xray)
        Y1ray = numpy.zeros_like(Xray)
        Y2ray = numpy.zeros_like(Xray)
        for i in range(len(Nx)):
        

    Nx = 1001
    Xmin = -10
    Xmax = 10
    dX = (Xmax-Xmin)/(Nx-1)
    Xray = np.linspace(Xmin,Xmax,Nx)
    Yray = _f1gen(Xray)

