import random
import copy
import math

class NQueensStateNode:
  
    def __init__(self, initialState):
        self.state = initialState  
        self.nQueen = len(initialState) 
        self.cRow = dict()  
        self.cDiagonal1 = dict()  
        self.cDiagonal2 = dict()  
        self.countQueenList()

    def printState(self):
        print(' '.join(str(r) for r in self.state))

    def countQueenList(self):
        self.cRow = dict()
        self.cDiagonal1 = dict()
        self.cDiagonal2 = dict()
        for i in range(self.nQueen):
            row = self.state[i]
            self.cRow[row] = self.cRow.get(row, 0) + 1
            self.cDiagonal1[i - row] = self.cDiagonal1.get(i - row, 0) + 1
            self.cDiagonal2[i + row] = self.cDiagonal2.get(i + row, 0) + 1

    def getHeuristic(self):
        self.countQueenList()
        heuristic = 0
        
        for j in range(len(self.state)):
            queen_j_row_pos = self.state[j] 
            for k in range(j + 1, len(self.state)): 
                queen_k_row_pos = self.state[k] 
                if queen_j_row_pos == queen_k_row_pos: 
                    heuristic += 1
                    
                if (j - queen_j_row_pos) == (k - queen_k_row_pos):
                    heuristic += 1

                if (j + queen_j_row_pos) == (k + queen_k_row_pos):
                    heuristic += 1
                    
        return heuristic
  

    def getBestSuccesor(self):
        bestState = None
        bestHeuristic = float('inf')  # initialize with positive infinity

        for i in range(self.nQueen):
            for j in range(self.nQueen):
                if self.state[i] != j:
                    # Try moving the queen in column i to row j
                    tempState = copy.deepcopy(self.state)
                    tempState[i] = j
                    neighborNode = NQueensStateNode(tempState)
                    neighborHeuristic = neighborNode.getHeuristic()

                    if neighborHeuristic < bestHeuristic:
                        bestState = tempState
                        bestHeuristic = neighborHeuristic

        return bestState
    
    
    def getFirstChoice(self):
        candidates = []
        currentHeuristic = self.getHeuristic()

        for col in range(self.nQueen):
            for row in range(self.nQueen):
                if self.state[col] != row:
                    nextState = copy.deepcopy(self.state)
                    nextState[col] = row
                    nextStateNode = NQueensStateNode(nextState)
                    heuristic = nextStateNode.getHeuristic()
                    if heuristic < currentHeuristic:
                        candidates.append(nextState)

        if candidates:
            return random.choice(candidates)
        else:
            return None


    @staticmethod
    def HillClimbing(state):
        currentStateNode = NQueensStateNode(state)
        currentHeuristic = currentStateNode.getHeuristic()

        print("Initial State:")
        currentStateNode.printState()
        print("Initial Heuristic:", currentHeuristic)

        while True:
            bestSuccesor = currentStateNode.getBestSuccesor()
            if bestSuccesor is None:
                break

            succesorNode = NQueensStateNode(bestSuccesor)
            succesorHeuristic = succesorNode.getHeuristic()

            if succesorHeuristic >= currentHeuristic:
                break

            currentStateNode = succesorNode
            currentHeuristic = succesorHeuristic

            print("Next State:")
            currentStateNode.printState()
            print("Heuristic:", currentHeuristic)

        return currentStateNode.state



        
    @staticmethod
    def HillClimbingFirstChoice(state):
        '''Generate successors randomly until one is generated that is better
         than the current state '''
        currentStateNode = NQueensStateNode(state)
        currentHeuristic = currentStateNode.getHeuristic()

        print("Initial State:")
        currentStateNode.printState()
        print("Initial Heuristic:", currentHeuristic)

        while True:
            bestSuccesor = currentStateNode.getFirstChoice()
            if bestSuccesor is None:
                break

            succesorNode = NQueensStateNode(bestSuccesor)
            succesorHeuristic = succesorNode.getHeuristic()

            if succesorHeuristic >= currentHeuristic:
                break

            currentStateNode = succesorNode
            currentHeuristic = succesorHeuristic

            print("Next State:")
            currentStateNode.printState()
            print("Heuristic:", currentHeuristic)

        return currentStateNode.state



     
    @staticmethod
    def getRandomState(nQueen):
        '''returns a random state in which each column has exactly one queen in it'''
        state = list(range(nQueen))
        random.shuffle(state)
        return state

    @staticmethod
    def HillClimbingRandomRestart(state):
        '''That is a series of hill-climbing searches from randomly
    generated initial states until a goal is found.
        • For each restart: run until termination vs run for a fixed time
        • Run a fixed number of restarts or run indefinitely'''
        restarts = 0
        while True:
            print("Restart:", restarts + 1)
            initialState = NQueensStateNode.getRandomState(state)
            finalState = NQueensStateNode.HillClimbing(initialState)
            if NQueensStateNode(finalState).getHeuristic() == 0:
                return finalState
            restarts += 1



if __name__ == '__main__':
    finalState = NQueensStateNode.HillClimbing([2, 3, 0, 1])
    print("Final State:")
    NQueensStateNode(finalState).printState()

    initialState = NQueensStateNode.getRandomState(4)
    finalState = NQueensStateNode.HillClimbingFirstChoice(initialState)
    print("Final State:")
    NQueensStateNode(finalState).printState()

    finalState = NQueensStateNode.HillClimbingRandomRestart(4)
    print("Final State:")
    NQueensStateNode(finalState).printState()



   

   



  



   


