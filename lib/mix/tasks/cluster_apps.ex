defmodule Mix.Tasks.ClusterApps do
  @moduledoc """
  This task loads a file which contains file structures for mobile apps.
  The file should be a JSON map containing app IDs as keys and
  arrays with file paths as a value.

  ## Example:

  ```
  {
    "123": ["/app/test.txt", "app/test2.exe"],
    "234": ["/app/test.txt", "app/test3.exe"]
  }
  ```

  To start the task you need to run:

      $ mix cluster_apps priv/classifier-sample.json

  ## Command line options

  - -t, --threshold - set how big the threshold should be for similarities between file path structures (default 0.7)
  """

  use Mix.Task

  @shortdoc "Load file with apps file structures and cluster them by IDs and their similarities to each other"

  def run(options) do
    case OptionParser.parse(options, strict: [threshold: :float], aliases: [t: :threshold]) do
      {opts, [file_path], _} ->
        threshold = Keyword.get(opts, :threshold, 0.7)

        file_path
        |> File.read!()
        |> Jason.decode!()
        |> AppClustering.group_apps(threshold)
        |> Jason.encode!(pretty: true)
        |> Mix.shell().info()

      _ ->
        Mix.shell().error("Incorrect options provided. Please provide a file path.")
    end
  end
end
