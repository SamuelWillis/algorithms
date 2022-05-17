# Matrix multiplication
Matrix multiplication is defined as follows:

If `A = a(ij)` and `B = b(ij)` are `nxn` matrices, then in the product `C = A·B` we
define the entry `c(ij)`, for `i,j = 1...n` as
```
c(ij) = ∑ a(ik)·b(kj) for k = 1..n
```

## Brute force method
The brute force method from the above definition requires computing `n^2` matrix
entries and each is the sum of `n` values. Observe:

```
SQUARE MATRIX MULTIPLY(A, B)
  n = A.rows
  let C = new n x n matrix

  for i = 1 to n:
    for j = 1 to n:
      c(ij) = 0
      for k = 1 to n:
        c(ij) = c(ij) + a(ik)*b(kj)

  return C
```

With 3 nested loops this is a `O(n^3)` runtime.

We can try improve this with the divide and conquer method by splitting the
array into parts and solving their product to see if we can do better.

## Divide and conquer method
We will assume that `n` is a power of 2 and in each divide step we will split
the `n x n` matrices into four `n/2 x n/2` matrices.

Here is how we will split the matrices in `C = A·B`
```
A = A(11) A(12)  B = B(11) B(12)  C = C(11) C(12) (1.1)
    A(21) A(22)      B(21) B(22)      C(21) C(22)
```

Rewriting the equation we get:
```
C(11) C(12) = A(11) A(12) · B(11) B(12)
C(21) C(22)   A(21) A(22)   B(21) B(22)
```

Corresponding to the 4 equations:
```
C(11) = A(11)·B(11) + A(12)·B(21), (1.2)
C(12) = A(11)·B(12) + A(12)·B(22),
C(21) = A(21)·B(11) + A(22)·B(21),
C(22) = A(21)·B(12) + A(22)·B(22)
```

Each of the four equations specifies two multiplications of `n/2 x n/2`
matrices and the addition of their `n/2 x n/2` products.

Using these we can make a recursive matrix multiplication algorithm.

### Pseudo code

```
SQUARE MATRIX MULTIPLY RECURSIVE(A, B)
  n = A.rows
  let C = new n x n matrix

  if n == 1
    return c(11) = a(11) · b(11)

  Partition A, B, and C as in equation 1.1
  C(11) = SQUARE MATRIX MULTIPLY RECURSIVE(A(11), B(11)) + SQUARE MATRIX MULTIPLY RECURSIVE(A(12), B(21))
  C(12) = SQUARE MATRIX MULTIPLY RECURSIVE(A(11), B(12)) + SQUARE MATRIX MULTIPLY RECURSIVE(A(12), B(22))
  C(21) = SQUARE MATRIX MULTIPLY RECURSIVE(A(21), B(11)) + SQUARE MATRIX MULTIPLY RECURSIVE(A(22), B(21))
  C(22) = SQUARE MATRIX MULTIPLY RECURSIVE(A(21), B(12)) + SQUARE MATRIX MULTIPLY RECURSIVE(A(22), B(22))

  return C
```

To partition, we can either do index calculations or create new arrays.
Copying new arrays seems like a worse option as we would need to spend `O(n^2)`
time doing the copy wheras the index calculations are `O(1)`.
In our analysis, we will see that it does not matter.

### Analysis
Let `T(n)` be the time required to multiply two `n x n` matrices.

When `n = 1`, we perform a single scalar multiplication, so `O(1)`.

The recursive case occurs where `n > 1`.
Partitioning the matricies is `O(1)` using index calculations.
We then call the SQUARE MATRIX MULTIPLY RECURSIVE 8 times.

Since each call multiplies two `n/2 x n/2` matrices each taking `T(n/2)` time we
have `8T(n/2)` time taken for the 8 recursive calls.

We then need to account for the 4 matrix additions, taking `O(n^2)` time.
This addition is why it does not matter if we use index partitions or copy the
matrix as we have this `O(n^2)` addition we cannot get around.

Then, using index calculations, we fill array `C` in `O(1)` time.

Putting this together:
```
T(n) = 1 if n = 1
     = 8T(n/2) + O(n^2) if n > 1
```

Using the master theorem, we get `O(n^3)`.

