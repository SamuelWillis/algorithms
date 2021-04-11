# The maximum-subarray problem
Given an array _A_ find a nonempty, contiguous subarray of _A_ whose values
have the have the largest sum.

## Brute force method
Take every pair of indices `x` and `y` s.t. `x < y`and find the sum of elements given by
`A[x..y]`.

This is `O(n^2)` as there's `nC2` pairs.
We can do better than this.

## Divide and conquer method
Consider dividing the array into `A[lo..mid]` and `A[mid+1..hi]`, then any
contiguous subarray must land in one of three places:

* entirely in the subarray `A[lo..mid]`
* entirely in the subarray `A[mid+1..hi]`
* crossing the midpoint s.t. `low <= i <= mid < j <= hi`

Thus, a maxiumum subarray of `A[lo..hi]` must live in exactly one of those
places as well.
It must also have the greatest sum over all subarrays entirely in `A[lo..mid]`,
entirely in `A[mid+1..hi]`, or crossing the midpoint.

The maximum subarray of `A[lo..mid]` and `A[mid+1..hi]` can be found recursively
as they are smaller subproblems of finding a maximum subarray of `A[lo..hi]`.

All that is left to do is find a maxium subarray that crosses the midpoint, then
take the subarray with the largest sum of the three.

We can do this in linear time.
Any subarray that crosses the midpoint is composed of two arrays, `A[i..mid]`
and `A[mid+1..j]` where `lo <= i <= mid` and `mid < j <= hi`.
So we need to find a maximum subarray of the form `A[i..mid]` and `A[mid+1..j]`
then combine them.

## Pseudo code

```
FIND MAXIMUM SUBARRAY(A, lo, hi):
  if hi == lo, return (lo, hi, A[lo])

  mid = floor(lo + hi / 2)

  (left_lo, left_hi, left_sum) = FIND MAXIMUM SUBARRAY(A, lo, mid)

  (right_lo, right_hi, right_sum) = FIND MAXIMUM SUBARRAY(A, mid + 1, hi)

  (cross_lo, cross_hi, cross_sum) = FIND MAXIMUM CROSSING SUBARRAY(A, lo, mid, hi)

  if left_sum >= right_sum and left_sum >= cross_sum:
    return (left_lo, left_hi, left_sum)

  if right_sum >= left_sum and right_sum >= cross_sum:
    return (right_lo, right_hi, right_sum)

  return (cross_lo, cross_hi, cross_sum)

FIND MAXIMUM CROSSING SUBARRAY(A, lo, mid, hi):
  left_sum, right_sum = -infinity
  sum = 0

  for i = mid downto lo:
    sum = sum + A[i]
    if sum >= left_sum:
      left_sum = sum
      max_left = i

  sum = 0
  for h = mid+1 to hi:
    sum = sum + A[i]
      if sum >= right_sum:
        right_sum = sum
        max_right = j

  return (max_left, max_right, left_sum + right_sum)
```

## Proof

### Finding maximum crossing subarray

### Finding maximum subarray

## Analysis

### Finding maximum crossing subarray
If the subarray `A[lo..hi]` has `n` entries, then `n = high - low + 1`.

In the worst case the loop from `mid` to `lo` does `mid - low + 1` iterations
and the loop from `mid + 1` to `hi` does `hi - mid` iterations.

This gives `(mid - lo + 1) + (hi - mid) = hi - lo + 1 = n` iterations.

Therefore, `O(n)`.

### Finding maximum subarray
Assume that original array size is a power of 2.

Let `T(n)` be the running time of `FIND MAXIMUM SUBARRAY` on a subarray of `n`
elements.

The base case of a single element array is `O(1)`.

The recursive case occurs when `n > 1` and we split the problem into subproblems
of size `n/2`, meaning we spend `T(n/2)` on each subproblem.

Therefore our recurrence equation is:
```
T(n) = O(1) if n=1
     = 2T(n/2) + O(n) if n > 1
```

We have seen this recursion before when analyzing [Merge
Sort](../sorting/merge-sort).

This gives a run time of `O(nlog(n))`.
