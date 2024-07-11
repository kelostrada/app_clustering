defmodule AppClustering.Similarity do
  @moduledoc """
  Context for finding similarities in paths
  """

  def create_matrix(apps) do
    apps = Enum.map(apps, fn {id, paths} -> {id, MapSet.new(paths)} end)

    for {id1, paths1} <- apps, {id2, paths2} <- apps, id1 != id2, into: %{} do
      {{id1, id2}, similarity_ratio(paths1, paths2)}
    end
  end

  defp similarity_ratio(paths1, paths2) do
    common_paths_size = paths1 |> MapSet.intersection(paths2) |> MapSet.size()
    all_paths_size = paths1 |> MapSet.union(paths2) |> MapSet.size()
    common_paths_size / all_paths_size
  end
end
