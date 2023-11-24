from itertools import combinations

def findsubsets(s, n):
    return list(itertools.combinations(s, n))

def get_pairs(L):
    return list(combinations(L, 2))
def check_element_exists(lst, target):   #check wheather target exist in list lst
    return target in set(lst)

def iso(L,G):                
    for G2 in L:
        if G.is_isomorphic(G2):
            return True
    return False
def W5ClawH3_test(G):
    Gprime = copy(G)
    Gprime.allow_multiple_edges(False)
    W5=Graph({0:[1,2,3,4,5],1:[5,2],2:[1,3],4:[3,5]})
    H=Graph({0:[1,2,3],1:[2],4:[3,5],5:[6,7],6:[7]})
    C=Graph({0:[1,2,3]})
    if  Gprime.subgraph_search(W5,induced=True) is not None or  Gprime.subgraph_search(C,induced=True) is not None or Gprime.subgraph_search(H,induced=True) is not None: return True
    return False

def Edge_test(G,M1,M2):  # Add to graph G edges between vertices M1 and M2 all possible way, such that the resulting graph is (W5,Claw,H3)-free return the list of graphs with these additional edges
    F=[]
    N=cartesian_product([M1, M2])
    S=Subsets(N)
    for E in S:
        Gnew=copy(G)
        Gnew.add_edges(E)
        if W5ClawH3_test(Gnew) == False and iso(F,Gnew) == False:
            F.append(Gnew)
    return F

def Phase(L,M1,V): # For each graph in L - add new vertex and connect it with all vertices V, then add edges between vertices M1 and x all possible way, return the list of graphs with these additional edges
    F=[]
    for K in L:
        Gprime=copy(K)
        x=Gprime.add_vertex(name=None)
        for v in V:
            Gprime.add_edge(v,x)
        for Gnew in Edge_test(Gprime,M1,[x]):
            if iso(F,Gnew) == False: F.append(Gnew)
    return F,x









