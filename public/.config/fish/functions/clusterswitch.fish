function clusterswitch -d 'Switch the cluster'
	if test (count $argv) -lt 1
		echo 'Please provide an argument'
		return 1
	end

	switch $argv[1]
		case playground
			gcloud container clusters get-credentials playground --zone europe-west1-c --project poki-core
		case core
			gcloud container clusters get-credentials poki-cluster --zone europe-west1-c --project poki-core
		case '*'
			echo Unknown cluster name
	end
end
