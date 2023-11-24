attach("base_functions.sage")
G1=Graph({0:[1,2,3,4],2:[1,3],3:[2,4],4:[1,3]})
M1=[1,2,3,4]
L0=[G1]
L1,p1=Phase(L0,M1,[0])
L2,p2=Phase(L1,M1,[0])
L3,t1=Phase(L2,M1,[p1])
L4,p3=Phase(L3,M1,[p2])
L5,p4=Phase(L4,M1,[p3])
L6,t3=Phase(L5,M1,[p4])
L7,t2=Phase(L6,M1,[t1,p1])
L8,t4=Phase(L7,M1,[t3,p4])
for G in L8:
    G.show()     # In L8, there is one graph G.
# From 3-connectivity we know that vertex 8  in G must have another neighbour.
L,x = Phase(L8,G.vertices(sort=False),[8])
print(len(L))   #There is no such graphs.










