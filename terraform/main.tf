terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 5.0"
    }
  }
}

provider "oci" {
  region       = "us-ashburn-1" #mudar para a região que criamo na Oracle Cloud
  tenancy_ocid = "ocid1.tenancy.oc1..exemplo"
  user_ocid    = "ocid1.user.oc1..exemplo"
  fingerprint  = "xx:xx:xx:xx:xx:xx:xx:xx"
  private_key_path = "~/.oci/oci_api_key.pem"
}

resource "oci_core_instance" "web_server" {
  compartment_id      = "ocid1.compartment.oc1..exemplo"
  availability_domain = "UHsC:US-ASHBURN-AD-1"
  shape               = "VM.Standard.E2.1.Micro" #OCPUs e RAM iguais a que colocamo

  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.exemplo" #(mudar)imagem do ubuntu na OCI
  }

  display_name = "servidor-trabalho-castelo"
  
  metadata = {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc..."
  }
}

output "public_ip" {
  value = oci_core_instance.web_server.public_ip
}