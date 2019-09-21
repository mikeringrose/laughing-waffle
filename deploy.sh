docker build -t geemike/multi-client:latest -t geemike/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t geemike/multi-server:latest -t geemike/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t geemike/multi-worker:latest -t geemike/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push geemike/multi-client:latest
docker push geemike/multi-server:latest
docker push geemike/multi-worker:latest

docker push geemike/multi-client:$SHA
docker push geemike/multi-server:$SHA
docker push geemike/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=geemike/multi-server:$SHA
kubectl set image deployments/client-deployment client=geemike/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=geemike/multi-worker:$SHA
