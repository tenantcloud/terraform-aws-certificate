# Terraform AWS Certificate Manager for a multiple domain names

Terraform module to create a Certificate from multiple domain with Route53 validation.

## Usage

The `domain_name` and `alternative_names` variables consist of map (object) of
string and list of map of string.

- The **zone** key contains name of hosted zone where the domain belong.
The hosted must be a public one on Route53 in the same AWS account with the
requested certificate.
- The **domain** key contains domain name that will be used in the certificate
whether in the domain name or subject alternative names section.

Create `certificate.tf` file

```terraform
module "certificate" {
    source = "tenantcloud/certificate/aws"

    region              = var.region
    domain_name         = var.domain_name
    alternative_names   = var.alternative_names
    tags                = var.tags
}
```

Also you need create `app.tfvars` file. Example

```terraform
region = "us-west-2"

domain_name = {
    zone = "demo.com"
    domain = "demo.com"
}

alternative_names = [
    {
        zone = "demo.com"
        domain = "*.demo.com"
    },
    {
        zone = "demo.site"
        domain = "demo.site"
    },
    {
        zone =  "demo.site"
        domain = "*.demo.site"
    }
]

tags = "Certificate for a multiple domain name"
```

## Examples

- [Basic usage example](./examples/basic/)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain\_name | Domain name for the ACM certificate | `map(string)` | n/a | yes |
| alternative\_names | List of alternative domain names for the ACM certificate | `list(map(string))` | n/a | yes |
| tags | Key and value pair that will be added as tag | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| certificate\_arn | The ARN of the certificate |
| certificate\_domain\_validation\_options | A list of attributes to feed into other resources to complete certificate validation |
| certificate\_domains | List of domain names covered by the certificate |
