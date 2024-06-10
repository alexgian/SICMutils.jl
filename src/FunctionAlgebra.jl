# FunctionAlgebra.jl

# simples
square(n::Number) = n*n

# [[file:~/Documents/Julia/scrap.org::*FunctionAlgebra.jl][FunctionAlgebra.jl:1]]
function Base.:+(f1::Union{Function,Operator}, f2::Union{Function,Operator})
    if f1 == f2
	t -> 2*f1(t)
    else
	t -> f1(t) + f2(t)
    end
end

Base.:+(a::Number, f::Union{Function,Operator}) = t -> a + f(t)
Base.:+(f::Union{Function,Operator}, a::Number) = t -> f(t) + a

#_____________________________________________
# Subtraction
function Base.:-(f1::Union{Function,Operator}, f2::Union{Function,Operator})
    if f1 == f2
	function (t)
	    0
	end
    else
	function (t)
	    f1(t) - f2(t)
	end
    end
end

Base.:-(a::Number, f::Union{Function,Operator}) = t -> a - f(t)
Base.:-(f::Union{Function,Operator}, a::Number) = t -> f(t) - a

# unary ***AG*** added 8/5/24   , stil failing for Differential
Base.:-(f::Union{Function,Operator}) = t -> -f(t)

#_____________________________________________
# Multiplication
Base.:*(a::Number, f::Union{Function,Operator}) = t -> a*f(t)
Base.:*(f::Union{Function,Operator}, a::Number) = *(a, f)

function Base.:*(f1::Function, f2::Function)
    if f1 == f2
        t -> f1(t)*f1(t)
    else
        t -> f1(t)*f2(t)
    end
end

function Base.:*(f1::Operator, f2::Operator)
    # t -> (f1(f2))(t) 
    t -> (f1 ∘ f2)(t) # ***AG** 8/5/24 ; prolly don't improve it much, -Diff is the issue
end

function Base.:*(s::Number, t::T where T<:Structure)
    vect = s .* t.data
    if typeof(t)==UpTuple
        return UpTuple(vect)
    else
        return DownTuple(vect) # get some proper id!
    end
end

#_____________________________________________
# Division

function Base.:/(f1::Function, f2::Function)
    if f1 == f2
	t -> 1
    else
	t -> f1(t)/f2(t)
    end
end

Base.:/(a::Number, f::Function) = t -> a/f(t)
Base.:/(f::Function, a::Number) = t -> f(t)/a

#_____________________________________________
# Exponents

# NB. Produces error on D^3 and above: no method matching -(::Differential) AG (anywhere where there is a -ve returnval)
function Base.:^(a::Operator, b::Integer)
    function (t)
        # foldl((x,y)->a(x),1:b,init=t)
        foldl((x,y)->a(x),1:b,init=t)
    end
end

# ***AG*** 8/5/24
function Base.:^(f::Function, n::Integer)
    function (t)
        if n==0 return 1 # ?? 1 | t | error?
        elseif n==1 return f(t)
        else return (*(ntuple(_->f,n)...))(t)  # could've used a fold, too
        end
    end
end

# FunctionAlgebra.jl:1 ends here

# this doesn't help # find something else ***AG** 9/5/24
function square(a::Differential) t -> a(t) * a(t) end