docker build -t pumba94/multi-client:latest -t pumba94/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pumba94/multi-server:latest -t pumba94/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pumba94/multi-worker:latest -t pumba94/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pumba94/multi-client:latest
docker push pumba94/multi-server:latest
docker push pumba94/multi-worker:latest

docker push pumba94/multi-client:$SHA
docker push pumba94/multi-server:$SHA
docker push pumba94/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pumba94/multi-server:$SHA
kubectl set image deployments/client-deployment client=pumba94/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pumba94/multi-worker:$SHA