from clingo import Control

from ._solution import Solution
from ._encoder import Encoder
from .shilver_lp import SOLVER_LP, VIZ_LP

from clingraph.clingo_utils import ClingraphContext

class Solver:
    def __init__(self):
        self.control = Control([])

    def compute_solution(self, input_file) -> Solution:
        enc = Encoder()
        self.control.add('base', [], enc.from_file(input_file))
        self.control.add('base', [], SOLVER_LP)
        self.control.add('base', [], VIZ_LP)
        
        self.control.ground([('base',[])], context=ClingraphContext())

        s = []
        self.control.solve(on_model=lambda m: s.append(Solution.from_model(m)))
        return s.pop()
