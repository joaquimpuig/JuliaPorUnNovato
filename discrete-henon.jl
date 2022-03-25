#iteración simple con asignación
function henon_map(u,p=Float64[1.4,0.3],t=0)
    x,y= u
    a,b= p
    return [1-a*x^2+y,b*x]
end
Nmax=1e8
u=u0=Float64[1,1]
#iteración simple con método de retorno
@time for k in range(1,Nmax)
    u=henon_map(u)
end 

# La función inplace se disingue por el !
function henon_map!(u1,u,p=Float64[1.4,0.3],t=0)
    x,y= u
    a,b= p
    u1[1]=1-a*x^2+y
    u1[2]= b*x
    nothing
end
u=u0 #iteración simple con método inplace
@time for k in range(1,Nmax)
    henon_map!(u,u)
end 


# vemos que el tiempo de ejecución es superior en el caso
# de funciones out of place en que se retorna un valor
using Plots
scatter((u[1],u[2]),markersize=1,color="red",legend=false)
Nmax=1e3
#iteración simple con método inplace
u=u0
theme(:dark)
plot()
anim= @gif for k in range(1,Nmax)
    henon_map!(u,u)
    scatter!((u[1],u[2]),   markersize=2,alpha=0.5,
        color="red",
        legend=false,xlims = (-1, 1.4), ylims = (-0.4, 0.4))
    henon_map!(u,u)
    scatter!((u[1],u[2]),   markersize=2,alpha=0.5,
        color="white",
        legend=false,xlims = (-1, 1.4), ylims = (-0.4, 0.4))
        henon_map!(u,u)
    scatter!((u[1],u[2]),   markersize=2,alpha=0.5,
        color="green",
        legend=false,xlims = (-1, 1.4), ylims = (-0.4, 0.4))
end every 10


# También podemos usar el paquete DifferentialEquations
# que permite estudiar sistemas discretos
using DifferentialEquations,Plots
tspan = (0.0,1e4)   # Tiempo de Integración
# Definimos el problema como un problema discreto 
# permitido por el paquete DifferentialEquations.jl
prob = DiscreteProblem(henon_map!,u0,tspan,Float64[1.4,0.3])
#Lo resolvemos mediante los métodos estándar
@time sol = solve(prob)


#Vamos a encontrar los puntos fijos
using NLsolve
#la instruccion contiene los puntos fijos
my_fp=fixedpoint(henon_map!,Float64[1,1])
u=my_fp.zero
# Lo dibujamos
#Dibujamos la solución para ver que funciona
G1=scatter(sol[100:end],
    vars=(1,2),
    markersize=1,
    alpha=0.3,
    legend=false)
G2=scatter!((u[1],u[2]),markersize=5,
    markers=:d)

