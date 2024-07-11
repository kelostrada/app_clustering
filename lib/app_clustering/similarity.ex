defmodule AppClustering.Similarity do
  @moduledoc """
  Context for finding similarities in paths
  """

  @doc """
  Naive ratio calculation for paths. Takes all paths into consideration from two
  sources and returns the ratio of the same common paths.

  Perhaps worth considering the size of the intersection as a next step. For instance
  one source could have a lot of additional code but still use the same common paths
  for the whitelabeled app.
  """
  @spec ratio(MapSet.t(), MapSet.t()) :: float()
  def ratio(%MapSet{} = paths1, %MapSet{} = paths2) do
    common_paths_size = paths1 |> MapSet.intersection(paths2) |> MapSet.size()
    all_paths_size = paths1 |> MapSet.union(paths2) |> MapSet.size()
    if all_paths_size > 0 do
      common_paths_size / all_paths_size
    else
      0.0
    end
  end
end
