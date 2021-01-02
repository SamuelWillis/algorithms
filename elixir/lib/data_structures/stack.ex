defmodule ElixirImpl.DataStructure.Stack do
  @moduledoc """
  Stack implementation.
  This is essentially sugar for Elixir Lists, but is here to show how basic
  operations should work on a stack.
  """
  defstruct elements: []

  @typep t :: %__MODULE__{
           elements: [any()]
         }

  @doc """
  Push an item onto a stack.

  ## Examples
    iex> Stack.push(%Stack{elements: []}, "one")
    %Stack{elements: ["one"]}

    iex> Stack.push(%Stack{elements: ["one"]}, "two")
    %Stack{elements: ["two", "one"]}
  """
  @spec push(__MODULE__.t(), any()) :: __MODULE__.t()
  def push(%__MODULE__{} = stack, x) do
    %__MODULE__{
      stack
      | elements: [x | stack.elements]
    }
  end

  @doc """
  Pop an item off the top of the stack

  ## Examples
    iex> Stack.pop(%Stack{elements: ["item one"]})
    {:ok, "item one", %Stack{elements: []}}

    iex> Stack.pop(%Stack{elements: ["item two", "item one"]})
    {:ok, "item two", %Stack{elements: ["item one"]}}

    iex> Stack.pop(%Stack{elements: []})
    {:error, "Empty Stack"}
  """
  @spec pop(__MODULE__.t()) :: {:error, String.t()} | {:ok, any(), __MODULE__.t()}
  def pop(%__MODULE__{elements: []}), do: {:error, "Empty Stack"}
  def pop(%__MODULE__{elements: [top | rest]}), do: {:ok, top, %__MODULE__{elements: rest}}

  @doc """
  Check if stack is empty

  ## Examples
    iex> Stack.empty?(%Stack{elements: ["item one"]})
    false

    iex> Stack.empty?(%Stack{elements: []})
    true
  """
  def empty?(%__MODULE__{elements: [_head | _tail]}), do: false
  def empty?(%__MODULE__{elements: []}), do: true
end
