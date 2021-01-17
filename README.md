# Algorithms
Generally speaking an algorithm is a way to take a set of input and produce an output.
This means it is a series of steps that transform the input into the output.

#### [Table of Contents](#table-of-contents)

## Design
There are many ways to design an alogrithm.

### Incremental
Incrementally build a solution.
Takes a sequence of input, and finds a sequence of solutions that build
incrementally while adapting to changes in the input.

More simply put, start with a base solution and add to it one step at a time.

Example [insertion sort](./notes/sorting/insertion-sort)

### Divide and conquer
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

## Run time analysis
Running time analysis is typically done on a basic RAM model.

In general, the time take by an algorithm depends on the size of it's input.
The best notion of _input size_ depends on the problem being studied.
In most cases it is the _number of items_ in an input.
But it can also be something like the _number of bits needed_ to represent an
input, for example.

The __running time__ of an algorithm is the number of primitive operations, or
"steps", executed.

The _worst case_ run time is often the most considered and is known as __big o
analysis__.

### Proving correctness
There are numerous ways you can prove an algorithm works.
Here is a sample of common strategies.

### Loop Invariant
A __loop invariant__ is a property of a program loop that is true before and
after each iteration

Proof using a loop invariant requires you show the following:
1. __Initialization:__ It is true prior to the first iteration of the loop
1. __Maintenance:__ If it is true before an iteration of a loop, it is true after
1. __Termination:__ When the loop terminates, the invariant gives us a useful
   property that shows algorithm is correct.

This technique is very similar to _mathematical induction_.
Showing the initialization holds corresponds to the base case, and showing the
invariant holds from iteration to iteration corresponds to the inductive step.

Since the loop invariant is used to show correctness we typically combine it
with the condition that caused the loop to terminate.

An example of this technique is the proof for [insertion
sort](./notes/sorting/insertion-sort)

## Table of Contents
