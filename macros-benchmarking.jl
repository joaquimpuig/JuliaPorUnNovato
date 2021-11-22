# Es posible hacer macros en @JuliaLanguage como parte de la "metaprogramación".
# Las macros llevan una arroba delante, como @btime para el tiempo de ejecución.
# Para comparar diferentes rutinas, el paquete BenchmarkTools.jl permite comparar 
# tiempos de ejecución. Más información sobre meta-progamación 
# https://docs.julialang.org/en/v1/manual/metaprogramming/

#bloque 1
funcion1(x) = [cos(x) for x in x] #usamos list comprehension
funcion2(x) = map(t-> cos(t),x)   #docs.julialang.org/en/v1/manual/functions/
funcion3(x) = cos.(x) # vectorizacion mediante punto "dot vectorization"
x=rand(10^7);
funcion1(x)==funcion2(x)==funcion3(x) #Dan lo mismo

#bloque 2
@time funcion1(x); #Macro por defecto de Julia para el tiempo de ejecución

#bloque 3
using BenchmarkTools #El paquete permite generar una suite de pruebas
@benchmark funcion1(x) 

#bloque 4
t1=@benchmark funcion1(x); #Generamos un trial para cada uno
t2=@benchmark funcion2(x); #Ver el manual para muchas opciones
t3=@benchmark funcion3(x); # https://juliaci.github.io/BenchmarkTools.jl
using BenchmarkPlots, StatsPlots #Esto es solo para dibujar
plot(t1); plot!(t2); plot!(t3) #Nos hará un violin plot
