#!/usr/bin/env python3
'''

Module providing routines for Distributed Approximating Functionals numerical methods

Daniel A. Brue, 2021

'''

__author__ = 'Daniel A. Brue'
__email__  = 'danielbrue@gmail.com'
__date__   = '2021'

import math
import numpy as np
import scipy as sp
import scipy.special as sps
import scipy.linalg as spla
import multiprocessing as mp
import daf_sigmaOpt
import daf_integrate
import OrthoBases

##########################################################################################
# PARAMETERS AND SETUP
rtpi = math.sqrt(math.pi)  # save us many, many function calls

# Limits and sanity checks
MaxHermiteExpansion = 101
MaxLegendreExpansion = 101
MaxLaguerreExpansion = 101
MaxChebyshevExpansion = 101

MaxSystemExpansion = 0

for i in range(10000):
    try:
        a = math.factorial(i)
    except OverflowError:
        MaxSystemExpansion = i-1
    except:
        raise

#-----------------------------------------------------------------------------------------
# The DAF routine uses dirac delta functions expanded in terms of orthonormal polynomials.
# The coefficients for this expansion are precomputed here. 
#
# NOTE that any basis that employs a sigma spatial scaling function will need to apply 
# this later, as it is not available now. For this reason, all precomputing that can be
# done here is, and for Hermite and Laguerre systems, the coefficients will need to be
# scaled. 
#
# Also note that since the dirac delta function is symmetric in x about 0, all 
# coefficients for odd functions are zero. They are included here anyway so that the code
# is easier. A few extra bytes is worth avoiding indexing pitfalls. 

# Hermite Dirac-Delta function expansion coefficients
HdeltaCoef_part = np.zeros(MaxHermiteExpansion, dtype=np.float64)
for i in range(0,MaxHermiteExpansion,2):
    try:
        HdeltaCoef_part[i] = sps.eval_hermite(i,0.0)/(2**i * math.factorial(i)* rtpi)
    except OverflowError:
        print("WARNING: Overflow error converting factorial to float")
        print("Series stopped at n=",i)
        print("Continuing with other elements = zero")
        break
    except:
        raise

##########################################################################################
# DAF classes


#-----------------------------------------------------------------------------------------
def _gen_Legendre_coefs(x,M):

    # Recurrance: P[n+1] = (1/(n+1)) * ((2*n+1)*x*P[n] - n*P[n-1])

    PC = []
    PC.append(1)
    PC.append(x)
    for n in range(2,M+1):
        # note below the n value is shifted by 1 from recurrance
        PC.append(((2*n-3)*x*PC[n-1] - (n-1)*PC[n-2]) * PC[n])  
    PC=np.array(PC)
    return PC

#-----------------------------------------------------------------------------------------
def _gen_Laguerre_coefs(x,M):

    # Recurrance: (n+1)L[n+1] = (2*n+1-x)L[n] - n*L[n-1]
    L=[]
    L.append(1.0)
    L.append(-x+1.0)
    for n in range(2,M+1):
        L.append((1/n)*( (2*n -1 - x)*L[-1] - (n-1)*L[-2]))
    L=np.array(L)
    return L

#-----------------------------------------------------------------------------------------
def _gen_ChebyT_coefs(x,M):

    # Recurrance: T[n+1] = 2*x*T[n] - T[n-1]

    T=[]
    T.append(1.0)
    T.append(x)
    for n in range(2,M+1):
        T.append(2*x*T[-1] - T[-2])
    T=np.array(T)
    return T

##########################################################################################
class DAF_Chebyshev:
    def __init__(self):
        pass
##########################################################################################
class DAF_Laguerre:
    def __init__(self):
        pass
##########################################################################################
class DAF_Legendre:

    '''
    (n+1)*P[n+1] = (2*n+1)*x*P[n] - n*P[n-1]

    P'[n] = (n/(x**2-1))*(x*P[n] -P[n-1])
    '''

    def __init__(self,Xray:np.array,Xbar:np.array,DerOrder=0,M=50):
        self.Xray = Xray
        self.Xbar = Xbar
        self.Nray = len(Xray)
        self.Nbar = len(Xbar)
        self.DerOrder = DerOrder
        self.ExpOrder = M
        self.MaxExpand = M + DerOrder + 1
        self.delta_coefs = self.gen_delta_coefs()
        self.Legendre_mat = self.gen_Legendre_mat()
        self.delta_mat = self.gen_delta_mat()

    def gen_delta_coefs(self):
        delta_coefs = np.zeros((self.Nray,self.MaxExpand),dtype=np.double)
        for i in range(self.Nray):
            x = self.Xray[i]
            for m in range(self.MaxExpand):
