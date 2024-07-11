defmodule AppClusteringTest do
  use ExUnit.Case
  doctest AppClustering

  describe "group_apps/2" do
    test "groups apps correctly given valid input" do
      apps_data = %{
        "app1" => ["path1", "path2", "path3"],
        "app2" => ["path1", "path2", "path4"],
        "app3" => ["path1", "path3", "path5"],
        "app4" => ["path1"]
      }

      threshold = 0.5

      result = AppClustering.group_apps(apps_data, threshold)

      expected_result = [
        ["app1", "app2", "app3"],
        ["app4"]
      ]

      assert result == expected_result
    end
  end
end
