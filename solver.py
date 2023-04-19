from shilver import Solver
from shilver import Solution

solution = Solver().compute_solution('tests/txt/8x8.txt')
# solution.view()
# solution.save_as_pdf('solution')

print(solution.as_json())