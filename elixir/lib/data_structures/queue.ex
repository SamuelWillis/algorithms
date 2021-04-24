defmodule Queue do
  @moduledoc """
  Naive queue implementation.
  """
  defstruct elements: []

  @doc """
  Add an item into a queue.

  ## Examples
   iex> Queue.enqueue(%Queue{elements: []}, "one")
    %Queue{elements: ["one"]}

    iex> Queue.enqueue(%Queue{elements: ["one"]}, "two")
    %Queue{elements: ["two", "one"]}
  """
  def enqueue(%__MODULE__{} = queue, x) do
    %__MODULE__{
      queue
      | elements: [x | queue.elements]
    }
  end

  @doc """
  Remove an item from the queue.

  ## Examples
    iex> Queue.dequeue(%Queue{elements: ["first"]})
    {:ok, "first", %Queue{elements: []}

    iex> Queue.dequeue(%Queue{elements: ["third", "second", "first"]})
    {:ok, "first", %Queue{elements: ["third", "second"]}}

    iex> Queue.dequeue(%Queue{elements: []})
    {:error, "Empty Queue"}
  """
  def dequeue(%__MODULE__{elements: []}), do: {:error, "Empty Queue"}

  # Reverses the list of elements and grabs the "first" queued element and the
  # remainder of the elements. Then reverses the remainder to place them back
  # into their correct order
  def dequeue(%__MODULE__{elements: elements}) do
    [item | elements] = reverse_elements(elements)

    {:ok, item,
     %__MODULE__{
       elements: reverse_elements(elements)
     }}
  end

  defp reverse_elements(elements), do: reverse_elements(elements, [])
  defp reverse_elements([head | tail], reversed), do: reverse_elements(tail, [head | reversed])
  defp reverse_elements([], reversed), do: reversed

  @doc """
  Check the if queue is empty

  ## Examples
    iex> Queue.empty?(%Queue{elements: ["item one"]})
    false

    iex> Queue.empty?(%Queue{elements: []})
    true
  """
  def empty?(%__MODULE__{elements: [_head | _tail]}), do: false
  def empty?(%__MODULE__{elements: []}), do: true
end
