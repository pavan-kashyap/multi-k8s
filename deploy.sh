docker build -t pavankashyap/multi-client:latest -t pavankashyap/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pavankashyap/multi-server:latest -t pavankashyap/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pavankashyap/multi-worker:latest -t pavankashyap/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pavankashyap/multi-client:latest
docker push pavankashyap/multi-server:latest
docker push pavankashyap/multi-worker:latest

docker push pavankashyap/multi-client:$SHA
docker push pavankashyap/multi-server:$SHA
docker push pavankashyap/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pavankashyap/multi-server:$SHA
kubectl set image deployments/client-deployment client=pavankashyap/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pavankashyap/multi-worker:$SHA
