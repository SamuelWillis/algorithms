# Binary Heap
Binary Heaps is an array object that can be viewed as a nearly complete Binary
Tree.

Each node in the tree corresponds to an element of the array.
The tree is completely filled at all levels except for possibly the last level,
which is filled from the left up to a point.

An array `A` that represents a heap in an object with two properties:
1. `A.length`: the number of elements in the array.
1. `A.heap-size`: how many elements in the heap are stored within `A`.

The second property means that although `A[1..A.length]` may contain numbers,
only the elements in `A[1..A.heap-size]`, where `1 <= A.heap-size <= A.length`
are valid elements of the heap.

Viewing heaps as a tree, the _height of a node_ in the tree is the number of
edges on the longest simple download path from the node to the leaf.
The _height of the heap_ is the height of the heap's root.
Since a heap of `n` elements is based on a complete binary tree, its height is
`θ(lg(n))`.

Heap operations run in time at most proportional to the height of the tree and
are therefore `O(log(n))`.

## Types
There are two types of binary-heaps, each one satisfying a _heap property_.
1. `Max-Heaps`: For every node `i` other than the root `A(i) <= A(PARENT(i))`,
   i.e. the largest element is at the root
1. `Min-Heaps`: For every node `i` other than the root `A(PARENT(i)) <= A(i)`,
   i.e. the smallest element is at the root.

Max-heaps are used in heapsort.

Min-heaps are useful for implementing priority queues.

## Parent, left-child, right-child indexes
The root of the tree is `A[1]` and given the index `i` of a node computation of
the node's parent, left-child, and right-child indices is simple.

```
PARENT(i):
  return floor(i/2)

LEFT(i):
  return 2*i

RIGHT(i):
  return 2*i + 1
```

Note: using `1` as the first index has advantages performance-wise.
This maybe isn't so important now-a-days but it's good to know.

Computers can do `2*i` in a single instruction by simply shifting the binary
representation of `i` left by one bit position.
Similarly, `2*i + 1` can by done by shifting the binary representation of `i`
left one bit position and then adding in a `1` as the lower order bit.
And finally, `floor(i/2)` can be done by shifting the binary representation of
`i` right by one bit position.
In fancy implementations, these procedures will often be implemented as
_macros_ (or _inline_ procedures).

## Operations
The following are max heap operations.
Min-heap operations are identical but implementations are different to maintain
the min-heap property.

```
MAX-HEAPIFY(A, i)
  # Given a binary tree and an index, "floats" the value at A[i] down in the
  # max-heap so that the subtree rooted at index i obeys the max-heap property
  # Assumes trees rooted at LEFT(i) and RIGHT(i) are max-heaps.
  left = LEFT(i)
  right = RIGHT(i)

  if left <= A.heap-size && A[left] > A[right]:
    largest = left
  else:
    largest = right

  if  right <= A.heap-size && A[right] > A[largest]
    largest = right

  if largest != i
    exchange A[i] with A[largest]
    MAX-HEAPIFY(A, largest)

BUILD-MAX-HEAP(A):
  A.heap-size = A.length
  for i = floor(A.length/2) downto 1
    MAX-HEAPIFY(A, i)

MAX-HEAP-INSERT

# The following are useful for implementing priority queues.
HEAP-EXTRACT-MAX

HEAP-INCREASE-KEY

HEAP-MAXIMUM
```

## Proofs
Here are some proofs of the operations

### MAX-HEAPIFY
Assume precondition of binary trees rooted at `LEFT(i)` and `RIGHT(i)` are max-heaps.

If `A[i]` is larger than `LEFT(i)` and `RIGHT(i)` then we are done as we have a
max-heap.

Otherwise, one of `LEFT(i)` or `RIGHT(i)` has the largest element and `A[i]` is
swapped with `A[largest]`.
Causing node `i` and its children to satisfy the max-heap property.

The node indexed by `largest` now has the value `A[i]` and might violae the
max-heap property.
Calling `MAX-HEAPIFY(A, largest)` restores the max-heap property for the tree
rooted at `largest`.

### BUILD-MAX-HEAP
Proof is done with a loop invariant:

- At the start of each iteration of the for loop, each node `i+1, i+2, ..., n`
    is the root of a max-heap

**Intialization** Prior to first loop, `i = floor(n/2)`. Each node `floor(n/2) +
1, floor(n/2) + 2, ..., n` is a leaf and thus the root of a trivial max-heap.

**Maintenance** Note that the children of node `i` are numbered higher than
`i`.
By the loop invariant, they are both roots of max-heaps.
This is the condition needed for the the `MAX-HEAPIFY` operation to make node
`i` the root of a max-heap.
Moreover, `MAX-HEAPIFY` preserves the property that `i+1, i+2, ..., n` are the
roots of max-heaps.
Decrementing `i` reestablishes the loop invariant for the next iteration.

**Termination** At termination, `i = 0`. By the invariant, each node `1, 2, ...,
n` is the root of a max-heap. In particulare, node `1` is.

