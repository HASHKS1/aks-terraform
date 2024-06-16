resource "local_file" "templates" {
    depends_on = [ 
        azurerm_kubernetes_cluster.k8s,
        azurerm_user_assigned_identity.uai_aks
     ]
    for_each = fileset(path.module, "k8s/*.yaml")

    content = templatefile(each.key, {
        uai-aks-clientid = azurerm_user_assigned_identity.uai_aks.client_id
        tenant_id  = var.tenant_id
    })
    filename = "${path.module}/${each.key}"
}


resource "null_resource" "k8s_deploy" {
  depends_on = [
    azurerm_kubernetes_cluster.k8s,
    azurerm_key_vault.aks_kv,
    helm_release.ingress_nginx_controller,
    helm_release.cert_manager,
    local_file.templates
  ]
  triggers = {
    shell_hash = "${sha256(file("${path.module}/k8s_deploy.sh"))}"
  }
  provisioner "local-exec" {
    command     = "sleep 120; chmod +x ./k8s_deploy.sh; ./k8s_deploy.sh"
    interpreter = ["/bin/bash", "-c"]
  }
}