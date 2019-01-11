docker build -t laposmokus/multi-client:latest -t laposmokus/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t laposmokus/multi-server:latest -t laposmokus/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t laposmokus/multi-worker:latest -t laposmokus/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push laposmokus/multi-client:latest
docker push laposmokus/multi-client:$SHA
docker push laposmokus/multi-server:latest
docker push laposmokus/multi-server:$SHA
docker push laposmokus/multi-worker:latest
docker push laposmokus/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=laposmokus/multi-server:$SHA
kubectl set image deployments/client-deployment server=laposmokus/client-server:$SHA
kubectl set image deployments/worker-deployment server=laposmokus/worker-server:$SHA