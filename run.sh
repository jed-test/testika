URL=$1
echo $URL
if echo $URL | grep -oP 'https://\K\S+' ; then
	docker run --rm \
		-v $(pwd)/wrk:/zap/wrk/:rw \
		-it owasp/zap2docker-stable \
		zap-baseline.py \
		-I -j -m 1 -T 1 \
		-t $URL \
		-J $(echo $URL | sed 's:/*$::' | grep -oP 'https://\K\S+')-base.json

else
	echo "argumet must be URL starting with http(s)://"
	exit 1
fi
