TAG="2023.08.0.167214_3.2.51_20230809"

CONTAINER="cbflow-agent"
docker build  -t rbroker/${CONTAINER}:${TAG} --build-arg TAG="${TAG}" .

docker login --username $DOCKER_USER --password $DOCKER_PASSWORD docker.io
echo "docker push rbroker/${CONTAINER}:${TAG}"
docker push rbroker/${CONTAINER}:${TAG}