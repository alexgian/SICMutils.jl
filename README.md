SICMutils.jl

SICMutils for julia
====================

This is based on a clone of Mason Protter's initial [nice attempt](https://github.com/MasonProtter/Symbolics.jl) at ***scmutils*** for Julia.  
*scmutils* is Gerald Jay Sussman's Scheme language utility supporting his own research but - more relevantly - it is also the computer system behind two computer-based educational texts, [*Structure and Interpretation of Classical Mechanics*](https://mitpress.mit.edu/9780262028967/structure-and-interpretation-of-classical-mechanics/) and [*Functional Differential Geometry*](https://mitpress.mit.edu/9780262019347/functional-differential-geometry/).   

Protter states he was inspired to create this after watching [Colin Smith's Physics in Clojure video of 2017](https://www.youtube.com/watch?v=7PoajCqNKpg).  Colin was one of the first to attempt a port of the system, liberating it from the effective, but not too portable MIT-Scheme used by GJS.  Initially, Protter called it Symbolics.jl, which is  not a particularly good name,  especially as "Symbolics" is now the name of the major Julia library for symbolic processing, so I have renamed it to *SICMutils* in line with Colin's earlier work.

Incidentally, Colin's work has now evolved into the Clojure/Clojurescript open-source CAS called [***"Emmy"***](https://github.com/mentat-collective/emmy), in honour of the remarkable Emmy Noether, crafted by Sam Ritchie and if you want to work with either of the two above-mentioned books, or with a good *functional* Computer Algebra library, then I recommend it highly!

↑ *IF YOU WANT TO TRY IT OUT, THAT IS THE SYSTEM TO USE* ↑

It also comes with a bevy of great interactive graphics utilities for mathematical visualizations and demonstrations, accessible through a web browser and of course all the benefits of running within the JVM ecosystem.  

GJS's original, *scmutils* is also freely available for experimentation, but it is not as flexible, especially in its provision of graphics.  It is, however, a quick and accessible way into the system for those that may not want to commit to a JVM-based installation, since it runs natively on Linux-type systems, and something like *emacs* is more than adequate for a development environment.

The point is that the ideas found in *scmutils* comprise a very particular approach to the teaching of the physical sciences, viz. the possibility of testing any model as executablecode, and so eliminating ambiguities, or "hand-waving" explanations.  As Sam points out, the code becomes the API into the science.

Based on GJS's ideas <link>, *scmutils* should be fairly easily ported - or at least adapted - into any reasonable functional language: it is a way of thinking and a way of working, and not something tied to any particular computer language.  Unfortunately, to date, this has not happened so much, not even in Scheme-derived languages which stake their claims in the educational world.

It is interesting to see that the system has potential to be ported to Julia.
In particular julia's speed and panoply of tested numerical routines would serve it well.

===
(issues)

The code in this implementation is now quite old, and could benefit from an update.
On the other hand, the important parts of it work and provide a proof of concept.

So far, the system is based Mason Protter's own implementation of symbolical computing and does not use the julia's current Symbolics system, which may have not been as established at that time, though they are very similar.  In any case julia's own Symbolics system claims to use symbolic routines from *scmutils*, so one of the short term aims of this software is to integrate it with the established julia idiom.

Another interesting area is Sussman's use of so-called up and down structures to represent vectors, corresponding to their two forms, contravariant and covariant.  This code is highly recursive in its structure, something which - unlike in Lisp - is avoided in Julia, because of speed concerns.  At the moment there is a rudimentary working (i.e. buggy and incomplete) implementation, which needs quite some improvement, while a nice balance of elegance and speed is sought out.

Automatic Differentiation is a key element of *scmutils*, and Julia has several options available here, many of them based on current research, which could be co-opted gainfully.

=====

Running it - Main file is `SICMutils.jl`, run this as starting point in the REPL.

=====

I have not done much to the system so far - just repackaged it so that an elementary demonstration is feasible.  A file called numerics.jl has been added, which brings in various numerical routines that are needed (integration, interpolation, minimization), mapped out to their equivalents in *scmutils*.  An attempt was made to port the early exercises in Chapter 1 of SICM, but this fell down fairly quickly as problems of function/up-down structure compatibility appeared.  Not too awful, but will need to be addressed.

However, the main point of this chapter, the deriving the Equations of Motion from the Lagrangian, equations works fine and can be seen when the main file (SICMutils.jl) is run in the REPL.

Solving Lagrange Equations for L-harmonic symbolically... 
Given:    
```julia
> Lagrange_Equations(L_harmonic(m, ω^2))(x)(t)
```

Result is:  
```julia
(D(D(x)))(t) * m + x(t) * ω ^ 2
```

Some simple code examples given in the original can be seen [here:](./README_old.md)

While some issues with the program, including differentiation of symbolic expression and up/down vectors are briefly described here. <link>

To ensure program reproducability use the julia libraries at the versions provided, in particular `Match @v1.0.1`
Do not upgrade the libraries in Project.toml unless you are acively developing the program.
See [REQUIREMENTS](./REQUIREMENTS)

====


