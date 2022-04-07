locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${aws_eks_cluster.eks.certificate_authority[0].data}
    server: ${aws_eks_cluster.eks.endpoint}
  name: eks-cluster
contexts:
- context:
    cluster: eks-cluster
    user: terraform-user
  name: eks-cluster
current-context: eks-cluster
kind: Config
preferences: {}
users:
- name: terraform-user
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      args:
      - --region
      - ${var.AWS_REGION}
      - eks
      - get-token
      - --cluster-name
      - ${var.CLUSTER_NAME}
      command: aws
      env:
      - name: AWS_PROFILE
        value: terraform-user
KUBECONFIG
}

output "availability_zones" {
  value = data.aws_availability_zones.az.names
}

output "az_length" {
  value = length(data.aws_availability_zones.az.names)
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "kubeconfig_certificate_authority_data" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}

output "kubeconfig" {
  value = local.kubeconfig
}