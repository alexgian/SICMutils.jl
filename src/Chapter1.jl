# Lagrangians, associated actions and procedures
# from Chapter1, SICM
# ==============================================

include("numerics.jl")

Γ(q) = t -> UpTuple([t, q(t), D(q)(t)])

function Lagrangian_action(Lagrangian, q, t1, t2) ::Real # on a path q
    first(definite_integral(Lagrangian∘(Γ(q)), t1, t2))
end

# ------ SICM paths for Lagrangians -------------

#  Paths of minimum action:
#  ν - a sufficiently well-behaved function (perhaps tuple)
#  η - the function made from ν that is 0 at the end-points
#  ε - real scaling parameter of η. 

# make η from ν (p.21)
function make_η(ν, t1, t2)
    t -> (t - t1) * (t - t2) * ν(t)
end



function varied_Lagrangian_action(L, q, ν, t1, t2)
    function(ϵ)
        η =  make_η(ν, t1, t2)
         # NEEDS WORK for first example (addition of Tuples) passed to  Γ 
        # varied_path = (q + (ϵ*η)) 
        ## little cludge to make it work... passes problem upstream
        ## now no method matching *(::Differential, ::UpTuple)
        varied_path = t -> (q(t) + (ϵ*η)(t)) 
        Lagrangian_action(L, varied_path, t1, t2) 
    end
end

# The parametric path functions: (SICM p.22)
function make_path(t0, q0, t1, q1, qs::Vector)
    n = length(qs)
    ts = linear_interpolants(t0, t1, n)
    return Lagrange_interpolation_function(
        vcat(q0,qs,q1),
        vcat(t0,ts,t1))
end

function parametric_path_action(Lagrangian, t0, q0, t1, q1) ::Real
    function(qs::Vector)
        path = make_path(t0, q0, t1, q1, qs) # this a polynomial by Lagrange interpolation
        return Lagrangian_action(Lagrangian, path, t0, t1) # action on this path
    end
end

# find the path of least action by minimizing the path action
function find_path(Lagrangian, t0 ,q0, t1, q1, n::Int)
    initial_qs = linear_interpolants(q0, q1, n)
    minimizing_qs = multidimensional_minimize(
        parametric_path_action(Lagrangian, t0, q0, t1, q1),
        initial_qs)
    make_path(t0, q0, t1, q1, minimizing_qs)
end
# also, inject graphing facitlity somewhere into the above, as per book, Exc. 1.5

# ------------------------------------------
#  THE EULER LAGRANGE EQUATIONS 


Lagrange_Equations(L) = q -> D(∂(3)(L)∘Γ(q)) - ∂(2)(L)∘Γ(q)


# Some common Lagrangians collected here ------------------------------------------------------------

function L_free_particle(mass)
    function(local_tuple::UpTuple)
        _,_,qdot = local_tuple.data
        return (mass/2)*square(qdot) # use square rather than ^2 for tuples for now ***AG*** 9/5
    end
end

function L_harmonic(mass, k)
    function (local_tuple::UpTuple)  # GJS
        _,q,qdot = local_tuple.data
#        return mass*square(qdot)/2 - k*square(q)/2
        return mass*(qdot)^2/2 - k*q^2/2   # note discrepancy, square can't be used for symbolics ***AG*** 9/5
        # when I used square(qdot) I think it tried to subtract a function from a symbol
        # in general, symbolic interface needs review
    end
end

function L_ha1(local_tuple::UpTuple) # Protter
    _,q,qdot = local_tuple.data
    (0.5m)*qdot^2 - (0.5*ω^2)*q^2
end