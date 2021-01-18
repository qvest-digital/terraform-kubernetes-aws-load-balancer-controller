locals {
  aws_load_balancer_controller_version       = var.aws_load_balancer_controller_version
  aws_load_balancer_controller_docker_image  = format(local.ecr_images[data.aws_region.current.name], local.aws_load_balancer_controller_version)
  aws_load_balancer_controller_ingress_class = "alb"

  aws_vpc_id          = data.aws_vpc.selected.id
  aws_region_name     = data.aws_region.current.name
  aws_iam_path_prefix = var.aws_iam_path_prefix == "" ? null : var.aws_iam_path_prefix
}
