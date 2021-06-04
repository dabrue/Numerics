#!/usr/bin/env python3
'''
Tools for use in the DAF routines
'''
import math
import numpy as np
import scipy as sp
import scipy.special as sps
import scipy.integrate as spint
import unittest as ut

#-----------------------------------------------------------------------------------------
def integration_weights(Xray,method='trapazoidal',equalSpaced=False):

    weights = np.zeros_like(Xray)

    Npts = len(Xray)
    dx = (Xray[-1] - Xray[0])/(Npts-1)  # ONLY USED IF ALL POINTS EQUAL SPACED

    if (method == 'midpoint' and equalSpaced):
        '''
        The midpoint method works best when the following two conditions are met: 
        1. The function analyzied has compact support and is nearly zero at the endpoints
        2. The sampled points of the function are equidistant in X (e.g. by np.linspace)
        
        If these are not met, the trapazoidal function is recommended. 
        '''
        weights = np.ones_like(Xray)*dx
    
    elif (method == 'trapazoidal'):
        weights[0] = (Xray[1]-Xray[0])/2
        for i in range(1,Npts-1):
            weights[i] = (Xray[i+1]-Xray[i-1])/2
        weights[-1] = (Xray[-1]-Xray[-2])/2

    elif (method == 'Simpsons'):
        '''
        Simpson's Method of integration works by fitting a parabola to consecutive
        elements in Xray. This only works for the full range if there are an odd number
        of points. 

        Calculations can be speeded by multiprocessing this, but unless Xray is 
        staggeringly enormous, the time spent here is not significant and simpler
        code is better. 

        A further note: this calculation can be reduced if the Xray array 
        is a set of equally spaced points. In 
        '''
        if (    Npts % 2 == 0):
            print("ERROR: Simpson's integration called with an even number of points.") 
            exit()

        if (equalSpaced):
            # If the Xray points are evenly spaced, the formula for finding the area under
            # the parabola is simple, A = (f(x0) + 4*f(x0+dx) + f(x0+ 2*dx)*dx/3
            # or more simply, A = (f[0]+4*f[1]+f[2])*dx/3
            weight[0] = 1.0
            for i in range(1,Npts-1,2):
                weight[i] = 4
                weight[i+1] = 2
            weight[-2] = 4
            weight[-2] = 1
        else:
            # Iterate off of the middle point of the block of three points. For every
            # set of three points, we find the analytic terms that lead each value
            # of the function over this range. 

            for i in range(1,Npts,2):

                # index translation: 
                i0 = i - 1  # = [0] refers to term [0] or the first point in this block
                i1 = i      # = [1] second index in this block
                i2 = i + 1  # = [2] third index in this block

                Q = 1.0/((Xray[i2]-Xray[i1])*(Xray[i1]-Xray[i0])*(Xray[i2]-Xray[i0]))

                cf = np.zeros(3,dtype=np.float64)
                bf = np.zeros(3,dtype=np.float64)
                af = np.zeros(3,dtype=np.float64)
                wgt = np.zeros(3,dtype=np.float64)

                # Check doc appendix for derivation. Lots of algebra, but the closed
                # forms for each term's contribution to the integral as separated by
                # like terms of f[] are given below. 
                cf[0] = (Xray[i2]-Xray[i1])*Q
                cf[1] = (Xray[i0]-Xray[i2])*Q
                cf[2] = (Xray[i1]-Xray[i0])*Q
                # b = (f1-f0)/(x1-x0)-(x1+x0)*c
                bf[0] = 1/(Xray[i0]-Xray[i1]) - (Xray[i1]+Xray[i0])*cf[0]
                bf[1] = 1/(Xray[i1]-Xray[i0]) - (Xray[i1]+Xray[i0])*cf[1]
                bf[2] = - (Xray[i1]+Xray[i0])*cf[2]
                # a = f0-x0 * b - x0**2 * c
                af[0] = Xray[i0]*bf[0] - Xray[i0]**2 * cf[0] + 1  # +1 for the f0  term
                af[1] = Xray[i0]*bf[1] - Xray[i0]**2 * cf[1]
                af[2] = Xray[i0]*bf[2] - Xray[i0]**2 * cf[2]

                wgt[0] =(Xray[i2]   -Xray[i0]   )*af[0] +    \
                        (Xray[i2]**2-Xray[i0]**2)*bf[0]/2 +  \
                        (Xray[i2]**3-Xray[i0]**3)*cf[0]/3

                wgt[1] =(Xray[i2]   -Xray[i0])   *af[1] +    \
                        (Xray[i2]**2-Xray[i0]**2)*bf[1]/2 +  \
                        (Xray[i2]**3-Xray[i0]**3)*cf[1]/3

                wgt[2] =(Xray[i2]   -Xray[i0]   )*af[2] +    \
                        (Xray[i2]**2-Xray[i0]**2)*bf[2]/2 +  \
                        (Xray[i2]**3-Xray[i0]**3)*cf[2]/3

                weights[i0] += wgt[0]
                weights[i1] += wgt[1]
                weights[i2] += wgt[2]

    else:
        print('ERROR: Unrecognized integration method = ',method)
        print('check inputs to DAF.integration_weights')

    return weights

