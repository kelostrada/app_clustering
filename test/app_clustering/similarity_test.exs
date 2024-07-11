defmodule AppClustering.SimilarityTest do
  use ExUnit.Case
  alias AppClustering.Similarity

  describe "ratio/2" do
    for {paths1, paths2, threshold, name} <- [
          {[], [], 0, "empty paths"},
          {["a"], [], 0, "first empty paths"},
          {[], ["a"], 0, "second empty paths"},
          {["a", "b", "d"], ["a", "b", "c"], 0.5, "regular ratio"},
          {["a", "b", "c"], ["a", "b", "c"], 1.0, "all paths equal"},
          {Enum.to_list(1..100_000), Enum.to_list(1..100_000), 1.0, "big sets"}
        ] do
      test "calculates ratio by paths for #{name}" do
        paths1 = MapSet.new(unquote(paths1))
        paths2 = MapSet.new(unquote(paths2))

        assert unquote(threshold) == Similarity.ratio(paths1, paths2)
      end
    end
  end
end
