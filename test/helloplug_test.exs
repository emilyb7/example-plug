defmodule HelloplugTest do
  use ExUnit.Case
  doctest Helloplug

  test "greets the world" do
    assert Helloplug.hello() == :world
  end
end
