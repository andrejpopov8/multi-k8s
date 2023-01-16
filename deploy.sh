docker build -t andrejpopov/multi-client:latest -t andrejpopov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andrejpopov/multi-server:latest -t andrejpopov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andrejpopov/multi-worker:latest -t andrejpopov/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push andrejpopov/multi-client:latest
docker push andrejpopov/multi-client:$SHA
docker push andrejpopov/multi-server:latest
docker push andrejpopov/multi-server:$SHA
docker push andrejpopov/multi-worker:latest
docker push andrejpopov/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andrejpopov/multi-server:$SHA
kubectl set image deployments/client-deployment client=andrejpopov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=andrejpopov/multi-worker:$SHA