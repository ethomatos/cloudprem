#!/bin/bash
# Deploy script for CloudPrem EKS cluster

set -e

echo "🚀 Deploying to CloudPrem EKS cluster..."

# Check if kubectl is configured
if ! kubectl cluster-info > /dev/null 2>&1; then
    echo "❌ kubectl is not configured or cluster is not accessible"
    echo "Run: aws eks update-kubeconfig --region us-east-1 --name et-demo-cluster --profile dd_sandbox"
    exit 1
fi

echo "✅ Connected to cluster: $(kubectl config current-context)"

# Create namespaces
echo "📦 Creating namespaces..."
kubectl apply -f kubernetes/namespaces/

# Deploy sample application
echo "🔧 Deploying sample applications..."
kubectl apply -f kubernetes/manifests/

# Show status
echo "📊 Cluster status:"
kubectl get nodes
echo
echo "📋 Deployed resources:"
kubectl get all -n demo
echo
echo "🎉 Deployment complete!"
echo "To access the nginx demo: kubectl port-forward -n demo service/nginx-demo-service 8080:80"
