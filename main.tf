locals {
  workspace_path = "${path.module}/workspaces/${terraform.workspace}.yaml"
  defaults       = file("${path.module}/config.yaml")

  workspace = fileexists(local.workspace_path) ? file(local.workspace_path) : yamlencode({})

  settings = merge(
    yamldecode(local.defaults),
    yamldecode(local.workspace)
  )
}

output "workspace" {
  value = terraform.workspace
}

output "project_settings" {
  value = local.settings
}
