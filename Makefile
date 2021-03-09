.PHONY: save push

REGISTRY:=registry.crazyzone.be
NAME=helm-ubuntu
VERSION=$(shell yq eval -j Chart.yaml | jq -r .version)
FULLVERSIONNAME=${REGISTRY}/${NAME}:${VERSION}
FULLLATESTNAME=${REGISTRY}/${NAME}:latest

save: 
	HELM_EXPERIMENTAL_OCI=1 helm chart save . ${FULLVERSIONNAME}
	HELM_EXPERIMENTAL_OCI=1 helm chart save . ${FULLLATESTNAME}

push: save
	HELM_EXPERIMENTAL_OCI=1 helm chart push ${FULLVERSIONNAME}
	HELM_EXPERIMENTAL_OCI=1 helm chart push ${FULLLATESTNAME}