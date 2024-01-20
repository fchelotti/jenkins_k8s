# Jenkins K8S - SUL

## Description

This is the SUL Jenkins K8S configuration. It is used to deploy the SUL Jenkins instance to the production cluster. It is deployed to the `jenkins` namespace.
It is deployed via the `jenkinsSulProd` helm chart.

## Requirements

* Helm 3
* Kubernetes cluster

## Deployment

In the Kubernetes cluster, access the master node and run the following commands:

```bash
helm install jenkins-sul-prod ./jenkinsSulProd
```

## Configuration

The following table lists the configurable parameters of the jenkinsSulProd chart and their default values.
You can configure the chart using the `--set key=value[,key=value]` argument to `helm install`.
The values are also documented in the `jenkinsSulProd\values.yaml` file.

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `replicaCount` | Number of replicas | `1` |
| `image.repository` | Image repository | `fchelotti/jenkins-lts:2.401.2-latest-prod` |
| `image.tag` | Image tag | `lts` |
| `image.pullPolicy` | Image pull policy | `Always` |
| `imagePullSecrets` | Image pull secrets | `secrets` |
| `nameOverride` | Override the name of the chart | `"jenkinsSulProd"` |
| `fullnameOverride` | Override the fullname of the chart | `"jenkinsSulProd"` |
| `serviceAccount.create` | Create a service account | `true` |
| `rbac.create` | Create RBAC resources | `true` |
| `service.type` | Service type | `NodePort` |
| `service.port` | Service port | `8080` |
| `ingress.enabled` | Enable ingress | `true` |
| `persistence.enabled` | Enable persistence | `true` |
| `persistence.existingClaim` | Existing claim name | `"jenkins-prod-pvc"` |
| `persistence.storageClass` | Storage class | `"jenkins-prod-longhorn"` |
| `persistence.accessMode` | Access mode | `ReadWriteMany` |
| `persistence.size` | Size of the volume | `20Gi` |
| `persistence.mountPath` | Mount path for the volume | `/var/jenkins_home` |
| `javaOpts` | Java options | `"-Djenkins.install.runSetupWizard=false"` |
| `jenkinsAgentPort` | Jenkins agent port | `50000` |
| `jenkinsAgentListenerTimeout` | Jenkins agent listener timeout | `10` |

## Upgrading

It is possible to upgrade the chart to a new version. If you have made changes to the chart, you will need to commit them to the repository before upgrading.
To upgrade the chart, run the following commands:

```bash
helm upgrade jenkins-sul-prod ./jenkinsSulProd
```

If you want to change the configuration of the chart, you can use the `--set` argument to `helm upgrade`:

```bash
helm upgrade jenkins-sul-prod ./jenkinsSulProd --set service.type=LoadBalancer
```

## Uninstalling

To uninstall/delete the `jenkins-sul-prod` deployment:

```bash
helm delete jenkins-sul-prod
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## References

* [Jenkins Helm Chart]()
* [Jenkins Helm Chart GitHub Repository]()
