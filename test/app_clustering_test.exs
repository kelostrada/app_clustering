defmodule AppClusteringTest do
  use ExUnit.Case
  doctest AppClustering

  test "greets the world" do
    assert AppClustering.hello() == :world
  end
end
