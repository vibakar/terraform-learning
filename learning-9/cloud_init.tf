data "template_cloudinit_config" "cloudinit-example" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.script1.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.script2.rendered
  }
}

data "template_file" "script1" {
  template = file("scripts/init.cfg")
  vars = {
    REGION = var.AWS_REGION
  }
}

data "template_file" "script2" {
  template = file("scripts/volumes.sh")
  vars = {
    DEVICE = var.INSTANCE_DEVICE_NAME
  }
}
