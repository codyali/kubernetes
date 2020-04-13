docker build -t liyakatsahil/multi-client:latest -t liyakatsahil/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t liyakatsahil/multi-server:latest -t liyakatsahil/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t liyakatsahil/multi-worker:latest -t liyakatsahil/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push iyakatsahil/multi-client:latest
docker push iyakatsahil/multi-server:latest
docker push iyakatsahil/multi-worker:latest
docker push iyakatsahil/multi-client:$SHA
docker push iyakatsahil/multi-server:$SHA
docker push iyakatsahil/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployments server=liyakatsahil/multi-server:$SHA
kubectl set image deployments/client-deployments client=liyakatsahil/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=liyakatsahil/multi-worker:$SHA