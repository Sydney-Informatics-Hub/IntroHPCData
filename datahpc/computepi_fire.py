#!/bin/python
'''
Determines an estimate for PI using multiprocessing.
Usage:
python computepi_fire.py 10000 20000 30000
'''

import numpy.random as rng
import time
import sys
from multiprocessing import Pool

def pi_run(num_trials):
    """Calculate pi based on points with a box and circle of radius 1
    """
    r = 1.0
    r2 = r * r
    Ncirc = 0
    for _ in range(num_trials):
        x = rng.random()
        y = rng.random()
        if ( x**2 + y**2 < r2 ):
            Ncirc +=1
    pi = 4.0 * ( float(Ncirc) / float(num_trials) )
    return pi

def cycle_pi(trials, noprocs=1):
    """calculate pi based on a set of trials.
    -- trials: a large number representing points
    -- noprocs: number of python processes used in simulation
    """
    with Pool(noprocs) as pool:
        pi_estimates = pool.map(pi_run,trials)

    return pi_estimates

if __name__ == "__main__":

    trials = list(map(int,sys.argv[1:]))
    print("estimating pi based on",trials)
    print(cycle_pi(trials))
