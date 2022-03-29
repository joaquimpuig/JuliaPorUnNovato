using Symbolics   #Paquete simbólico
@variables x      #Variable simbolica
D=Differential(x) #Operador derivación resp. x
f(t)=sin(t^2+t^4) #Función. No es necesario en simb.
# El resultado no se expande por defecto
der=D(f(x))       #Differential(x)(sin(x^2 + x^4))
# Se puede expandir el resultado 
eder=expand_derivatives(der)
#(2x + 4(x^3))*cos(x^2 + x^4)
using Latexify    #Paquete para generar output en TeX
latexify(eder)
#Resultado como String Literal 
#L"\begin{equation}
#\left( 2 x + 4 x^{3} \right) \cos\left( x^{2} + x^{4} \right)
#\end{equation}
#"
println(latexify(eder)) #Ideal para corta y pega
#\begin{equation}
#\left( 2 x + 4 x^{3} \right) \cos\left( x^{2} + x^{4} \right)
#\end{equation}

using SymPy #Puede tener conflictos con Sybmolics
@vars x
diff(f(x),x)
#Disponemos de integrador simbólico
I=integrate(1/(1+x^2)^3,x)
println(latexify(I))
#$\frac{3 \cdot x^{3} + 5 \cdot x}{8 \cdot x^{4} ...
#...+ 16 \cdot x^{2} + 8} + ...
#... \frac{3 \cdot \arctan\left( x \right)}{8}$
