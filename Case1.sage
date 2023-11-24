attach("base_functions.sage")
S=load('Case1F')        # Loading graphs from arcticle
G1=Graph({0:[1,2,3,4,5,6],2:[1,3],3:[2,4],4:[1,3],5:[1,2],6:[3,4]})
M1=[1,2,3,4]
L0=[G1]
L1,p2=Phase(L0,M1,[6])    #In each step we add new vertex of F and connected it by all possible way to M1, see more in base_functions
L2,p3=Phase(L1,M1,[p2])
L3,p4=Phase(L2,M1,[p3])
L4,t3=Phase(L3,M1,[p4])
L5,t4=Phase(L4,M1,[t3,p4])
print(len(L5))
for G in L5:        #checking if graphs in L5 are isomorphic to graphs in the article
    if iso(S1,G)==False: print(False)               
        