def integrate(X,F,method='Simpsons'):

    if (len(X) != len(F)):
        print("X,F length mismatch in integrate")
    N = len(X)

    wgts = integration_weights(X,method='Simpsons')

    Sum = 0.0
    for i in range(N):
        Sum += wgts[i]*F[i]
    return Sum

# TEST 1
def fTest1(Xray):
    if (type(Xray) == type(np.array)):
        Fray = np.zeros_like(Xray)
        for i in range(len(Xray)):
            Fray[i] = Xray[i]**2 + 1
    else:
        Fray = Xray**2 + 1
    return Fray


class testIntegrationPoly2(ut.TestCase):

    def pfunc(self,x):
        f = x**2 + 1   # <======= here is the function being tested in this class
        return f
    
    def setUp(self):
        self.tol  = 1.0e-7
        self.Xmin =-1.0
        self.Xmax = 1.0
        self.Npts = 101
        self.Xray = np.linspace(self.Xmin,self.Xmax,self.Npts)
        self.Fray = self.populate_Fray()

        self.exactResult = 8.0/3.0

    def populate_Fray(self):
        Fray = np.zeros_like(self.Xray)
        for i in range(len(self.Xray)):
            Fray[i] = self.pfunc(self.Xray[i])
        return Fray

    def test_Simpsons(self):
        wgts = integration_weights(self.Xray,method="Simpsons")
        Int_simp = math.fsum(wgts*self.Fray)
        err = abs((Int_simp-self.exactResult))
        self.assertTrue((err < self.tol),msg="Simpsons x^2+1 "+str(err))

    def test_Trapazoidal(self):
        wgts = integration_weights(self.Xray,method="trapazoidal")
        Int_trap = math.fsum(wgts*self.Fray)
        err = abs((Int_trap-self.exactResult))
        self.assertTrue((err < self.tol),msg="Trapazoidal x^2+1 "+str(err))

    def test_Midpoint(self):
        wgts = integration_weights(self.Xray,method="midpoint",equalSpaced=True)
        Int_mids = math.fsum(wgts*self.Fray)
        err = abs((Int_mids-self.exactResult))
        self.assertTrue((err < self.tol),msg="Midpoint x^2+1 "+str(err))

    def test_scipy_Int(self):
        (Int_spint,sperror) = spint.quad(self.pfunc,self.Xmin,self.Xmax)
        err = abs((Int_spint-self.exactResult))
        self.assertTrue((err < self.tol),msg="sp.quad x^2+1 "+str(err))

    def tearDown(self):
        self.Xray = None
        self.Fray = None
        self.tol  = None
        self.Xmin = None
        self.Xmax = None
        self.Npts = None


