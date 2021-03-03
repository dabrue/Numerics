#!/usr/bin/env python3
'''
This is a practice script for FBR/DVR 

Finite Element Representation to Discrete Variable Representation
'''
##########################################################################################
# PREFACE
import math
import numpy as np
import scipy as sp
import scipy.special as sps
import matplotlib.pyplot as plt
import pandas

##########################################################################################
# FUNCTIONS AND DEFINITIONS

def int_trapazoid(X, A, B, W):

    # Sanity Check
    if (len(X) != len(A) or len(X) != len(B) or len(X) != len(W)):
        exit("ERROR: Trapaxoid integrate Length mismatch")
    else: 
        pass

    S = 0.0
    for i in range(1,len(X)):
        S += (A[i]*B[i]*W[i]+A[i-1]*B[i-1]*W[i-1])*(X[i]-X[i-1]) / 2
    return S


##########################################################################################
# MAIN DRIVER
if (__name__ == '__main__'):

    # First let us see how calling the built-in special functions works
    Npts = 1001
    xmin = -10
    xmax = 10
    xray = np.linspace(xmin,xmax,Npts)
    wray = np.zeros_like(xray)

    # NOTE the SPS hermite functions are different from sps.hermitenorm in the 
    # normalization. I'm using standard hermite here and accounting for the extra
    # factor of 2 in the normalization. Alternatively, one can use hermitenorm.
    H0 = sps.hermite(0)
    H1 = sps.hermite(1)
    H2 = sps.hermite(2)

    H0ray = np.zeros_like(xray)
    H1ray = np.zeros_like(xray)
    H2ray = np.zeros_like(xray)

    for i in range(Npts):
        wray[i] = math.exp(-(xray[i]**2))
        H0ray[i] = H0(xray[i])
        H1ray[i] = H1(xray[i])
        H2ray[i] = H2(xray[i])

    dx = (xmax - xmin)/ (Npts - 1 )
    N02=dx*np.matmul(H0ray.transpose(),H2ray)
    print("Norm 0 2",N02)
    N02=0.0
    for i in range(1,Npts):
        N02 += dx*(H0ray[i]*H2ray[i] + H2ray[i-1]*H0ray[i-1])/2
    print("Norm 0 2",N02)
    N02=0.0

    NHermites = 5
    Hray=[]
    for i in range(NHermites):
        tmp = np.zeros_like(xray)
        H = sps.hermite(i)
        for j in range(Npts):
            tmp[j] = H(xray[j])
        Hray.append(tmp)

    HermiteNorms = np.zeros((NHermites,NHermites),dtype=np.float)
    HermiteNorms2 = np.zeros((NHermites,NHermites),dtype=np.float)

    for i in range(NHermites):
        norm_constant= 2**i * math.factorial(i)*math.sqrt(math.pi)
        print('NC',i,norm_constant)
        for j in range(NHermites):
            HermiteNorms[i,j] = int_trapazoid(xray,Hray[i],Hray[j],wray) / norm_constant
            HermiteNorms2[i,j] = sum(Hray[i]*Hray[j]*wray)*dx / (2**i * math.factorial(i)*math.sqrt(math.pi))

    print(HermiteNorms)
    print("")
    print(HermiteNorms2)

    i = 1
    j = 1
    tmp = sum(Hray[i]*Hray[j]*wray)*dx / (2**i * math.factorial(i)*math.sqrt(math.pi))
    print('tmp int test',tmp)

    fig = plt.figure()
    ax0 = fig.add_subplot(1,1,1)
    for i in range(NHermites):
        plt.plot(xray,Hray[i])
    plt.show()

    # GOOD. Let's do the same with Lengendre polynomials
