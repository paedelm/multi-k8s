docker build -t paedelm/multi-client:latest -t paedelm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paedelm/multi-server:latest -t paedelm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paedelm/multi-worker:latest -t paedelm/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push paedelm/multi-client:latest
docker push paedelm/multi-server:latest
docker push paedelm/multi-worker:latest

docker push paedelm/multi-client:$SHA
docker push paedelm/multi-server:$SHA
docker push paedelm/multi-worker:$SHA

docker push paedelm/multi-client:d8adb24a94558d9d593bd93c536756e928d84c86
docker push paedelm/multi-server:d8adb24a94558d9d593bd93c536756e928d84c86
docker push paedelm/multi-worker:d8adb24a94558d9d593bd93c536756e928d84c86

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=paedelm/multiclient:$SHA
kubectl set image deployments/server-deployment server=paedelm/multiserver:$SHA
kubectl set image deployments/worker-deployment worker=paedelm/multiworker:$SHA
