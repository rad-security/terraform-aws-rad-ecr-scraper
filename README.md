# terraform-aws-rad-ecr-scraper
The module allows you to connect your AWS ECR registry to Rad Security to allow them to scan images in it.

## Terraform Registry

This module is available in the [Terraform Registry](https://registry.terraform.io/) see [here](https://registry.terraform.io/modules/rad-security/rad-ecr-scraper/aws/latest).

## Contributing

The most important thing to be aware of when contributing is that we leverage the [Semantic Release Action](https://github.com/cycjimmy/semantic-release-action) to automate our changelog, see [here](CHANGELOG.md).

This requires us to use [conventional git commits](https://www.conventionalcommits.org/en/v1.0.0/) when committing to this repository.

Each PR merge into the `main` branch will execute the release process defined [here](.github/workflows/release.yml).

## Usage

This module needs an AWS provider to be configured. It will create an IAM Role in your account called `rad-ecr-scraper`. The IAM Role has fine-grained policies attached (prefixed with `rad-security_ecr_policy`), which will allow the `imagescan-scraper` role in Rad Security's AWS account to assume the permissions necessary to interact with ECR resources in your account.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.ecr_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.rad_ecr_scraper](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecr_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecr_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_external_id"></a> [aws\_external\_id](#input\_aws\_external\_id) | External ID to use when connecting an AWS account with Rad Security. | `string` | `""` | no |
| <a name="input_rad-security_assumed_role_arn"></a> [rad-security\_assumed\_role\_arn](#input\_rad-security\_assumed\_role\_arn) | Rad Security Role that will assume the rad-security-connect IAM role you create to interact with resources in your account. | `string` | `"arn:aws:iam::955322216602:role/imagescan-scraper"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A set of tags to associate with the resources in this module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | AWS IAM Role ARN which Rad Security uses to scan ECR registry. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License
Apache 2 Licensed. See [LICENSE](LICENSE) for full details.
