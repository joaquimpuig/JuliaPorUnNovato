using DifferentialEquations #Para integrar la EDO
using LinearAlgebra #Para usar la identidad
using Plots #Para plot
# Taken from DifferentialEquations documentation
# Definimos una matriz 4x4
A  = [1. 0  0 -5
      4 -2  4 -3
     -4  0  0  1
      5 -2  2  3]
# Acepta unicode! \Phi+TAB. Condicion inicial
Φ = Matrix(I, 4, 4) 
# Definir un intervalo de tiempo. 
tspan = (0.0,1.0)
# Definimos la EDO 
f(Φ,p,t) = A*Φ
# Hay muchas mas opciones
prob = ODEProblem(f,Φ,tspan)
sol = solve(prob)
plot(sol)
