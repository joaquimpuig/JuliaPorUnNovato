# El paquete Zygote.jl contiene funciones para la difernciación
# automática de funciones usando el propio código de la función,
# esto es sin tener que declarar variables simbólicas. Se consigue
# mediante la aplicación de la regla de la cadena a nivel interno.
using Zygote
#Podemos definir una función y calcular su derivada sencillamente
f(x)=cos(x)
f(pi), f'(pi),f''(pi)
#Podemos usar funciones de varias variables
suma(n) =  n > 1 ? suma(n-1) + n : n
#o definidas más implícitamente
grec(x)= x > 1 ?  grec(x/2) : x
using Plots,PlotThemes
theme(:dark)
p1=plot(grec,xlims=[0,32],label="Función")
plot(p1,grec',xlims=[0,32], label="Derivada")



#También podemos definir funciones de más variables
#Vectores y por tanto gradientes
gradient(x->sum(x),[1 1 1 1])
#y la matriz jacobiana
jacobian(x->x^2,randn((4,4)))


