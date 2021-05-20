docker build -t lytvynx/multi-client:latest -t lytvynx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lytvynx/multi-server:latest -t lytvynx/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lytvynx/multi-worker:latest -t lytvynx/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lytvynx/multi-client:latest
docker push lytvynx/multi-server:latest
docker push lytvynx/multi-worker:latest

docker push lytvynx/multi-client:$SHA
docker push lytvynx/multi-server:$SHA
docker push lytvynx/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lytvynx/multi-server:$SHA
kubectl set image deployments/client-deployment client=lytvynx/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lytvynx/multi-worker:$SHA
