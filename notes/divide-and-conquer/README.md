# Divide and conquer algortithms
__Divide and conquer__ algorithms split the problem into many subproblems that
are similar to the original but smaller in size, solve the subproblems (often
recursively), and then combine the subproblem solutions to get a solution to the
original problem.

There are three main steps:

1. __Divide:__ Split the problem into a number of subproblems that are smaller
   instances of the same problem.
1. __Conquer:__ Solve the subproblems recursively, or if they are small enough
   in a straight forward manner.
1. __Combine:__ Merge the subproblem solutions into a solution for the original
   problem.

## Runtime analysis
There are three main ways to analyze the runtime of recursive Divide and Conquer
algorithms.

1. __Substitution method:__ Guess a bound, then use mathematical induction to
   prove it.
1. __Recursion-tree method:__ Conver the recurrence into a tree whose nodes
   represent the cost incurred at various levels of the recurrence. Use
   techniques for summation bounding to solve.
1. __Master method:__ Use the master theorem and its 3 cases to prove bounds.

## Technicalities
Often we ignore certain technical details when stating and resolving
recurrences.
Omissions include floors, ceilings, and boundary conditions as they typically
do not change the bound by more than a constant factor.

Typically, bounds are proved without these details and then it is shown that
they do not have an effect on the bounds.
