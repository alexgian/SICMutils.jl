using Symbolics, Optim
import Optim: optimize


# this "test" was just what showed the bug in early emmy Brent
# Brent here OK

ellipse(t) = [6*cos(t), 3*sin(t)]

function dist_from(pt, func)
    t -> norm(pt-func(t))
end

# BOO - where's eps() ??????
sqrt_machine_eps = sqrt(2.220446049250313e-16)

function constrain_fp(pt)
    res = optimize(dist_from(pt,ellipse), 0, 2*pi,  
                   Brent(); rel_tol=10^-5, abs_tol=sqrt_machine_eps)         
    ellipse(res.minimizer)    
end
