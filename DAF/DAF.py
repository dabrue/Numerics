#!/usr/bin/env python3
'''
Module providing routines for Distributed Approximating Functionals numerical methods

D. A. Brue, 2021
'''
import numpy
import scipy

class daf_Hermite:

    def __init__(self, Order, SumOrder=50, sigma=1.0):
        self.sigma = sigma
        self.SumOrder = SumOrder
        self.Order = Order

    def _gen_DAF_matrix(order,xpts,weights):
        pass
