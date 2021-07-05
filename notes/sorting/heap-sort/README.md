# Heapsort
Heapsort that combines the best attributes of [insertion
sort](../insertion-sort) and [merge sort](../merge-sort).

It sorts an array _in-place_ and in `O(log(n))` time.
Heapsort also introduces the use of a Data Structure, namely
[Binary Heaps](../../data-structures/binary-heap).

## Pseudo code
Heapsort repeatedly uses heaps to place each element to its proper position at
the end of the provided array.

It first builds a heap out of the whole array, then working from the back of the
array swaps the root of the heap to the back of the array and re-heapifies the
remaining elements in the heap.

```
HEAPSORT(A):
  BUILD-MAX-HEAP(A)

  for i = A.length downto 2:
    exchange A[1] with A[i]
    A.heap-size = A.heap-size - 1
    MAX-HEAPIFY(A, 1)
```

## Proof
Using the proof of `BUILD-MAX-HEAP` and `MAX-HEAPIFY` from [Binary
Heaps](../../data-structures/binary-heap) we know:

1. `BUILD-MAX-HEAP` always places the largest element in the array at `A[1]`
2. `MAX-HEAPIFY` preserves the max-heap property

Using this, we know that each iteration of the for loop we are placing the
largest element in the heap given by `A[1..i]` to the back of the array.

Once we get to the end of the loop, we've put all the elements in order since
we've repeatedly put the largest element in the unsorted elements into the next
position in the array.

## Perfomance
Heapsort takes `O(nlog(n))` time as `BUILD-MAX-HEAP` takes `O(n)` time and each
of the `n-1` calls to `MAX-HEAPIFY` takes `O(log(n))` time.
