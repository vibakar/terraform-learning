data "cloudinit_config" "frontend" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content = templatefile("scripts/frontend.sh", {
      BACKEND_SERVER_ENDPOINT = var.APPLICATION_DOMAIN.BACKEND
    })
  }
}

data "cloudinit_config" "backend" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("scripts/backend.sh", {})
  }
}