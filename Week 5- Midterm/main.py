import argparse
from modules.game_state import GameState
from modules.game_visualization import GameVisualization
from modules.solver import Solver


def load_map(map_path):
    """Load the map from the given path"""
    with open(map_path, 'r') as f:
        game_map = []
        for line in f:
            game_map.append(list(line.strip()))
    return game_map


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--map', help='The map file', default='maps/demo.txt')
    parser.add_argument('--strategy', help='The strategy to solve the game', default='astar')
    args = parser.parse_args()

    game_map = load_map(args.map)

    game_state = GameState(game_map)
    strategy = args.strategy
    solver = Solver(game_state, strategy)
    solver.solve()
    solution = solver.get_solution()

    game_visualization = GameVisualization(game_state, solution)
    game_visualization.start()
