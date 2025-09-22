#!/bin/bash
# Cleanup script for CloudPrem EKS cluster

set -e

echo "🧹 Cleaning up CloudPrem EKS cluster..."

# Confirm deletion
read -p "Are you sure you want to delete the EKS cluster 'et-demo-cluster'? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Cleanup cancelled"
    exit 1
fi

# Delete the cluster
echo "🗑️  Deleting EKS cluster..."
AWS_PROFILE=dd_sandbox eksctl delete cluster --region us-east-1 --name et-demo-cluster

echo "✅ Cleanup complete!"
echo "💰 AWS resources have been deleted to stop billing"
