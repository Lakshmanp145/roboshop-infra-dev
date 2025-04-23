resource "aws_key_pair" "eks" {
  key_name = "expense-eks"
  #public_key = file("~/.ssh/eks.rsa.pub")
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDc+c92a28ykn+iJLnJz8vWqerIM84Y1hvU3aXGAt+gytjyotBy5t7UpZODpJK3dpQEMy37vbBU/z0q6dLeJV9Mi58svTom7Z2S/k+hBvh5R3E7NhbHMbGwSRrVU5pvOfZblhgsQwujbRujrdJ2fETcNpjdS/Gz+mtQnwNnJNK/R00n7NV+Hy2tvYxrxVpityomk6Xpq8nxL63zAYHi9O4i9N3YFeKC17yPSo7Re4uIlUadjtF2JnBeUMCtcM+xDMLrJPY6ir7lF/x8f1XwbJcmQCduAhA8JodHf8HznQkH/kZ5ggs+rn4aKqOVsYecmUz3pFEJAF0ZjCd/v1HZxVanDbDdc/oyOBoHUl3PaFZ7ebwo8cdEhSoMsdmIK1kNcTWVKQfdsj+K3kxexYpsqmM7I4CopVxe5brBdqy8PIPDSuhmcqX/VPm8UDlsItcYd0X2ZL9SuGnZiXVYbqiZkpAIeSPIvOub+12w671/EI3IPV4w2dfX/W4BVVSXi3/3D28= laxma@LAPTOP-QGKAA2M4"
  
}
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = local.name
  cluster_version = "1.32" # later we upgrade 1.32
  create_node_security_group = false
  create_cluster_security_group = false
  cluster_security_group_id = local.eks_control_plane_sg_id
  node_security_group_id = local.eks_node_sg_id

  # bootstrap_self_managed_addons = false
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
    metrics-server = {} # Horizontal pod autoscaling
  }

  # Optional
  cluster_endpoint_public_access = false

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = local.vpc_id
  subnet_ids               = local.private_subnet_ids
  control_plane_subnet_ids = local.private_subnet_ids

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    # blue = {
    #   # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
    #   # ami_type       = "AL2023_x86_64_STANDARD"
    #   instance_types = ["m5.xlarge"]
    #   key_name= aws_key_pair.eks.key_name

    #   min_size     = 2
    #   max_size     = 10
    #   desired_size = 2
    #   iam_role_additional_policies= {
    #     AmazonEBSCSIDriverPolicy= "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    #     AmazonEFSCSIDriverPolicy= "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
    #     AmazonEKSLoadBalancingPolicy= "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
    #   }

    # }
    green = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      # ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["m5.xlarge"]
      key_name= aws_key_pair.eks.key_name

      min_size     = 2
      max_size     = 10
      desired_size = 2
      iam_role_additional_policies= {
        AmazonEBSCSIDriverPolicy= "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonEFSCSIDriverPolicy= "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        AmazonEKSLoadBalancingPolicy= "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
      }

    }
  }

  tags = merge(
    var.common_tags,
    {
        Name = local.name
    }
  )
}