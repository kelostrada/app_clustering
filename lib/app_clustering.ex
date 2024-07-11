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

  defp cluster_apps(apps, threshold) do
    apps = Enum.into(apps, %{}, fn {id, paths} -> {id, MapSet.new(paths)} end)

    apps
    |> Enum.reduce({apps, [], []}, fn {id, paths}, {remaining_apps, acc, handled_ids} ->
      if id in handled_ids do
        {remaining_apps, acc, handled_ids}
      else
        cluster = find_cluster(paths, remaining_apps, threshold)

        remaining_apps = Map.drop(remaining_apps, cluster)
        acc = [cluster | acc]
        handled_ids = handled_ids ++ cluster

        {remaining_apps, acc, handled_ids}
      end
    end)
    |> elem(1)
  end

  defp find_cluster(paths, remaining_apps, threshold) do
    remaining_apps
    |> Enum.filter(fn {_, paths2} -> Similarity.ratio(paths, paths2) >= threshold end)
    |> Enum.map(&elem(&1, 0))
  end
end
