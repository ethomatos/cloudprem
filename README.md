# CloudPrem - AWS EKS Infrastructure

A comprehensive AWS EKS (Elastic Kubernetes Service) infrastructure project using eksctl and Kubernetes.

## 🎉 Cluster Status: RUNNING
- **Cluster Name**: `et-demo-cluster`
- **Nodes**: 2 x t3.medium (2 vCPUs, 4GB RAM each)
- **Kubernetes Version**: 1.32.8
- **Region**: us-east-1
- **VPC**: vpc-041f06960858d6a92 (et-customer-vpcs)
- **Cost**: ~$60-80/month

## Project Structure

```
cloudprem/
├── terraform/
│   ├── modules/
│   │   ├── eks/           # EKS cluster module
│   │   ├── vpc/           # VPC networking module
│   │   ├── security-groups/ # Security groups module
│   │   └── iam/           # IAM roles and policies module
│   └── environments/
│       ├── dev/           # Development environment
│       ├── staging/       # Staging environment
│       └── prod/          # Production environment
├── kubernetes/
│   ├── manifests/         # Kubernetes YAML manifests
│   ├── helm-charts/       # Helm charts
│   └── namespaces/        # Namespace definitions
├── scripts/               # Automation scripts
├── docs/                  # Documentation
└── monitoring/            # Monitoring configurations
```

## Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform >= 1.0
- kubectl
- Helm (optional)

## Quick Start

1. **Configure kubectl for existing cluster:**
   ```bash
   aws eks update-kubeconfig --region us-east-1 --name et-demo-cluster --profile dd_sandbox
   ```

2. **Verify cluster access:**
   ```bash
   kubectl get nodes
   ```

3. **Deploy sample applications:**
   ```bash
   ./scripts/deploy.sh
   ```

4. **Access sample nginx app:**
   ```bash
   kubectl port-forward -n demo service/nginx-demo-service 8080:80
   # Visit: http://localhost:8080
   ```

## Environments

- **dev**: Development environment with minimal resources
- **staging**: Staging environment for testing
- **prod**: Production environment with high availability

## Features

- [x] EKS cluster with managed node groups (2 x t3.medium)
- [x] VPC with public subnets for internet access
- [x] Security groups with least privilege access
- [x] IAM roles and policies for EKS
- [x] Core add-ons: vpc-cni, coredns, kube-proxy, metrics-server
- [x] Sample nginx deployment with service
- [x] Deployment and cleanup automation scripts
- [ ] Application Load Balancer integration
- [ ] EBS CSI driver (excluded due to CloudFormation limits - can be added manually if needed)
- [ ] Monitoring and logging setup
- [ ] GitOps integration

## Management Commands

- **Deploy applications**: `./scripts/deploy.sh`
- **Cleanup cluster**: `./scripts/cleanup.sh`
- **View cluster info**: `kubectl cluster-info`
- **View nodes**: `kubectl get nodes`
- **View all resources**: `kubectl get all --all-namespaces`

## Known Limitations

- **EBS CSI Driver**: Not installed due to CloudFormation stack limits in the dd_sandbox account
  - **Impact**: Cannot create persistent volumes using EBS
  - **Workaround**: Use emptyDir volumes or install EBS CSI driver manually after cleanup
  - **Alternative**: Use other storage classes or external storage solutions

## Contributing

1. Create a feature branch
2. Make your changes
3. Test in dev environment
4. Submit a pull request

## License

This project is licensed under the MIT License.
