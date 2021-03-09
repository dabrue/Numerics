#!/usr/bin/env python3
'''
Tests run during the development of DAF code. Don't expect much of this to make sense. 

-- DAB
'''

import math
import numpy as np
import scipy as sp
import scipy.special as sps
import matplotlib.pyplot as plt
import DAF

pi = math.pi
rtpi = math.sqrt(math.pi)

def sinusoidal_delta(Nx:int,Mexpand:int):
    # Test expanding the delta function in trig functions. 

    # USEFUL IDENTITIES
    # sin(a)cos(b) = (sin(a-b) + sin(a+b)) / 2
    # sin(a)cos(b) = (cos(a-b) - cos(a+b)) / 2
    # cos(a)cos(b) = (cos(a-b) + cos(a+b)) / 2
    
    # Check orthonormality of cosines. Since sine curves are antisymmetric only cosines here
    Mp1 = Mexpand +1
    CosX = np.zeros((Mp1,Mp1),dtype=np.float64)

    Xmin = -pi
    Xmax = pi
    Xray = np.linspace(Xmin,Xmax,Nx)

    # Determine delta function expansion coefficients for a cosine
    n=5
    cosn=np.zeros_like(Xray)
    for i in range(len(Xray)):
        cosn[i] = math.cos(n*Xray[i])

    fig0 = plt.figure()
    axc0 = fig0.add_subplot(1,1,1)
    plt.plot(Xray,cosn)
    plt.show()
    

if (__name__ == '__main__'):

    
    # * Look at accuracy as a function of sigma

    # * Look at delta(x) graphs

    # * Can sigma be scaled so that the zeros of the expansion align with 
    #   the nearby x points? 

    # * Try a sinusoidal basis on [-pi,pi]. Will likely take many, many more functions
    #     to get convergence, but it may be easier for finding zeros in the delta function
    #     expansion. 
    ##########################################################################################
    # try a cosine expansion of the delta function

    print('Module Load Successful\n\nSTARTING DAF TESTS...\n')

    Npts=101
    Mexpand = 50
    rtn = sinusoidal_delta(Npts,Mexpand)