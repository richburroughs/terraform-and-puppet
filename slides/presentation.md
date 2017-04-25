footer: Rich Burroughs, SRE at Puppet - @richburroughs

# Terraform and Puppet

## Rich Burroughs

---

![280%](terraform-vertical-color.png)
![20%](puppet-logo-tagline-03.png)

---

## About me

^ Not a Terraform expert, haven't used it in production
^ Not doing a deep dive

---

## Terraform is HashiCorp's provisioning tool

---

![inline](terraformio_site.png)

---

![inline](terraform_book_cover.jpg)

---

## Terraform is like Puppet for provisioning

^ Not exactly the same but it uses a lot of the same concepts
^ Also will be familiar to Vagrant users

---

## Terraform is declarative

---

## Terraform has a DSL

---

## Terraform has a resource graph

---

## Terraform does not have a RAL

---

``` Bash
alias tf='terraform'
```

---

## State

^ local JSON file by default
^ can use Consul or other backends to share state

---

## Providers

^ AWS
^ Azure
^ GCP
^ OpenStack
^ GitHub
^ Pager Duty

---

``` Ruby
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-1"
}
```

---

## Environment variables, credentials file, tfvars

---

``` Ruby
provider "aws" {}
```

---

## Resources

---

``` Ruby
resource "aws_instance" "web" {
  ami           = "${vars.aws.ubuntu.id}"
  instance_type = "t2.micro"
}
```
