# Stack
Stacks are a kind of Dynamic Set that operates under the Last In First Out (LIFO) policy.

Simply put, the last object placed onto the stack is the first on to be removed from it.

Popping from an empty stack is known as _underflowing_. Pushing to a full stack
is called _overflowing_.

## Operations

Basic operations are **push** and **pop**.

```
Push(S, x)
  if Full(S) throw Overflow Error
  S[++S.top] = x

Pop(S)
  if Empty(S) throw Underflow Error
  return S[--S.top]

Empty(S)
  if count(S) == 0:
    return True
  else
    return False

Full(S)
  if S.top == S.length
    return True
  else
    return False
```

## Implementation
There are two main ways to implement

### Linked List
Use a linked list.
Pushing an item is just updating to a new head node with the item it's value and
it's tail the old head.
Popping is returning the value of the head and setting the top to the head's
tail.

This is nice because every operation takes constant time in the _worst case_.
However, you use extra time and space to deal with the links.

### Resizing-Array Implementation
Use an array, last element in the array is the top of the stack.

Pushing and popping is a little more complicated.

Pushing requires resizing the array when it is full, a reasonable resize that
gives amortized near constant time is doubling each time it is full.

Popping also requires resizing the array when it is too empty, a reasonable
resizing procedure is halfing the array length when it is only a quarter full.
This also gives near constant amortized time.

This is nice as less space is used, but comes at the cost of O(n) worst case
performace for push and pop.


