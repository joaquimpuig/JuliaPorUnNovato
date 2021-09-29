using DifferentialEquations
using Plots
# Función definida en línea
f(x,p,t) = x*(1-x)
# Intervalo donde vamos a resolver
tspan = (0.0,10)
# Definimos el problema x'=f(x)
prob = ODEProblem(f,0.01,tspan)
# Se resuelve con las opciones por defecto
sol= solve(prob)
# Al ser la solución una función el dibujo interpola valores
plot(sol,label="Solución (interpolada)",
    title="EDO logística",ylabel="x")
# Si queremos ver los puntos donde se calcula la solución 
scatter!(sol.t,sol.u,
    label="Solución (valores calculados)",legend=:bottomright)
# Para calcular la solución en unos puntos concretos
sol1= solve(prob,saveat=0:2:10)
# Como antes ! es para modificar el primer plot.
scatter!(sol1.t,sol1.u,
    label="Solución (valores especificados)",legend=:bottomright)
