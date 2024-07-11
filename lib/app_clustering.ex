defmodule AppClustering do
  @moduledoc """
  Module to cluster mobile apps based on their file path structures.
  """
  alias AppClustering.Similarity

  @doc """
  Group apps by comparing their file path structures by using a given threshold.
  Resulting groups are ordered by their size.
  """
  @spec group_apps(map(), float()) :: list(list(String.t()))
  def group_apps(apps_data, threshold) do
    apps_data
    |> cluster_apps(threshold)
    |> Enum.sort_by(&length(&1), :desc)
  end

  def cluster_apps(apps, threshold) do
    apps
    |> Similarity.create_matrix()
    |> Enum.group_by(
      fn {{id1, _}, _} -> id1 end,
      fn {{_id1, id2}, similarity} -> {id2, similarity} end
    )
    |> Enum.reduce(MapSet.new(), fn {id, similarities}, acc ->
      cluster =
        similarities
        |> Enum.filter(fn {_id, similarity} -> similarity >= threshold end)
        |> Enum.map(&elem(&1, 0))

      MapSet.put(acc, MapSet.new([id | cluster]))
    end)
    |> Enum.map(&MapSet.to_list/1)
  end
end
