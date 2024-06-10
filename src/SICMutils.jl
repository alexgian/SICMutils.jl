# SICMutils.jl

# Load correct packages (from Projects.toml)
cd(@__DIR__)
using Pkg 
Pkg.activate("..")

# module SICMutils

using DataStructures, SpecialFunctions
using LinearAlgebra
using DiffRules, Match
using Lazy: @>
# --- Ours ---
# using Plots # do not put im module 

include("types.jl")
include("Utils.jl")
include("SymbolicAlgebra.jl")
include("Simplification.jl")
include("Calculus.jl")
include("FunctionAlgebra.jl")
include("Structure.jl")
include("LaTeX.jl")
# --- Ours -------
include("Chapter1.jl")

export Sym, SymExpr, AbstractSym, AbstractSymExpr, @sym, Symbolic, D, ∂, simplify
export UpTuple, DownTuple, up, down, square

#end #module
# SICMutils.jl:1 ends here


# ===========  SICM Chapter 1

# prolegomena --------
println("\nTests from SICM, Chapter 1\n")
test_path(t) = UpTuple([4t+7, 3t+5, 2t+1])
#test_path = up([t->4t+7, t->3t+5, t->2t+1])

# ----- test ------------
println("Lagrangian action of free particle on given test path...")
out = Lagrangian_action(L_free_particle(3.0),test_path, 0, 10) ;
println("Result is:  ", out, "\n")
# => 435.0

println("Calculating action of free paricle on the varied path...")
println("Some work still nedded here :(\n")
# needs work to tuple (Structure) addtition
# -----------------------------------------

function varied_free_particle_action(mass, q, ν, t1, t2)
    varied_Lagrangian_action(L_free_particle(mass), q, ν, t1, t2)
end

#       varied_free_particle_action(3, test_path, up([sin, cos, square]), 0, 10) 
# out = varied_free_particle_action(3, test_path, up([sin, cos, square]), 0, 10)(0.01)
#  println("***",out)
  
#minimize(varied_free_particle_action(3, test_path, up([sin, cos, square]), 0, 10)(-2.0 1.0))
# paths and their optimization --------------------------------


# --- symbolic tests -------------
@sym m ω t x

println("Solving Lagrange Equations for L-harmonic symbolically...")
println("Given:    > Lagrange_Equations(L_harmonic(m, ω^2))(x)(t)")
out = Lagrange_Equations(L_harmonic(m, ω^2))(x)(t) ;
println("Result is:  ", out, "\n")
# => (D(D(x)))(t) * m + x(t) * ω ^ 2


println("Done...")





