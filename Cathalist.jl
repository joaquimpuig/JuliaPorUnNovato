
using Catalyst
modelo_SIR = @reaction_network begin
  β, S+I --> 2I
  γ,I --> R
end β γ;

using Latexify
# Podemos convertir el modelo
# Como esquema LaTeX
latexify(modelo_SIR)

# También se puede generar un grafo de la reacción
g = Graph(modelo_SIR)

odesys = convert(ODESystem, modelo_SIR)

summary(odesys)

species(modelo_SIR)

#Version ODE
using DifferentialEquations,Plots
# parametros
p = (0.001,0.25)
# condiciones iniciales
u₀ = [990,10,0]
# Eviamos las CI y parámetros directamente como un map
u₀map = species(modelo_SIR) .=> u₀ #Pasamos las ci directamente
pmap  = parameters(modelo_SIR) .=> p #idem con parametros
# Podemos resolver la EDO con estos datos
oprob = ODEProblem(modelo_SIR, u₀map, (0.,30.), pmap)
sol_EDO = solve(oprob, Tsit5())
plot(sol_EDO,xaxis="Tiempo (t)",yaxis="Población",tit)

#Modelo estocástico a partir de procesos de salto tipo Poisson
# Creamos un problema discreto  a partir del continuo:
dprob = DiscreteProblem(modelo_SIR, u₀map, (0.,30.,), pmap)
# Creamos un proceso de saltos que resolveremos 
# mediante el método directo de Gillespie
jprob = JumpProblem(modelo_SIR, dprob, Direct())
# Se resuelve:
sol_SJP = solve(jprob, SSAStepper())
# Se dibuja
plot(sol_SJP)

# EDO estocástica con ruido aditivo
sprob = SDEProblem(modelo_SIR, species(modelo_SIR) .=> u₀, (0.,30.0), parameters(modelo_SIR) .=> p)
# y resolverlo mediante los métodos implementados 
sol_SDE = solve(sprob, LambaEM(), tstops=range(0., step=4e-3, length=1001))
plot(sol_SDE)

l = @layout [a ; b; c]
p1 = plot(sol_EDO,title="EDO")
p2 = plot(sol_SDE,title="SJP")
p3 = plot(sol_SJP,title="SDE")
plot(p1, p2, p3,layout=l,xaxis="Tiempo (t)",yaxis="Población")





