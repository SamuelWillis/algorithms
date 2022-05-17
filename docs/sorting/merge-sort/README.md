# Merge Sort
Merge sort is a _divide and conquer_ algorithm.

It works as followBounds:
1. Divide the _n_-element sequence into two subsequences of `n/2` elements each
1. Sort the two subsequences by calling `merge-sort` on them recursively
1. Merge the two sorted subsequences

The recursion bottoms out when the subsequence consists of a single element and
the key operation is the merging of arrays.

## Pseudo Code
The followBounding asks the consumer of `MERGE SORT` to pass in the original
`lowBound` and `highBound` indexes they want to sort the array over.
This is useful if there's a chance you want to sort parts of the original array
and not others.

```
MERGE SORT(A, lowBound, highBound)
  if highBound <= lowBound
    return

  pivot = FLOOR(n / 2)

  left = MERGE SORT(A, lowBound, pivot)
  right = MERGE SORT(A, pivot + 1, highBound)
  MERGE(A, lowBound, pivot, highBound)

MERGE(A, lowBound, pivot, highBound)
  # split the array in half
  n1 = pivot - lowBound + 1
  n2 = highBound - pivot

  # Create two sorted subarrays and fill with appropriate elements
  # Set the last element to INFINITY
  L = A[0..n1-1], L[n1] = INFINITY
  R = A[0..n2-1], R[n2] = INFINITY

  i = 0
  j = 0
  for k = lowBound to highBound (Loop A)
    if L[i] <= R[j]
      A[k] = L[i]
      i++
    else
      A[k] = R[j]
      j++
```

If you do not want to use `INFINITY`, you can loop until you reach the end of
either `L` or `R`, then fill `A` with the elements left over in whichever of `L`
or `R` still has elements.

## Proof
To prove merge sort works we must prove the `MERGE` procedure works.

## Merge Proof
Proof of `MERGE` is with a loop invariant.

__Loop Invariant__ At the __start__ of each iteration of the loop, the subarray `A[lowBound..k-1]` contains the `k - lowBound` smallest elements of `L[lowBound..n1]` and `R[n2..highBound]` in sorted order.
Moreover `L[i]` and `R[j]` are the smallest elements in each array that has not been placed back into `A`.

__Initialization__ Prior to the first iteration `k = lowBound`.
Thus, `A[lowBound..k-1]` contains the `k - lowBound = lowBound - lowBound = 0` smallest
elements of `L` and `R`.
Since `i = j = 0`, both `L[i]` and `R[j]` are the smallest elements of their
arrays that have not been copied back into `A`.

__Maintenance__ To see each iteration maintains our invariant we must consider
two cases.
Case 1: `L[i] <= R[j]`
This means `L[i]` is the smallest element not copied back into `A`.
Since `A[lowBound..k-1]` already contains `k - p` smallest elements, after we
insert `L[i]` into `A[k]` the subarray `A[lowBound..k]` will contain the `k - p
+ 1` smallest elements.
The incrementation of `k` and `i` maintains the invariant for the next
iteration.

Case 2: `R[j] < L[i]`
This case is the same as above, but we copy `R[j]` into `A[k]`.
The subsequent incrementation of `k` and `j` maintain the invariant for the next
iteration.

__Termination__ At termination `k = highBound + 1`.
By the loop invariant the subarray `A[lowBound..k-1] = A[lowBound..highBound]`
contains the `k - lowBound = (highBound + 1) - lowBound = highBound - lowBound +
1` smallest elements of `L[lowBound..n1]` and `R[n2..highBound]` in sorted
order.
The arrays `L` and `R` contain a total of `highBound - lowBound + 3` elements
from:
```
n1 + n2 + 2
  = (pivot - lowBound + 1) + (highBound - pivot)
  = pivot - lowBound + 1 + highBound - pivot
  = highBound - lowBound + 3
```
Since we have copied `highBound - lowBound + 1` elements, there are two elements
remaining.
These two elements are the largest elements in `L` and `R` and they are the
sentinel `INFINITY` elements inserted into `L` and `R` by the merge procedure.

### Merge Sort Proof
The `MERGE SORT(A, p, r)` procedure sorts the elements in the subarray given by
`A[p..r]`.

If `p >= r` the subarray has at most one element and is therefore sorted.

Otherwise, the divide step computes the `pivot` index that partitions
`A[lowBound..r]` into 2 subarrays `A[lowBound..pivot]` containing `ceiling(n/2)`
elements and `A[pivot+1..highBound]` containing `floor(n/2)` elements.
It then merges the two sorted arrays together with the `MERGE` procedure.

## Performance

### Performance of Merge
In the worst case `MERGE` will do two full loops through the `n` elements.
This happens when all the elements in one of `L` or `R` are smaller than the
first element of the other array.

In this case, two full loops of the `n` elements will occur.
One to copy all the small elements and then another for the rest.

Therefore `O(n)`.

### Performance of Merge Sort
To analyze the recurrance we need to define a recurrence relation.

This is simpler if we assume `n` is a power of 2, ie: `n=2^i`, as we end up with
two problems of size `n/2` on each divide step.

Let `T(n)` be the worst case running time of merge sort over `n=2^i` numbers.

**Divide Step:** Computes the middle index, `D(n) = O(1)`
**Conquer Step:** Recusively solves two problems of size `n/2`, so `2 * T(n/2)`
**Combine Step:** Merge on an array of size `n` is `O(n)`, so `C(n) = O(n)`

Putting this all together we get:
```
T(n) = O(1) if n=1
     = 2T(n/2) + O(n) if n > 1
```

We can use a _master theorem_ to prove this, but a _recurrance tree_ will also
work.

Rewriting the above, using `c` as the time needed to solve problems of size 1 as
well as the time per array element of the divide and combine steps.
```
T(n) = c if n=1
     = 2T(n/2) + cn if n > 1
```
Putting the above into a recursion tree gives `cn` as the root, the two subtrees
of the root are `T(n/2)`, the two subtrees of each of the `T(n/2)` nodes are
`T(n/4)`, and so on until we reach the final level with `n` nodes of `T(n/2^i) =
T(1) = c`

Breaking down the costs of each tree level we get `cn` at the root, `c(n/2) +
c/2) = cn` at the second level.
In general each level `j` will have `2^j` nodes, each contributing a cost of
`c(n/2^j)`.
Meaning at level `j` we have `2^jc(n/2^j) = cn` cost.
The last level will have `n` nodes of cost `c`.

The total number of levels will be `log(n) + 1`.
An informal induction proof is as follows.
When `n=1`, `log(n) + 1 = log(1) + 1 = 0 + 1 = 1` since the tree should only
have 1 level.

Assume for the induction hypothesis that the number of levels of a recursion
tree with `2^k` leaves is `lg(2^k) + 1`. Since `log(2^k) = k` we have `log(n) +
1 = log(2^k) + 1 = k + 1`. So `k + 1` leaves at level `2^k`.

Since `n` is a power of two, the next input size is `n=2^(k+1)`.
Therefore we have `(k + 1) + 1` leaves as `log(2^k+1) + 1 = (k + 1) + 1`.
So the IH holds.

All of the above gives `log(n) + 1` levels, each with a cost of `cn`.
So, `cn(log(n) + 1)`.
Or more simply `nlog(n)`.

So merge sort `O(nlog(n))`.
