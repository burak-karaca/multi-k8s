docker build -t burakaraca/multi-client:latest -t burakaraca/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t burakaraca/multi-server:latest -t burakaraca/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t burakaraca/multi-worker:latest -t burakaraca/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push burakaraca/multi-client:latest
docker push burakaraca/multi-server:latest
docker push burakaraca/multi-worker:latest

docker push burakaraca/multi-client:$SHA
docker push burakaraca/multi-server:$SHA
docker push burakaraca/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=burakaraca/multi-server:$SHA
kubectl set image deployments/client-deployment client=burakaraca/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=burakaraca/multi-worker:$SHA
