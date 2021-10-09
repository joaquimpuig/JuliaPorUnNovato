using Plots, DifferentialEquations, LinearAlgebra
function mathieu_trace(a,b) 
    A0=zeros(2,2);A0[1,2]=1     # La matriz del sistema 
    A1=zeros(2,2); A1[2,1]=1    # será A0-p(t)A1
    u = Matrix(I, 2, 2)         # condicion inicial Id 
    f(u,p,t) = (A0-p(t)*A1)*u   # Definimos la EDO 
    # Pasamos una función anónima p que depende de a,b 
    prob = ODEProblem(f,u,(0,2*pi),t -> (a+b*cos(t)))
    sol = solve(prob,save_everystep=false) # Valor en 2pi
    tr(sol.u[2]) # Calculamos la traza de la matriz sol
end
pyplot()                        # Pyplot es un backend 
a=0:0.01:10; b=0:0.01:10        # 0.01->0.1 para pruevas
plot(a,b,mathieu_trace,st=:contour,
    levels=[-2,2],fill = true,colorbar_entry=false)
