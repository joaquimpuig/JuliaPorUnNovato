using DifferentialEquations,Plots
# Definimos la función del campo. El símbolo !
# Significa que los argumentos cambian. Es lo 
# que se llama 'in-place'
function parameterized_lorenz!(du,u,p,t)
    x,y,z = u
    σ,ρ,β = p
    du[1] = dx = σ*(y-x)
    du[2] = dy = x*(ρ-z) - y
    du[3] = dz = x*y - β*z
end
u0 = [1.0,1.0,1.0] # Condiciones Iniciales
tspan = (0.0,20)   # Tiempo de Integración
p = [10.0,28.0,8/3] #Valores de los parámetros
#Definimos el problema de EDOs
prob = ODEProblem(parameterized_lorenz!,u0,tspan,p)
#Lo resolvemos mediante los métodos estándar
sol = solve(prob)
#Dibujamos la solución para ver que funciona
plot(sol,vars=(0,2))

#Vamos a hacer una simulación de varios valores 
#con ci parecidas pero modificándolas ligeramente
function prob_func(prob,i,repeat)
    #La siguiente macro modifica la ci del problema
    #añadiéndile una 
    @. prob.u0 = prob.u0+randn()*1e-2
    prob
end
#Generamos el problema conjunto a través del problema que
#queramos estudiar (prob), que puede ser de una EDO o cualquier
#otro soportado por DifferentialEquations.jl y la función que 
#usaremos para modificar el problema en cada llamada de la simulación
#Es posible usar paralelismo (lo veremos en otro post)
ensemble_prob = EnsembleProblem(prob,prob_func=prob_func)
#Generamos la simulación de 100 trayectorias en este caso
sim = solve(ensemble_prob,trajectories=100)
plot(sim,vars=(1,3),linealpha=0.1)
#Vamos  a analizar las soluciones, nos fijaremos en la evolución
#de la primera componente y su evolución a través del Tiempo
plot(sim,vars=(0,1),linealpha=0.1)
#Podemos generar estadísticas del conjunto de soluciones,
#Como por ejemplo la media y ciertos percentiles
summ= EnsembleSummary(sim;quantiles=[0.05,0.95])
#idx=1 indica que dibujaremos la primera componente.
plot(summ,idxs=1,fillalpha=0.2,ylims=(-20,20),background_color = RGB(0.2, 0.2, 0.2))
#y generamos una animación añadiendo las líneas
@gif for i in 1:100
    plot(summ,idxs=1,fillalpha=0.2,xlims=(0,20),ylims=(-20,20),background_color = RGB(0.2, 0.2, 0.2))
    plot!(sim[i],vars=(0,1),linealpha=0.4,linecolor="white")
end every 1
