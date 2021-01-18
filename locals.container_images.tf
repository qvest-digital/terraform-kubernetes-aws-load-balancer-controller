locals {
  docker_io_image = "docker.io/amazon/aws-alb-ingress-controller:v%s"
  // This mapping contains the base names of all the ECR images that have been put in place
  // by AWS in the different regions. This list has been copied from the Github releases page
  // of the AWS Load Balancer Controller.
  ecr_images = {
    "me-south-1"     = "558608220178.dkr.ecr.me-south-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "eu-south-1"     = "590381155156.dkr.ecr.eu-south-1.amazonaws.com/amazon/aws-load-balancer-controller:%s"
    "ap-northeast-1" = "602401143452.dkr.ecr.ap-northeast-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "ap-northeast-2" = "602401143452.dkr.ecr.ap-northeast-2.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "ap-south-1"     = "602401143452.dkr.ecr.ap-south-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "ap-southeast-1" = "602401143452.dkr.ecr.ap-southeast-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "ap-southeast-2" = "602401143452.dkr.ecr.ap-southeast-2.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "ca-central-1"   = "602401143452.dkr.ecr.ca-central-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "eu-central-1"   = "602401143452.dkr.ecr.eu-central-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "eu-north-1"     = "602401143452.dkr.ecr.eu-north-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "eu-west-1"      = "602401143452.dkr.ecr.eu-west-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "eu-west-2"      = "602401143452.dkr.ecr.eu-west-2.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "eu-west-3"      = "602401143452.dkr.ecr.eu-west-3.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "sa-east-1"      = "602401143452.dkr.ecr.sa-east-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "us-east-1"      = "602401143452.dkr.ecr.us-east-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "us-east-2"      = "602401143452.dkr.ecr.us-east-2.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "us-west-1"      = "602401143452.dkr.ecr.us-west-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "us-west-2"      = "602401143452.dkr.ecr.us-west-2.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "ap-east-1"      = "800184023465.dkr.ecr.ap-east-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "af-south-1"     = "877085696533.dkr.ecr.af-south-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "us-gov-west-1"  = "013241004608.dkr.ecr.us-gov-west-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "us-gov-east-1"  = "151742754352.dkr.ecr.us-gov-east-1.amazonaws.com/amazon/aws-load-balancer-controller:v%s"
    "cn-north-1"     = "918309763551.dkr.ecr.cn-north-1.amazonaws.com.cn/amazon/aws-load-balancer-controller:v%s"
    "cn-northwest-1" = "961992271922.dkr.ecr.cn-northwest-1.amazonaws.com.cn/amazon/aws-load-balancer-controller:v%s"
  }
}
