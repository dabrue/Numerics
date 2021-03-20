#!/usr/bin/env python3
import numpy as np
import math
import scipy as sp
import scipy.special as sps
import scipy.linalg as spla


pi = math.pi

if (__name__ == '__main__'):

    a=-2
    b= 5
    c= pi

    x0=0.0
    x1=1.0
    x2=3.0

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
    

    
    
