attach("Tfunctions.sage")
G=load('Case1F')        # Loading graphs from arcticle
V=[]
G[0].delete_vertices([6,7,8])
V.append([0,1,2,3,4])
G[1].delete_vertices([8,10,11])
V.append([0,2,3])
G[2].delete_vertices([6,11])    
V.append([0,1,2,3,4])
G[3].delete_vertices([10,11])  
V.append([0,1,2,3,4])
G[4].delete_vertices([8])
V.append([0,2,1]) 
G[5].delete_vertices([6])   
V.append([0,1,2,3,4])       
G[6].delete_vertices([6,7])
V.append([0,1,2,3,4])
V.append([0,1,2,3,4])  
G[8].delete_vertices([6])
V.append([0,1,2,3,4])   
G[9].delete_vertices([6,7])
V.append([0,1,2,3,4])
K=[[G[0],V[0]],[G[1],V[1]],[G[2],V[2]],[G[3],V[3]],[G[4],V[4]],[G[5],V[5]],[G[6],V[6]],[G[7],V[7]],[G[8],V[8]],[G[9],V[9]]]
i=0

for L in K:
    G=L[0]
    Feasible=L[1]
    i=i+1
    print(i)
    save(i,'Uzaver2Ai.sobj')
    F,NonF=New_vertex_feasible(G,Feasible)
    FP2,NP2=Add_P2(G,F,NonF)
    FP3=Longer_path(NonF,FP2,True)
    NP3=Longer_path(NonF,NP2,False)
    FP4=Longer_path(NonF,FP3,True)
    NP4=Longer_path(NonF,NP3,False)
    FP5=Longer_path(NonF,FP4,True)
    T0 =Add_T0(NP2)
    FT1=Add_T(NonF,FP2,Feasible,True)
    NT1=Add_T(NonF,NP2,Feasible,False)
    FT2=Add_T(NonF,FP3,Feasible,True)
    NT2=Add_T(NonF,NP3,Feasible,False)
    FT3=Add_T(NonF,FP4,Feasible,True)
    NT3=Add_T(NonF,NP4,Feasible,False)
    FT4=Add_T(NonF,FP5,Feasible,True)
    NT1NT1=CombinationT(NT1,NT1,False)
    NT1FT2=CombinationT(NT1,FT2,False)
    T0NT2=CombinationT(T0,NT2,False)
    T0FT3=CombinationT(T0,FT3,False)
    FT1NT2=CombinationT(FT1,NT2,False)
    FT1FT3=CombinationT(FT1,FT3,True)
    FT2FT2=CombinationT(FT2,FT2,True)
    print('Number of NT1NT1:',len(NT1NT1))
    print('Number of NT1FT2:',len(NT1FT2))
    print('Number of T0NT2:',len(T0NT2))
    print('Number of T0FT3:',len(T0FT3))
    print('Number of FT1NT2:',len(FT1NT2))
    print('Number of FT1FT3:',len(FT1FT3))
    print('Number of FT2FT2:',len(FT2FT2))







