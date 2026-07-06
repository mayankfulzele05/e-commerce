module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name                   = local.name
  kubernetes_version     = "1.32"
  endpoint_public_access = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  addons = {
    coredns = {}

    kube-proxy = {}

    vpc-cni = {
      before_compute = true
    }

    eks-pod-identity-agent = {
      before_compute = true
    }
  }

  eks_managed_node_groups = {
    default = {
      instance_types = ["c7i-flex.large"]

      min_size     = 2
      max_size     = 3
      desired_size = 2
    }
  }

  tags = {
    Environment = local.env
    Terraform   = "true"
  }
}

################################################################################
# IAM Role for EBS CSI Driver
################################################################################

module "ebs_csi_driver_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.50"

  role_name             = "${local.name}-ebs-csi-role"
  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn = module.eks.oidc_provider_arn

      namespace_service_accounts = [
        "kube-system:ebs-csi-controller-sa"
      ]
    }
  }
}

################################################################################
# EBS CSI Addon
################################################################################

resource "aws_eks_addon" "ebs_csi_driver" {

  cluster_name = module.eks.cluster_name

  addon_name = "aws-ebs-csi-driver"

  service_account_role_arn = module.ebs_csi_driver_role.iam_role_arn

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [
    module.eks,
    module.ebs_csi_driver_role
  ]
}
