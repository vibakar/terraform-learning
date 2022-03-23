data "cloudinit_config" "cloudinit-example" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = templatefile("scripts/init.cfg", {})
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("scripts/docker-install.sh", {})
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("scripts/deploy-application.sh", {})
  }
}
