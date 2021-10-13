library("JuliaCall") #Esta librería nos permite llamar Julia desde R
#En mi caso le quiero especificar la versión de Julia que estoy usando
julia_setup(JULIA_HOME="/home/jpuig/usrlocal/julia-1.6.0/bin")
julia_library("Distributions") #Usamos un paquete en Julia

Num_sim=julia_eval("10^6") #Ahora Num_sim esta en Julia

julia_assign("Num_sim",Num_sim) # Ahora Num_sim esta en R
Sim=julia_eval("[rand(Poisson(10)) for k in 1:Num_sim]")
hist(Sim) # Usando el base graphics. También ggplot etc...
