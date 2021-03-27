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

'''
LdeltaC_part = np.zeros(MaxLaguerreExpansion, dtype=np.float64)
for i in range(0,MaxLaguerreExpansion,2):
    LdeltaCoef_part[i] = sps.eval_laguerre(i,0.0)/

TdeltaC = np.zeros(MaxLaguerreExpansion, dtype=np.float64)

PdeltaC = np.zeros(MaxLaguerreExpansion, dtype=np.float64)
for i in range(0,MaxLegendreExpansion,2):
    PdeltaC[i] = sps.eval_legendre(i,0.0) * (2*i + 1) / 2
'''

##########################################################################################
# SUBROUTINES FOR DAF GENERATION, INTERNAL USE INTENDED

#-----------------------------------------------------------------------------------------
def _exp_Hermite_delta(x,sigma,M):

    # Recurrance: H[n+1] = 2*x*H[n] = 2*n*H[n-1]

    # NOTE This routine uses math.factorial(n) which will fail for n > 170 
    
    xs = x/sigma  # The argument for the expansion is x/sigma
    H=[]
    H.append(1.0)
    H.append(xs)

    # Use the recursion formula to get values of hermite polinomials at give x 
    for n in range(2,M+1):
        H.append( (2*xs*H[-1] - 2*(n-2)*H[-2]) )

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
            
        
    H = np.array(H)  # Change to numpy data type
    return H

#-----------------------------------------------------------------------------------------
def _gen_Legendre_delta(x,M):

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
def _gen_Laguerre_delta(x,M):

    # Recurrance: (n+1)L[n+1] = (2*n+1-x)L[n] - n*L[n-1]
    L=[]
    L.append(1.0)
    L.append(-x+1.0)
    for n in range(2,M+1):
        L.append((1/n)*( (2*n -1 - x)*L[-1] - (n-1)*L[-2]))
    L=np.array(L)
    return L

#-----------------------------------------------------------------------------------------
def _gen_ChebyT_delta(x,M):

    # Recurrance: T[n+1] = 2*x*T[n] - T[n-1]

    T=[]
    T.append(1.0)
    T.append(x)
    for n in range(2,M+1):
        T.append(2*x*T[-1] - T[-2])
    T=np.array(T)
    return T

##########################################################################################
# MAIN ROUTINES FOR GENERATING DAF MATRICES

# NOTE: The matrix generation routines are excellent candidates for parallelization. 

#-----------------------------------------------------------------------------------------
def gen_Hermite(Xray, Xbar, M, DerOrder, sigma = None):
    '''
    This routine generates the DAF matrices using a Hermite Polynomial basis. 

    INPUT:
    Xray - Points where the value of f is known. 
    Xbar - Points for desired values of f or its derivatives.
    M - Expansion limit, the number of Hermite polynomials used for delta(x)
    DerOrder - highest order of derivative to be calculated. 
    sigma - scaling factor for the x domain to be used to increase accuracy of delta

    OUTPUT:
    HDAF - list of np matrices. The index of the list corresponds to derivative order

    NOTES: Frequenly, Xray and Xbar are the same array, but they do not have to be. 
    This routine does makes the assumption they are not, and there is no computational
    benefit here, e.g. symmetry. I'll add options for taking advantage of 
    symmetries and periodicities in an updated version.
    '''

    # If sigma is specified, use it, otherwise find an optimal value
    if (not sigma):
        sigma = daf_sigmaOpt.sigmaOptHermite(Xray, M)
    sigma=1.0

    # get the expansion coefficients
    x = 0.0  # Hermite coefficients depend on H_n(0) terms, so get those from recursion.
    HC = _exp_Hermite_delta(s, sigma, M)
    return(np.array((1,1),dtype=np.float64))

#-----------------------------------------------------------------------------------------
def gen_Legendre(Xray, M, DerOrder):
    pass

#-----------------------------------------------------------------------------------------
def gen_Laguerre(Xray, M, DerOrder, sigma = None):
    pass
#-----------------------------------------------------------------------------------------
def gen_Chebyshev(Xray, M, DerOrder, sigma = None):
    pass



class DAF:

    def __init__(self,PolyBase:str,Xray:np.array,DerOrder=0,sigma=1.0,M=50):
        self.PolyBase = PolyBase
        self.Xray = Xray
        self.DerOrder = DerOrder
        self.sigma=1.0
        self.ExpOrder = M           
        if (PolyBase == 'hermite'):
            self.DAFMAT = gen_Hermite(Xray, M, sigma)
        elif (PolyBase == 'legendre'):
            self.DAFMAT = gen_Legendre(Xray, M)
        elif (PolyBase == 'laguerre'):
            self.DAFMAT = gen_Laguerre(Xray, M, sigma)
        elif (PolyBase == 'chebyshev'):
            self.DAFMAT = gen_Chebyshev(Xray, M)
        else:
            raise('ERROR: Unidentified Polynomial Expansion : ', PolyBase)
            exit()

##########################################################################################
if (__name__ == '__main__'):

    import re
    import random
    import matplotlib.pyplot as plt
    import daf_sigmaOpt

    pass