# TODO change following line to reccursion.
                delta_coefs[i,m] = sps.eval_legendre(m,x)*(2*m+1)
        return delta_coefs

    def gen_Legendre_mat(self):
        ME = self.MaxExpand
        LegendreMat = np.zeros((self.Nray,self.Nbar,ME+1),dtype=np.double)
        for i in range(self.Nray):
            for j in range(self.Nbar):
                arg = (self.Xray[i]-self.Xbar[j])
                LegendreMat[i,j,0] = 1.0
                LegendreMat[i,j,1] = 1.0*arg
                for m in range(2,ME):
                    LegendreMat[i,j,m] = ((2*m-1)*arg*LegendreMat[i,j,m-1]-(m-1)*LegendreMat[i,j,m-2]) / m
        return LegendreMat

    def gen_delta_mat(self):
        dmat = np.zeros((self.Nray,self.Nbar),dtype=np.double)
        for i in range(self.Nray):
            for j in range(self.Nbar):
                for m in range(self.ExpOrder):
                    dmat[i,j] += self.delta_coefs[i,m]*self.Legendre_mat[i,j,m]
                #dmat[i,j] *= math.exp(-((self.Xray[i]-self.Xbar[j])/self.sigma)**2)

        return dmat


##########################################################################################
class DAF_Hermite:
    '''
        INPUT:
        Xray - Points where the value of f is known. 
        Xbar - Points for desired values of f or its derivatives.
        M - Expansion limit, the number of Hermite polynomials used for delta(x)
        DerOrder - highest order of derivative to be calculated. 
        sigma - scaling factor for the x domain to be used to increase accuracy of delta

        OUTPUT:
        TODO 
    '''

    def __init__(self,Xray:np.array,Xbar:np.array,DerOrder=0,sigma=1.0,M=50):
        self.Xray = Xray
        self.Xbar = Xbar
        self.Nray = len(Xray)
        self.Nbar = len(Xbar)
        self.DerOrder = DerOrder
        self.sigma=1.0
        self.ExpOrder = M
        self.MaxExpand = M + DerOrder + 1

        self.Hermite_mat = self.gen_Hermite_mat()
        self.delta_coefs = self.gen_delta_coefs()
        self.delta_mat = self.gen_delta_mat()

    def gen_delta_mat(self):
        dmat = np.zeros((self.Nray,self.Nbar),dtype=np.double)
        for i in range(self.Nray):
            for j in range(self.Nbar):
                for m in range(self.ExpOrder):
                    dmat[i,j] += self.delta_coefs[m]*self.Hermite_mat[i,j,m]
                dmat[i,j] *= math.exp(-((self.Xray[i]-self.Xbar[j])/self.sigma)**2)

        return dmat

    #-----------------------------------------------------------------------------------------
    def gen_Hermite_mat(self):
        '''
        NOTES: Frequenly, Xray and Xbar are the same array, but they do not have to be. 
        This routine does makes the assumption they are not, and there is no computational
        benefit here, e.g. symmetry. I'll add options for taking advantage of 
        symmetries and periodicities in an updated version.

        Recurrance Relationships:
        H[n+1] = 2*x*H[n] - 2*n*H[n-1]
        H'[n] = 2*n*H[n-1]
        '''

        Xray = self.Xray
        Xbar = self.Xbar
        Nray = self.Nray
        Nbar = self.Nbar
        sigma = self.sigma
        ME = self.MaxExpand


        # If sigma is specified, use it, otherwise find an optimal value
        if (not sigma):
            sigma = daf_sigmaOpt.sigmaOptHermite(Xray, M)
        sigma=1.0

        # Get matrix of Hermite functions at all points up to order M
        HermiteMat = np.zeros((Nray,Nbar,ME+1),dtype=np.double)
        for i in range(Nray):
            for j in range(Nbar):
                arg = (Xray[i]-Xbar[j])/sigma
                HermiteMat[i,j,0] = 1.0
                HermiteMat[i,j,1] = 2.0*arg
                for m in range(2,ME):
                    HermiteMat[i,j,m] = 2*arg*HermiteMat[i,j,m-1]-2*(m-1)*HermiteMat[i,j,m-2]

        return HermiteMat

    #-----------------------------------------------------------------------------------------
    def gen_delta_coefs(self):

        # Recurrance: H[n+1] = 2*x*H[n] = 2*n*H[n-1]

        # NOTE This routine uses math.factorial(n) which will fail for n > 170 
        
        H=np.zeros(self.MaxExpand,dtype=np.double)
        H[0] = 1.0
        H[1] = 0.0

        # Use the recursion formula to get values of hermite polinomials at give x 
        for n in range(2,self.MaxExpand):
            H[n]=((2*0.0*H[n-1] - 2*(n-1)*H[n-2]))

        # Add the normalization factor so that int(Hn Hm W) = 1
        for n in range(0,len(H),2):
            try:
                H[n] *= (1.0/(2**n * math.factorial(n) * rtpi))
            except OverflowError:
                print("WARNING: Overflow in factorial")
                print(" Order of Hermite Polynomial Expansion is ",M)
                print(" Expansion stopped at n=",n-1)
                print(" This calculation will continue with this expansion limit.")
                break
            except:
                raise
                
            
        H = np.array(H,dtype=np.float64)  # Change to numpy data type
        return H


##########################################################################################
if (__name__ == '__main__'):

    import re
    import random
    import matplotlib.pyplot as plt
    import daf_sigmaOpt

    pass
