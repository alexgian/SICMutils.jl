# numerical functions

using DataInterpolations, QuadGK, Optim

# simple integration
function definite_integral(func,from, to)  # move to numerics file
    quadgk(func, from, to, rtol=1e-10)    
end

# Linear Interpolants
function linear_interpolants(t0::Union{Rational,Int}, t1::Union{Rational,Int}, n::Int)
    sp = (t1-t0)//(n+1)
    return collect(t0+sp:sp:t1-sp)
end

function linear_interpolants(t0, t1, n::Int)
    sp = (t1-t0)/(n+1)  # 10× faster than //
    return collect(t0+sp:sp:t1-sp)
end

# LagrangeInterpolation will be needed for make-path (SICM p.22)
#= this seems marginally less accurate than scmutils, and extrapolate has to be specified:
outpoly = LagrangeInterpolation([0.0,1,2],[1,2,3]; extrapolate=true) =#
function Lagrange_interpolation_function(u,t)
    LagrangeInterpolation(u, t; extrapolate=true)
end

# ---- Minimizers -----------------------------------

# A Brent univariate minimizer
function minimize(fn_univariate, t1, t2)
    optimize(fn_univariate, t1, t2,  Brent(); abs_tol=10^-5)
end


# need a multidimensional minimizer based on Nelder-Mead
function multidimensional_minimize(path_action, initial_values)
end