Meaning this is no better than the brute force method.
To improve this, we need to make our recursion tree less bushy, ie: reduce the
8 leaves taking `T(n/2)` time at each level.

## Strassen's method
The key to Strassen's method is to make the recursion tree slightly less bushy.
In it, instead of doing 8 recursive multiplications, we only do 7.

The cost of eliminating one matric multiplication will be several new additions
of `n/2 x n/2` matrices, but still only a constant number of additions.

The method is as follows, and it's complicated:
1. Divide matricies `A`, `B`, and `C` into `n/2 x n/2` sub matrices as in eq
   `1.1`.
2. Create `10` matrices `S1, S2, ..., S10`, each of which is `n/2 x n/2` and is
   the sum or difference of two matrices created in step 1. This can be done in
   `O(n^2)` time.
3. Using the submatrices in step 1 and the 10 from step 2, recursively compute
   seven matrix products `P1, P2, ..., P7`. Each matrix `Pi` is `n/2 x n/2`.
4. Compute the desired submatrices `C(11), C(12), C(21), C(22)` of the result
   matrix `C` by adding and subtracting various combinations of the `P`
   matrices. We can combine them all in `O(n^2)` time.

### Matrices
The following are the matrices we create in step 2:
```
S(1)  = B(12) - B(22),
S(2)  = A(11) + A(12),
S(3)  = A(21) + A(22),
S(4)  = B(21) - B(11),
S(5)  = A(11) + A(22),
S(6)  = B(11) + B(22),
S(7)  = A(12) - A(22),
S(8)  = B(21) + B(22),
S(9)  = A(11) - A(21),
S(10) = B(11) + B(12)
```

In step 3, we recursively multiply matrices 7 times to create the following
`n/2 x n/2` matrices:
```
P(1) = S(1) · A(11) = A(11)·B(12) - A(11)·B(22),
P(2) = S(2) · B(22) = A(11)·B(22) + A(12)·B(22),
P(3) = S(3) · B(11) = A(21)·B(11) + A(22)·B(11),
P(4) = S(4) · A(22) = A(22)·B(21) - A(22)·B(11),
P(5) = S(5) · S(6)  = A(11)·B(11) + A(11)·B(22) + A(22)·B(11) + A(22)·B(22),
P(6) = S(7) · S(8)  = A(12)·B(21) + A(12)·B(22) - A(22)·B(21) - A(22)·B(22),
P(7) = S(9) · S(10) = A(11)·B(11) + A(11)·B(12) - A(21)·B(11) - A(21)·B(12)
```

We then create the `C` matrix by subtracting and adding the `P(i)` matrices.
```
C(11) = P(5) + P(4) - P(2) + P(6)
C(12) = P(1) + P(2)
C(21) = P(3) + P(4)
C(22) = P(5) + P(1) - P(3) - P(7)
```
If you expand each of the above equations out you will find they equal the
equations given by eq `1.2`.

This also shows the algorithm produces the desired result.

### Pseudo code

```
SQUARE MATRIX MULTIPLY STRASSENS(A, B):
  n = A.rows
  let C = new n x n matrix

  if n == 1
    return c(11) = a(11) · b(11)

  Partition A, B, and C as in equation 1.1
  Create 10 S(i) arrays of size n/2 x n/2
  Recursively compute the 7 P(i) products using the S(i), A(11), A(22), B(11),
  and B(22) matrices
  Do additions to get C(11), C(12), C(21), C(22)

  return C
```

### Analysis
We can now set up the recurrence equation for Strassen's method.

Since each of the steps is bounded by `O(n^2)` operations we have:
```
T(n) = 1 if n = 1
     = 7T(n/2) + O(n^2) if n > 1
```

By trading one of the matrix multiplications for a constant number of matrix
additions the new runtime is `O(n^lg(7))` (using the master theorem).

This is better than `O(n^3)`.

## Notes
It should be noted that strassen's algorithm is not often the method of choice
for matrix multiplication because:
1. The constant factor hidden in `O(n^lg(7))` is much larger.
2. When the matrices are sparse methods tailored for sparse matrices are faster.
3. Strassen's algorithmn isn't as numerically stable.
4. The submatricies formed at the levels of recursion consume space.


