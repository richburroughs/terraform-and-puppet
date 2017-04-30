resource "openstack_compute_instance_v2" "mom" {
  name            = "pe-mom"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  key_pair        = "${var.key_pair}"
  security_groups = "${var.security_groups}"

  network {
    name = "${var.network_name}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash -c \"/usr/bin/echo '${self.access_ip_v4} pe-mom.example.com pe-mom' >> /etc/hosts\"",
      "sudo yum install -y wget",
      "wget http://packages.example.com/archives/releases/${var.pe_version}/puppet-enterprise-${var.pe_version}-el-7-x86_64.tar.gz",
      "tar xvfz puppet-enterprise-${var.pe_version}-el-7-x86_64.tar.gz",
      "sed 's/\"console_admin_password\": \"\"/\"console_admin_password\": \"${var.console_admin_password}\"/' puppet-enterprise-${var.pe_version}-el-7-x86_64/conf.d/pe.conf > pe.conf.tmp",
      "cp pe.conf.tmp puppet-enterprise-${var.pe_version}-el-7-x86_64/conf.d/pe.conf",
      "sudo puppet-enterprise-${var.pe_version}-el-7-x86_64/puppet-enterprise-installer -y -c puppet-enterprise-${var.pe_version}-el-7-x86_64/conf.d/pe.conf",
      "sudo bash -c \"/opt/puppetlabs/bin/puppet agent -t || true \"",
      "sudo bash -c \"/usr/bin/echo '*.example.com' >> /etc/puppetlabs/puppet/autosign.conf\"",
    ]

    connection {
      user        = "centos"
      private_key = "${file(var.private_key)}"
      agent       = false
      timeout     = "20s"
    }
  }
}

resource "openstack_compute_floatingip_v2" "fip_1" {
  pool = "${var.fip_pool}"
}

resource "openstack_compute_floatingip_associate_v2" "fip_assoc_1" {
  floating_ip = "${openstack_compute_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.mom.id}"
}

