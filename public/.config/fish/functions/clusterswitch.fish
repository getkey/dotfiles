function clusterswitch -d 'Switch the cluster'
	if test (count $argv) -lt 1
		echo 'Please provide an argument'
		return 1
	end

	switch $argv[1]
		case production
			gcloud container clusters get-credentials us-prod --zone us-east1-c --project poki-core
		case acceptance
			gcloud container clusters get-credentials us-acceptance --zone us-east1-c --project poki-core
		case staging
			gcloud container clusters get-credentials us-staging --zone us-east1-c --project poki-core
		case misc
			gcloud container clusters get-credentials europe-misc --zone europe-west1-c --project poki-core
		case '*'
			echo Unknown cluster name
	end
end
