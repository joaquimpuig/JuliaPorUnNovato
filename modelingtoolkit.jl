using ModelingToolkit #Paquete para modelización Simbólica-Numérica
@variables t S(t) I(t) N(t) #Variables que dependen de t
@parameters  β γ μ #Parámetros
D = Differential(t) #Operador derivada. Nuestro modelo será una ODE
eq_SI = [N ~ S+I,                #N(t)=S(t)+I(t) poblacion total
    D(S) ~ μ*N-β*S*I/N-μ*S+γ*I,  #S'= ... edo para S
    D(I) ~ β*S*I/N-(μ+γ)*I]      #I'= ... edo para I
@named SI_model=ODESystem(eq_SI) #@named es ncesaria

#El uso del paquete simbolico permite simplificar la N
SI_model_simp=structural_simplify(SI_model) 

using DifferentialEquations, Plots #Para integrar y dibujar
prob = ODEProblem(SI_model_simp,   #Definimos el problema
    [S => 30.0, I=>1.0],           #Condiciones iniciales
    (0.0,100.0),                   #Tiempo de integración
    [β=> 0.8 γ=>0.05 μ => 0.01])   #Valor de los parámetros
plot(solve(prob), vars=[S,I,N])    #Integramos y dibujamos
