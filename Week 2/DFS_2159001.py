from collections import defaultdict

class Graph:
    def __init__(self):
        self.graph = defaultdict(list)
        self.visited = set()
        self.result = []  

    def addEdge(self, u, v):
        self.graph[u].append(v)
        self.graph[v].append(u)

    def DFS(self, s):
        
        if s not in self.visited:
            print(s, end=' ')
            self.visited.add(s)
            self.result.append(s)  

            
            for neighbor in self.graph[s]:
                self.DFS(neighbor)
                
    def saveResultToFile(self, filename):
        with open(filename, "w") as f:
            for vertex in self.result:
                f.write(str(vertex) + "\n")
                

g = Graph()


with open("C:\\Users\victo\OneDrive\Documents\21BIT-AI\input.txt", "r") as f:
    N, M = map(int, f.readline().split())
    for line in f:
        u, v = map(int, line.strip().split())
        g.addEdge(u, v)
        g.addEdge(v, u)


g.DFS(6)


g.saveResultToFile("C:\\Users\victo\OneDrive\Documents\21BIT-AI\output.txt")