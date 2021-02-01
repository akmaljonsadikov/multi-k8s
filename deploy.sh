
docker build -t akmaljonsadikov/multi-client:latest -t akmaljonsadikov/multi-client-$SHA -f ./client/Dockerfile ./client
docker build -t akmaljonsadikov/multi-client:latest -t akmaljonsadikov/multi-server-$SHA -f ./server/Dockerfile ./server
docker build -t akmaljonsadikov/multi-client:latest -t akmaljonsadikov/multi-worker-$SHA -f ./worker/Dockerfile ./worker

docker push akmaljonsadikov/multi-client:latest
docker push akmaljonsadikov/multi-server:latest
docker push akmaljonsadikov/multi-worker:latest

docker push akmaljonsadikov/multi-client:$SHA
docker push akmaljonsadikov/multi-server:$SHA
docker push akmaljonsadikov/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=akmaljonsadikov/multi-server:$SHA
kubectl set image deployments/client-deployment client=akmaljonsadikov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=akmaljonsadikov/multi-worker:$SHA

