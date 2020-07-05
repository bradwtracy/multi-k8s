docker build -t bradwtracy/multi-client:latest -t bradwtracy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bradwtracy/multi-server:latest -t bradwtracy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bradwtracy/multi-worker:latest -t bradwtracy/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bradwtracy/multi-client:latest
docker push bradwtracy/multi-server:latest
docker push bradwtracy/multi-worker:latest

docker push bradwtracy/multi-client:$SHA
docker push bradwtracy/multi-server:$SHA
docker push bradwtracy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bradwtracy/multi-server:$SHA
kubectl set image deployments/client-deployment client=bradwtracy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bradwtracy/multi-worker:$SHA