# Quicksort
Quite often, quicksort is the best practical choice for sorting despite its
worst case running time.

It sorts in place and the hiddent constant factors in its runtime are quite
small.

## Pseudo code
Like merge-sort, quicksort is a divide-and-conquer algorithm.

**Divide:** Partition the array `A[p..r]` into two possibly empty subarrays
`A[p..q-1]` and `A[q+1..r]` such that each element of `A[p..q-1]` is less than
or equal to `A[q]` and each element of `A[q+1..r]` is greater than or equal to
`A[q]`. Compute `q` as part of this step.

**Conquer:** Sort the two subarrays `A[p..q-1]` and `A[q+1..r]` by recursive
calls to quicksort.

**Combine:** Because the subarrays are already sorted, just stick 'em back
together. `A[p..r]` is now sorted.

```
QUICKSORT(A, p, r):
  if p < r:
    q = PARTITION(A, p, r)
    QUICKSORT(A, p, q - 1)
    QUICKSORT(A, q + 1, r)

PARTITION(A, p, r):
  x = A[r]
  i = p - 1

  for j = p to r - 1:
    if A[j] <= x:
      i = i + 1
      exchange A[i] with A[j]

  exchange A[i + 1] with A[r]

  return i + 1
```

## Proof
The proof hinges around the `PARTITION` routine.

The `PARTITION` routine above chooses `x = A[r]` as the element to partition around.
As it runs it partitions the array into 4 regions.

At the start of each loop the regions satisfy the following:

1. If `p <= k <= r` -> `A[k] <= x`
2. If `i + 1 <= k <= j - 1` -> `A[k] > x`
3. If `k = r` -> `A[k] = x`

The elements from `j - 1` to `r` have no particular relationship to `x`.

**Initialization:** Prio to the iteration of the loop, `i = p -1` and `j = p`.
Because there are no values between `p` and `i` and no valies between `i + 1`
and `j - 1` conditions 1 and 2 hold.
Condition 3 is satisfied by the assignment `x = A[r]`

**Maintenance:** There are 2 cases to consider:
1. `x < A[j]`, in this case we increment `j`. After incrementing condition 2
   holds for `A[j - 1]` and all other enteries remain unchanged.
2. `A[j] <= x`, in this case `i` is incremented, `A[i]` and `A[j]` are swapped,
   and then `j` is incremented. Due to the swap `A[i] <= x`, satisfying
   condition 1. Similarily we have `A[j - 1] > x` since the item swapped to `A[j
   - 1]` is, by the loop invariant, greater than `x`.

**Termination:** At termination, `j = r` so every entry in the array is on one
of the 3 sets. Meaning the array has been partitioned into 3 sets, those less
than or equal to `x`, those greater than or equal to `x`, and the singleton `x`.

The last line swaps `x` with the leftmost element greater than `x`, moving the
pivot into the correct place in the partitioned array. The pivot index is then
returned.

Thus, the output from `PARTITION` satisfies the specifications given by the
divide step. Moreover, after `PARTITION` `A[q]` is strictly less than every
element in `A[q+1..r]`.

## Performance

### PARTITION
Runtime is `O(n)`, where `n = r - p + 1` since we loop over each element of the
array.
