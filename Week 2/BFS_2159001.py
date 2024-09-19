from collections import defaultdict


class Graph:
    def __init__(self):
        self.graph = defaultdict(list)
    def addEdge(self, u, v):
        self.graph[u].append(v)

    def BFS(self, start, end):
        visited = set()
        queue = [[start]]
        
        if start == end:
            return [start]
        
        while queue:
            path = queue.pop(0) 
            node = path[-1] 

            if node not in visited:
                adjacent_nodes = self.graph[node] 
                for adjacent_node in adjacent_nodes:
                    new_path = list(path)
                    new_path.append(adjacent_node)
                    queue.append(new_path)

                    if adjacent_node == end:
                        return new_path

                visited.add(node)

        return "NO"
    

g = Graph()

with open("C:\\Users\victo\OneDrive\Documents\21BIT-AI\input.txt", "r") as file:
    N, M = map(int, file.readline().split()) 
    for line in file:
        u, v = map(int, line.strip().split())
        g.addEdge(u, v)
        g.addEdge(v, u)

result = g.BFS(1,4)


with open("C:\\Users\victo\OneDrive\Documents\21BIT-AI\output.txt", "w") as file:
    if result == "NO":
        file.write("NO")
    else:
        file.write(" ".join(map(str, result)))


