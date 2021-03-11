#!/usr/bin/env python3
'''
Tests run during the development of DAF code. Don't expect much of this to make sense. 

This routine is intended to break the DAF, show what its limits are, and try to figure
out new methods that may be employed. 

Daniel Brue, March 2021
'''

import math
import numpy as np
import scipy as sp
import scipy.special as sps
import matplotlib.pyplot as plt
import DAF
import exfunctions

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
    #CosX = np.zeros((Mp1,Mp1),dtype=np.float64)

    Xmin = -pi
    Xmax = pi
    Xray = np.linspace(Xmin,Xmax,Nx)

    # Determine delta function expansion coefficients for a cosine
    cosn=np.zeros_like(Xray)
    #cosn=cosn+1.0/(2) #*pi)  # This is the normalized cos(0*x) term
    for n in range(1,Mp1):
        for i in range(len(Xray)):
            cosn[i] += math.cos(n*Xray[i])

    t = int((Nx-1)/2)
    print('t index =',t)
    #cosn[t]=0.0

    fig0 = plt.figure()
    axc0 = fig0.add_subplot(1,1,1)
    plt.plot(Xray,cosn)
    plt.show()


def stresstest1():
    Nx=101
    Xmin=-10
    Xmax= 10
    dX = (Xmax-Xmin)/(Nx-1)
    Xray = np.linspace(Xmin,Xmax,Nx)
    Fray = exfunctions.F1(Xray)
    

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

    Npts=501
    Mexpand = 20000
    #rtn = sinusoidal_delta(Npts,Mexpand)

    # Next try the Hermite Expansion

    Xmin = -10.0
    Xmax = 10.0
    Nx = 1001
    Mexpand = 50
    Xray = np.linspace(Xmin,Xmax,Nx)
    dafHerm = DAF.DAF("hermite",Mexpand, 0)
    print(dafHerm.DAFMAT)
