# 60-pos-app.tf  (MODIFICADO)

resource "azurerm_container_app" "pos" {
  name                         = "pos-webapp"
  resource_group_name          = azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.aca_env.id
  revision_mode                = "Single"

  # ➜ 5.1 Habilita la identidad en el Container App
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.acr_pull.id]
  }

  # ➜ 5.2 Registro usando la identidad (no user/pass)
  registry {
    server   = azurerm_container_registry.acr.login_server
    identity = azurerm_user_assigned_identity.acr_pull.id
  }

  # ➜ 5.3 Secreto DB (elige UNA de las dos variantes)
  ## Variante A – Key Vault (si hiciste el paso 4)
  secret {
    name                = "db-url"
    key_vault_secret_id = azurerm_key_vault_secret.db_url.id
    identity            = azurerm_user_assigned_identity.acr_pull.id
  }

  ## Variante B – secreto “local” (si saltaste Key Vault)
  # secret {
  #   name  = "db-url"
  #   value = "postgresql://pgadmin:${random_password.pg_admin.result}@${azurerm_postgresql_flexible_server.db.fqdn}/pos"
  # }

  template {
    min_replicas = 0
    max_replicas = 3

    container {
      name   = "web"
      image  = "${azurerm_container_registry.acr.login_server}/pos-webapp:${var.image_tag}"
      cpu    = 0.5
      memory = "1Gi"

      env {
        name        = "DATABASE_URL"
        secret_name = "db-url" # ← sin value
      }
    }

    http_scale_rule {
      name                = "http-rule"
      concurrent_requests = 50
    }
  }

  ingress {
    external_enabled = true
    target_port      = 3333
    transport        = "auto" # opcional, pero así evitas warnings
    traffic_weight {
      percentage      = 100  # 100 % del tráfico
      latest_revision = true # siempre la revisión más reciente
    }
  }

  tags = { env = "dev" }
}
