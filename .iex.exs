
# Run the clustering and print the results
file_path = "priv/classifier-sample.json"
clusters = AppClustering.run(file_path)
IO.inspect(clusters)
