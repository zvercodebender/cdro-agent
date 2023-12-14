TAG="2023.10.0.169425_3.2.54_20231002"

CONTAINER="cbflow-agent"
docker build  -t rbroker/${CONTAINER}:${TAG} --build-arg TAG="${TAG}" .

docker login --username $DOCKER_USER --password $DOCKER_PASSWORD docker.io
echo "docker push rbroker/${CONTAINER}:${TAG}"
docker push rbroker/${CONTAINER}:${TAG}