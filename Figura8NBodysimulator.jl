using NBodySimulator,StaticArrays,Plots #StaticArrays para optimizar la velocidad
const G = 1.0 #  Normalizada a uno 
x1,y1=-0.97000436, 0.24308753 #Parametros de https://people.ucsc.edu/~rmont/Nbdy.html
vx3,vy3 = 0.93240737, 0.86473146 #Calculados por C Simó. DOI: 10.1007/978-3-0348-8268-2_6
body1 = MassBody(SVector(x1, y1, 0.0), SVector(-vx3/2, -vy3/2, 0.0), 1.0)
body2 = MassBody(SVector(-x1,-y1, 0.0), SVector(-vx3/2, -vy3/2, 0.0), 1.0)
body3 = MassBody(SVector(0.0, 0.0, 0.0), SVector(vx3, vy3, 0.0), 1.0)
system = GravitationalSystem([body1,body2,body3], G) #Sistema de 3 cuerpos
tspan = (0.0, 10.0)
#The created objects determine the simulation we want to run:

simulation = NBodySimulation(system, tspan)
@time sim_result = run_simulation(simulation,abstol=1e-7,reltol=1e-8);

animate(sim_result, "figura8_CS.gif",fps=15) 

using DifferentialEquations #Podemos convertirlo a un problema 
prob=SecondOrderODEProblem(simulation) #de segundo orden
sol=solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8); #Resolver con un integrador
