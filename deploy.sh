docker image build -t bharatchopra/mutli-client:latest -t bharatchopra/mutli-client:$SHA -f ./client/Dockerfile ./client
docker image build -t bharatchopra/mutli-server:latest -t bharatchopra/mutli-server:$SHA -f ./server/Dockerfile ./server
docker image build -t bharatchopra/mutli-worker:latest -t bharatchopra/mutli-worker:$SHA -f ./worker/Dockerfile ./worker

docker image push bharatchopra/mutli-client:latest
docker image push bharatchopra/mutli-server:latest
docker image push bharatchopra/mutli-worker:latest

docker image push bharatchopra/mutli-client:$SHA
docker image push bharatchopra/mutli-server:$SHA
docker image push bharatchopra/mutli-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=bharatchopra/mutli-client:$SHA
kubectl set image deployments/server-deployment server=bharatchopra/mutli-server:$SHA
kubectl set image deployments/worker-deployment worker=bharatchopra/mutli-worker:$SHA
