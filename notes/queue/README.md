# Queue

Queues are a kind of Dynamic Set that operates under the First In First Out (FIFO) policy.

Simply put, the oldest object in the queue is the first to be removed.

## Operations
The basic operations on a stack are **Enqueue** and **Dequeue**.

### Enqueue
```
Enqueue(Q, x)
  if Queue-Full(Q) throw Overflow Error

  Q[Q.tail] = x
  if Q.tail == Q.length -1
    Q = 0
  else Q.tail++
  return x
```

### Dequeue
```
Dequeue(Q)
  if Queue-Empty(Q) throw Underflow Error

  x = Q[Q.head]
  if Q.head == Q.length - 1
    Q.head = 0
  else Q.head++
  return x

Queue-Empty(Q)
  return Q.tail == Q.head

Queue-Full(Q)
  if Q.head = Q.tail + 1 OR (Q.tail = Q.length - 1 AND Q.head = 0)
    return true
  else
    return false
```

## Implementations
The simplest way is to use a LinkedList.

You will need to track the head and the tail of the list.
I.E. during enqueue you must update the tail and during dequeue you must update
the head.

You can use an array as well but the simplest implementation will be expensive
on dequeue as you will need to shift each element "left" an index.

Alternatively, you could have a queue that "wraps" the array.
Doing this would require "resetting" the indexes when the array is resized and
might be more complicated than needed.
