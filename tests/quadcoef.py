#!/usr/bin/env python3
'''
Tests and derivations for Simpson's Quadrature
'''
import numpy as np
import math
import scipy as sp
import scipy.special as sps
import scipy.linalg as spla


pi = math.pi

if (__name__ == '__main__'):

    a=-2
    b= 5
    c= 7

    x0=0.0
    x1=1.0
    x2=5.0

    Xray = np.array([x0,x1,x2],dtype=np.float64)

    f0 = a + b*x0 + c*x0**2
    f1 = a + b*x1 + c*x1**2
    f2 = a + b*x2 + c*x2**2

    cp = ((x1-x0)*(f2-f0) - (x2-x0)*(f1-f0))/((x2-x0)*(x1-x0)*(x2-x1))
    bp = (f1-f0)/(x1-x0)-cp*(x1+x0)
    ap = f0 - bp*x0-cp*x0**2

    print(a, b, c)
    print(ap, bp, cp)

    # The integral of this is then
    Intf = ap*(x2-x0) + bp*(x2**2-x0**2)/2 + cp*(x2**3-x0**3)/3

    # Next, rewrite the above to be in like terms of f instead of coefficients
    Q = 1.0/((Xray[2]-Xray[1])*(Xray[1]-Xray[0])*(Xray[2]-Xray[0]))

    cf = np.zeros(3,dtype=np.float64)
    bf = np.zeros(3,dtype=np.float64)
    af = np.zeros(3,dtype=np.float64)
    wgt = np.zeros(3,dtype=np.float64)

    cf[0] = (Xray[2]-Xray[1])*Q
    cf[1] = (Xray[0]-Xray[2])*Q
    cf[2] = (Xray[1]-Xray[0])*Q
    bf[0] = 1/(Xray[0]-Xray[1]) - (Xray[1]+Xray[0])*cf[0]
    bf[1] = 1/(Xray[1]-Xray[0]) - (Xray[1]+Xray[0])*cf[1]
    bf[2] = - (Xray[1]+Xray[0])*cf[2]
    # a = f0-x0 * b - x0**2 * c
    af[0] = Xray[0]*bf[0] - Xray[0]**2 * cf[0] + 1  # +1 for the f0  term
    af[1] = Xray[0]*bf[1] - Xray[0]**2 * cf[1]
    af[2] = Xray[0]*bf[2] - Xray[0]**2 * cf[2]

    wgt[0] = (Xray[2]-Xray[0])*af[0] + (Xray[2]**2-Xray[0]**2)*bf[0]/2+(Xray[2]**3-Xray[0]**3)*cf[0]/3
    wgt[1] = (Xray[2]-Xray[0])*af[1] + (Xray[2]**2-Xray[0]**2)*bf[1]/2+(Xray[2]**3-Xray[0]**3)*cf[1]/3
    wgt[2] = (Xray[2]-Xray[0])*af[2] + (Xray[2]**2-Xray[0]**2)*bf[2]/2+(Xray[2]**3-Xray[0]**3)*cf[2]/3

    # Now, the integral should be: 
    Intw = wgt[0]*f0 + wgt[1]*f1 + wgt[2]*f2

    print('Intf',Intf)
    print('Intw',Intw)
