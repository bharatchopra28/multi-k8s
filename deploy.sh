docker image build -t bharatchopra/multi-client:latest -t bharatchopra/multi-client:$SHA -f ./client/Dockerfile ./client
docker image build -t bharatchopra/multi-server:latest -t bharatchopra/multi-server:$SHA -f ./server/Dockerfile ./server
docker image build -t bharatchopra/multi-worker:latest -t bharatchopra/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker image push bharatchopra/multi-client:latest
docker image push bharatchopra/multi-server:latest
docker image push bharatchopra/multi-worker:latest

docker image push bharatchopra/multi-client:$SHA
docker image push bharatchopra/multi-server:$SHA
docker image push bharatchopra/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=bharatchopra/multi-client:$SHA
kubectl set image deployments/server-deployment server=bharatchopra/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=bharatchopra/multi-worker:$SHA
