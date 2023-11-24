attach("base_functions.sage")
def iso_ex(L,G):   # List L is list of lists, which heva a graphs on first position, return true if graph G is isomorphic with some of these graphs
    for K in L:
        G2=K[0]
        if G.is_isomorphic(G2):
            return True
    return False
def vertex_move(G1,G2,x2):
    Gprime = copy(G1)
    x=Gprime.add_vertex(name=None)
    for v in G2.neighbors(x2):
            Gprime.add_edge(x,v)
    return Gprime,x

def New_vertex(G):   # Return list of lists contain graphs which are G with new vertex adjacent to all possible subsets of vertices of G, such that new graph doesnt contain H3 or W5 or claw and new vertex
    L=[]
    Gprime=copy(G)
    x=Gprime.add_vertex(name=None) #add new vertex
    S=Subsets(G.vertices(sort=True))[1:]
    for subset in S:
        Hx=copy(Gprime)
        for vertex in subset:
            Hx.add_edge(x,vertex)
        if W5ClawH3_test(Hx) == False and iso_ex(L,Hx) == False: 
            L.append([Hx,x])          
    return L
def New_vertex_feasible(G,Feasible):  # Split the list from "New_vertex" function into two lists depending on wheather new vertex is adjacent to some feasible vertex or not. 
    F=[]
    NonF=[]
    N=New_vertex(G)
    for L in N:
        isF = False
        for neighbour in L[0].neighbors(L[1]):   
            if check_element_exists(Feasible, neighbour):
                F.append(L)
                isF = True
        if isF == False:
            NonF.append(L)
    return F,NonF

def Add_P2(G,F,NonF): # Add path P2 and connected it all possible way, return the list of pairs - graphs with additional P2 and list of vertices of P2
    NP2=[]
    FP2=[]
    PairsNonF= get_pairs(NonF) 
    for L in NonF:                    
        H=copy(L[0])
        x=L[1]
        H1,x2 = vertex_move(H,H,x)
        y=H.add_vertex(name=None)
        H.add_edge(x,y)
        H1.add_edge(x,x2)
        if W5ClawH3_test(H1) == False and iso_ex(NP2,H1) == False: NP2.append([H1,[x,x2]])
        if W5ClawH3_test(H) == False and iso_ex(NP2,H) == False: NP2.append([H,[x,y]])               
    for PairNonF in PairsNonF:    
        x=PairNonF[0][1]
        G1,x2 = vertex_move(PairNonF[0][0],PairNonF[1][0],PairNonF[1][1])
        G1.add_edge(x,x2)
        if W5ClawH3_test(G1) == False and iso_ex(NP2,G1) == False: NP2.append([G1,[x,x2]])            
    for L in F:
        H=copy(L[0])
        x=L[1]
        y=H.add_vertex(name=None)
        H.add_edge(x,y)
        if W5ClawH3_test(H) == False and iso_ex(FP2,H) == False: FP2.append([H,[x,y]])
        for L2 in NonF:
            H2,x2 = vertex_move(L[0],L2[0],L2[1])
            H2.add_edge(x,x2)    
            if W5ClawH3_test(H2) == False and iso_ex(FP2,H2) == False: FP2.append([H2,[x,x2]])    
    return FP2,NP2

def Longer_path(NonF, List, feasibility):   # Make path longer by 1, return the list of pairs - graphs with additional path and list of vertices of path
    Final=[]
    for L in List:
        if feasibility == False:
            G1=copy(L[0])
            P1 = copy(L[1])
            v1=G1.add_vertex(name=None)
            G1.add_edge(P1[0],v1)
            P1.insert(0,v1)
            P1.reverse()
            if G1.degree(P1[0]) > 1 and W5ClawH3_test(G1) == False and iso_ex(Final,G1) == False: Final.append([G1,P1])
        G2=copy(L[0])
        P2 = copy(L[1])
        v2=G2.add_vertex(name=None)
        G2.add_edge(P2[len(P2)-1],v2)
        P2.append(v2)
        if W5ClawH3_test(G2) == False and iso_ex(Final,G2) == False: Final.append([G2,P2])
        for L2 in NonF:
            G3,v3 = vertex_move(L[0],L2[0],L2[1])
            if feasibility == False:
                G4=copy(G3)
                P4 = copy(L[1])
                G4.add_edge(P4[0],v3)
                P4.insert(0,v3)
                P4.reverse()
                if G4.degree(P4[0]) > 1 and W5ClawH3_test(G4) == False and iso_ex(Final,G4) == False: Final.append([G4,P4])
            P3 = copy(L[1])
            G3.add_edge(P3[len(P3)-1],v3)
            P3.append(v3)
            if W5ClawH3_test(G3) == False and iso_ex(Final,G3) == False: Final.append([G3,P3])                   
    return Final

