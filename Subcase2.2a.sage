attach("base_functions.sage")
        
G1=Graph({0:[1,2,3,4],2:[1,3],3:[2,4],4:[1,3]})
M1=[1,2,3,4]
L0=[G1]
L1,p2=Phase(L0,M1,[0])
L2,p3=Phase(L1,M1,[0])
L3,p1=Phase(L2,M1,[p2])
L4,p4=Phase(L3,M1,[p3])
L5,t1=Phase(L4,M1,[p1])
L6,t3=Phase(L5,M1,[p4])
L7,t2=Phase(L6,M1,[t1,p1])
L8,t4=Phase(L7,M1,[t3,p4])
print(len(L8))