class testIntegrationPoly3(ut.TestCase):

    def pfunc(self,x):
        f = x**3 + 1   # <======= here is the function being tested in this class
        return f
    
    def setUp(self):
        self.tol  = 1.0e-7
        self.Xmin =-1.0
        self.Xmax = 1.0
        self.Npts = 101
        self.Xray = np.linspace(self.Xmin,self.Xmax,self.Npts)
        self.Fray = self.populate_Fray()

        self.exactResult = 2.0

    def populate_Fray(self):
        Fray = np.zeros_like(self.Xray)
        for i in range(len(self.Xray)):
            Fray[i] = self.pfunc(self.Xray[i])
        return Fray

    def test_Simpsons(self):
        wgts = integration_weights(self.Xray,method="Simpsons")
        Int_simp = math.fsum(wgts*self.Fray)
        err = abs((Int_simp-self.exactResult))
        self.assertTrue((err < self.tol),msg="Simpsons x^3+1 "+str(err))

    def test_Trapazoidal(self):
        wgts = integration_weights(self.Xray,method="trapazoidal")
        Int_trap = math.fsum(wgts*self.Fray)
        err = abs((Int_trap-self.exactResult))
        self.assertTrue((err < self.tol),msg="Trapazoidal x^3+1 "+str(err))

    def test_Midpoint(self):
        wgts = integration_weights(self.Xray,method="midpoint",equalSpaced=True)
        Int_mids = math.fsum(wgts*self.Fray)
        err = abs((Int_mids-self.exactResult))
        self.assertTrue((err < self.tol),msg="Midpoint x^3+1 "+str(err))

    def test_scipy_Int(self):
        (Int_spint,sperror) = spint.quad(self.pfunc,self.Xmin,self.Xmax)
        err = abs((Int_spint-self.exactResult))
        self.assertTrue((err < self.tol),msg="sp.quad x^3+1 "+str(err))

    def tearDown(self):
        self.Xray = None
        self.Fray = None
        self.tol  = None
        self.Xmin = None
        self.Xmax = None
        self.Npts = None


class testIntegrationPoly4(ut.TestCase):

    def pfunc(self,x):
        f = x**4 + 1   # <======= here is the function being tested in this class
        return f
    
    def setUp(self):
        self.tol  = 1.0e-7
        self.Xmin =-1.0
        self.Xmax = 1.0
        self.Npts = 101
        self.Xray = np.linspace(self.Xmin,self.Xmax,self.Npts)
        self.Fray = self.populate_Fray()

        self.exactResult = 2.4

    def populate_Fray(self):
        Fray = np.zeros_like(self.Xray)
        for i in range(len(self.Xray)):
            Fray[i] = self.pfunc(self.Xray[i])
        return Fray

    def test_Simpsons(self):
        wgts = integration_weights(self.Xray,method="Simpsons")
        Int_simp = math.fsum(wgts*self.Fray)
        err = abs((Int_simp-self.exactResult))
        self.assertTrue((err < self.tol),msg="Simpsons x^4+1 "+str(err))

    def test_Trapazoidal(self):
        wgts = integration_weights(self.Xray,method="trapazoidal")
        Int_trap = math.fsum(wgts*self.Fray)
        err = abs((Int_trap-self.exactResult))
        self.assertTrue((err < self.tol),msg="Trapazoidal x^4+1 "+str(err))

    def test_Midpoint(self):
        wgts = integration_weights(self.Xray,method="midpoint",equalSpaced=True)
        Int_mids = math.fsum(wgts*self.Fray)
        err = abs((Int_mids-self.exactResult))
        self.assertTrue((err < self.tol),msg="Midpoint x^4+1 "+str(err))

    def test_scipy_Int(self):
        (Int_spint,sperror) = spint.quad(self.pfunc,self.Xmin,self.Xmax)
        err = abs((Int_spint-self.exactResult))
        self.assertTrue((err < self.tol),msg="sp.quad x^4+1 "+str(err))

    def tearDown(self):
        self.Xray = None
        self.Fray = None
        self.tol  = None
        self.Xmin = None
        self.Xmax = None
        self.Npts = None


##########################################################################################
if (__name__ == '__main__'):
    '''
    Run some tests on the integration methods. 
    '''
    import matplotlib.pyplot as plt

    Npts = 101
    Xmin = -1
    Xmax = 1

    Xray = np.linspace(Xmin,Xmax,Npts)
    Fray = fTest1(Xray)
    print(Xray)

    spquad = spint.quad(fTest1,Xmin,Xmax)

    trapwgt = integration_weights(Xray,method='trapazoidal')
    simpwgt = integration_weights(Xray,method='Simpsons')
    midswgt = integration_weights(Xray,method='midpoint',equalSpaced=True)

    trapquad = math.fsum(trapwgt*Fray)
    simpquad = math.fsum(simpwgt*Fray)
    midsquad = math.fsum(midswgt*Fray)
    print(trapquad,'trapazoidal')
    print(midsquad,'mid-point')
    print(simpquad,"Simpson's")
    print(spquad,'SciPy Quad')


