resource "kubernetes_service_account" "this" {
  automount_service_account_token = true
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = var.k8s_namespace
    annotations = {
      # This annotation is only used when running on EKS which can
      # use IAM roles for service accounts.
      "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn
    }
    labels = {
      "app.kubernetes.io/component"  = "controller"
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "kubernetes_role" "this" {

  metadata {
    name      = "aws-load-balancer-controller-leader-election-role"
    namespace = var.k8s_namespace
    labels = {
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["create"]
  }

  rule {
    api_groups     = [""]
    resource_names = ["aws-load-balancer-controller-leader"]
    resources      = ["configmaps"]
    verbs          = ["get", "update", "patch"]
  }

}

resource "kubernetes_role_binding" "this" {

  metadata {
    name      = "aws-load-balancer-controller-leader-election-rolebinding"
    namespace = kubernetes_role.this.metadata[0].namespace
    labels = {
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.this.metadata[0].name
  }

  subject {
    api_group = ""
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.this.metadata[0].name
    namespace = kubernetes_service_account.this.metadata[0].namespace
  }

}

resource "kubernetes_cluster_role" "this" {

  metadata {
    name = "aws-load-balancer-controller"

    labels = {
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  rule {
    api_groups = [
      ""
    ]

    resources = [
      "endpoints",
    ]

    verbs = [
      "get",
      "list",
      "watch"
    ]
  }

  rule {
    api_groups = [
      ""
    ]

    resources = [
      "events",
    ]

    verbs = [
      "create",
      "patch"
    ]
  }

  rule {
    api_groups = [
      ""
    ]

    resources = [
      "namespaces",
    ]

    verbs = [
      "get",
      "list",
      "watch"
    ]
  }

  rule {
    api_groups = [
      ""
    ]

    resources = [
      "nodes",
    ]

    verbs = [
      "get",
      "list",
      "watch"
    ]
  }

  rule {
    api_groups = [
      ""
    ]

    resources = [
      "pods",
    ]

    verbs = [
      "get",
      "list",
      "watch"
    ]
  }

  rule {
    api_groups = [
      ""
    ]

    resources = [
      "pods/status",
    ]

    verbs = [
      "patch",
      "update"
    ]
  }

  rule {
    api_groups = [
      ""
    ]

    resources = [
      "secrets",
    ]

    verbs = [
      "get",
      "list",
      "watch"
    ]
  }

  rule {
    api_groups = [
      ""
    ]

    resources = [
      "services",
    ]

    verbs = [
      "get",
      "list",
      "patch",
      "update",
      "watch"
    ]
  }

  rule {
    api_groups = [
      ""
    ]

    resources = [
      "services/status",
    ]

    verbs = [
      "patch",
      "update"
    ]
  }

  rule {
    api_groups = [
      "elbv2.k8s.aws"
    ]

    resources = [
      "targetgroupbindings",
    ]

    verbs = [
      "create",
      "delete",
      "get",
      "list",
      "patch",
      "update",
      "watch"
    ]
  }

  rule {
    api_groups = [
      "elbv2.k8s.aws"
    ]

    resources = [
      "targetgroupbindings/status",
    ]

    verbs = [
      "patch",
      "update"
    ]
  }

  rule {
    api_groups = [
      "extensions"
    ]

    resources = [
      "ingresses",
    ]

    verbs = [
      "get",
      "list",
      "patch",
      "update",
      "watch"
    ]
  }

  rule {
    api_groups = [
      "extensions"
    ]

    resources = [
      "ingresses/status",
    ]

    verbs = [
      "patch",
      "update"
    ]
  }

  rule {
    api_groups = [
      "networking.k8s.io"
    ]

    resources = [
      "ingressclasses",
    ]

    verbs = [
      "get",
      "list",
      "watch"
    ]
  }

  rule {
    api_groups = [
      "networking.k8s.io"
    ]

    resources = [
      "ingresses",
    ]

    verbs = [
      "get",
      "list",
      "patch",
      "update",
      "watch"
    ]
  }

  rule {
    api_groups = [
      "networking.k8s.io"
    ]

    resources = [
      "ingresses/status",
    ]

    verbs = [
      "patch",
      "update"
    ]
  }

}



resource "kubernetes_cluster_role_binding" "this" {
  metadata {
    name = "aws-load-balancer-controller"

    labels = {
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.this.metadata[0].name
  }

  subject {
    api_group = ""
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.this.metadata[0].name
    namespace = kubernetes_service_account.this.metadata[0].namespace
  }
}

resource "kubernetes_service" "this" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = var.k8s_namespace

    labels = {
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
      "app.kubernetes.io/version"    = "v${local.aws_load_balancer_controller_version}"
      "app.kubernetes.io/managed-by" = "terraform"
    }

    annotations = {
      "field.cattle.io/description" = "AWS Load Balancer Controller"
    }
  }
  spec {
    port {
      name        = "webhook-server"
      port        = 443
      protocol    = "TCP"
      target_port = "webhook-server"
    }
    selector = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/name"      = "aws-load-balancer-controller"
    }
  }
}

resource "kubernetes_deployment" "this" {
  depends_on = [
    kubernetes_role_binding.this,
    kubernetes_cluster_role_binding.this
  ]

  metadata {
    name      = "aws-load-balancer-controller"
    namespace = var.k8s_namespace

    labels = {
      "app.kubernetes.io/component"  = "controller"
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
      "app.kubernetes.io/version"    = "v${local.aws_load_balancer_controller_version}"
      "app.kubernetes.io/managed-by" = "terraform"
    }

    annotations = {
      "field.cattle.io/description" = "AWS Load Balancer Controller"
    }
  }

  spec {

    replicas = var.k8s_replicas

    selector {
      match_labels = {
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/name"      = "aws-load-balancer-controller"
      }
    }

    strategy {
      type = "Recreate"
    }

    template {
      metadata {
        labels = merge(
          {
            "app.kubernetes.io/component" = "controller"
            "app.kubernetes.io/name"      = "aws-load-balancer-controller"
            "app.kubernetes.io/version"   = local.aws_load_balancer_controller_version
          },
          var.k8s_pod_labels
        )
        annotations = merge(
          {
            # Annotation which is only used by KIAM and kube2iam.
            # Should be ignored by your cluster if using IAM roles for service accounts, e.g.
            # when running on EKS.
            "iam.amazonaws.com/role" = aws_iam_role.this.arn
          },
          var.k8s_pod_annotations
        )
      }

      spec {
        affinity {
          pod_anti_affinity {
            preferred_during_scheduling_ignored_during_execution {
              weight = 100
              pod_affinity_term {
                label_selector {
                  match_expressions {
                    key      = "app.kubernetes.io/name"
                    operator = "In"
                    values   = ["aws-load-balancer-controller"]
                  }
                }
                topology_key = "kubernetes.io/hostname"
              }
            }
          }
        }

        automount_service_account_token = true

        dns_policy = "ClusterFirst"

        restart_policy = "Always"

        container {
          name                     = "controller"
          image                    = local.aws_load_balancer_controller_docker_image
          image_pull_policy        = "Always"
          termination_message_path = "/dev/termination-log"

          args = [
            "--ingress-class=${local.aws_load_balancer_controller_ingress_class}",
            "--cluster-name=${var.k8s_cluster_name}",
            "--aws-vpc-id=${local.aws_vpc_id}",
            "--aws-region=${local.aws_region_name}",
            "--aws-max-retries=10",
          ]

          liveness_probe {
            http_get {
              path   = "/healthz"
              port   = "health"
              scheme = "HTTP"
            }

            initial_delay_seconds = 30
            timeout_seconds       = 10
          }

          port {
            name           = "webhook-server"
            container_port = 9443
            protocol       = "TCP"
          }

          port {
            name           = "health"
            container_port = 61779
            protocol       = "TCP"
          }

          resources {
            limits {
              cpu    = "200m"
              memory = "500Mi"
            }
            requests {
              cpu    = "100m"
              memory = "200Mi"
            }
          }

          security_context {
            allow_privilege_escalation = false
            read_only_root_filesystem  = true
            run_as_non_root            = true
          }

        }

        security_context {
          fs_group = 1337
        }

        service_account_name             = kubernetes_service_account.this.metadata[0].name
        termination_grace_period_seconds = 60
      }
    }
  }
}