def Add_T0(NP2):    #Making gamma_0 from P2 by finding all common neighbors
    T0=[]
    for K in NP2:
        Z=[]
        for v in K[0].neighbors(K[1][0]):
            if check_element_exists(K[0].neighbors(K[1][1]),v) == True:
                Z.append(v)    
        if len(Z)!=0: T0.append([K[0],K[1],Z])
    return T0
def Add_T(NonF,Path,Feasible,feasibility): #Making gamma_i from Path by adding new vertex and connected with last two vertices of a path
    D=[]
    Final=[]
    for L in Path:
        H=copy(L[0])
        V =copy(L[1])
        z=H.add_vertex(name=None)
        H.add_edge(z,V[len(V)-1])
        H.add_edge(V[len(V)-2],z)
        V.append(z)
        if W5ClawH3_test(H) == False and iso_ex(D,H) == False: D.append([H,V])
        for K in NonF:
            V2 =copy(L[1])
            H2, z2 = vertex_move(L[0],K[0],K[1])
            H2.add_edge(z2,V2[len(V2)-1])
            H2.add_edge(V2[len(V2)-2],z2)
            V2.append(z2)
            if W5ClawH3_test(H2) == False and iso_ex(D,H2) == False: D.append([H2,V2])
    T=Graph({0:[1,2],1:[2]})
    x=0
    for i in range(3,len(Path[0][1])+2,1):
        y=x
        x=T.add_vertex(name=None)
        T.add_edge(x,y)
    for L in D:
        V=L[1]
        Z=[]
        for v in L[0].neighbors(V[0]):     
            Vx=copy(V)
            if (feasibility == False) or (feasibility and v in Feasible):
                Vx.append(v)
                Hw=L[0].subgraph(vertices=Vx)
                if Hw.is_isomorphic(T) == True:  
                    Z.append(v)
            if len(Z)!=0: Final.append([L[0],L[1],Z])
    return Final
def CombinationT(T1,T2,feasibility):
    F=[]
    for T in T1:
        VT1=copy(T[1]) 
        for L in T2:
            Gnew=copy(T[0])
            VT2=copy(L[1])
            V1=[]
            for v in VT2:
                x=Gnew.add_vertex(name=None)
                for v2 in L[0].neighbors(v):
                    if v2 not in VT2:
                        Gnew.add_edge(x,v2)
                V1.append(x)
            indexes=list(range(0,len(V1)-1,1))
            for i in indexes:
                Gnew.add_edge(V1[i],V1[i+1])
            if len(V1) > 2: Gnew.add_edge(V1[len(V1)-1],V1[len(V1)-3])
            ZT1=[]
            ZT2=[]
            for v2 in L[2]:                
                k = False
                if feasibility: VT1x=VT1[1:]
                else: VT1x=copy(VT1)    
                for v1 in VT1x:
                    if Gnew.has_edge(v1,v2):
                        k = True
                        break
                if k == False: ZT2.append(v2)                                                            
            for v2 in T[2]:
                k = False
                if feasibility: V1x=V1[1:]
                else: V1x=copy(V1) 
                for v1 in V1x:
                    if Gnew.has_edge(v1,v2) == False:
                        k=True
                        break
                if k == False: ZT1.append(v2) 
            if W5ClawH3_test(Gnew) == False and iso_ex(F,Gnew) == False:
                Gnew.show()
                print(VT1)
                print(V1)
            if len(ZT1)!=0 and len(ZT2)!=0 and W5ClawH3_test(Gnew) == False and iso_ex(F,Gnew) == False: 
                S=[]
                S.append(Gnew)
                S.extend(VT1)
                S.append(ZT1)
                S.extend(V1)
                S.append(ZT2)
                F.append(S)
    return F