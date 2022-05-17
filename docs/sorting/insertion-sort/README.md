# Insertion Sort
A simple sorting algorithm.
Useful for small or nearly sorted collections.

## Pseudo Code
Insertion sort takes an element and aims to _insert_ it into the correct
position.

```
INSERTION SORT(A)
  for i = 1 -> A.length - 1 do
    current_element = a[i]
    j = i - 1

    # insert A[i] into its proper position in A[0..i-1]
    while j >= 0 and current_element < A[j] do
      A[j + 1] = A[j]
      j = j - 1

    A[j + 1] = current_element
```
In insertion sort, we split the array into two piles.
On the left are the sorted elements and on the right are the unsorted.

For each element on the right, we compare it to elements in the left pile.
If the left hand element is larger, we move it to the "right" one position and
repeat.
If the left hand element is less than or equal we place the left element in to
the position to the "right" of the current left hand position.

## Proof
Insertion works as the all elements to the "left" of the current element are
sorted.

Proof is by loop invariant.

__Loop invariant:__ At the start of the outer loop the sub array `A[0..i-1]`
consists of original elements of `A` but in sorted order.

__Initialization step:__ when `i = 1`, the sub array `A[0..i-1] = A[0]` is
sorted as it consists of a single element.

__Maintenance:__ Each iteration of the outer loop expands the sub array but keeps
the sorted property.
This is because `V = A[i]` is only inserted into the sub array `A[0..i-1]` when
it is larger than the element `A[j]`.
Since the elements to `V`'s left are sorted, the sub array remains sorted.

__Termination:__ The outer loop terminates when `i` has reached the last
element of the array.
Meaning our sorted sub array is `A[0..i] = A[0..n] = A`, which is the entirety
of the original array.

## Performance
`O(n^2)`.
The outer loop happens `n` times.

In the worst case the array is in reverse sorted order.
In this case, for each element `A[i]` we must compare it to every element in
`A[0..i-1]`.

Giving `O(n^2)`
