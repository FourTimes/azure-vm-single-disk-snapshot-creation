# azure-os-disk-snapshot-vm

variable change required

    1. config.tfvars
    2. main.tf


```bash
# commands

terraform init
terraform plan -var-file=config.tfvars
terraform apply -var-file=config.tfvars -auto-approve
    
 ```

Specific Environment destroy

```bash

terraform destroy -target module.snapshot-vm-one

```


Specific Environment destroy

```bash

terraform destroy

```
