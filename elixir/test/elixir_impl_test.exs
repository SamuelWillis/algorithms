defmodule ElixirImplTest do
  use ExUnit.Case
  doctest ElixirImpl

  test "greets the world" do
    assert ElixirImpl.hello() == :world
  end
end
