# IT 3200 Cyber Lab Infrastructure (Terraform + AWS)

This repository uses Terraform and a reusable module (`./modules/lab_vm`) to provision three distinct virtual machines in AWS using Free Tier-eligible resources (`t3.micro` / `t2.micro`).

## Provisioned Virtual Machines

| VM Role | Resource Name | Operating System | Publisher / Owner ID | AMI Filter / Identifier |
| :--- | :--- | :--- | :--- | :--- |
| **VM 1** | `ubuntu-uvu-it3200-nathan` | Ubuntu Server 24.04 LTS | Canonical (`099720109477`) | `ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*` |
| **VM 2** | `windows-uvu-it3200-nathan` | Windows Server 2022 Base | Amazon (`801119661308`) | `Windows_Server-2022-English-Full-Base-*` |
| **VM 3** | `kali-uvu-it3200-nathan` | Kali Linux (64-bit) | AWS Marketplace (`679593333241`) | `kali-last-snapshot-amd64-*` |

## Terraform Configuration & Variables

Instead of hardcoding region-specific AMI IDs, `main.tf` uses `data "aws_ami"` blocks to dynamically fetch the latest official images in the target AWS region.

Key variables in `variables.tf`:
* `aws_region`: Target AWS region (default: `us-west-2`).
* `student_name`: Student identifier appended to resource names (default: `nathan`).
* `course_id`: Course code included in resource names (default: `it3200`).
* `instance_type`: EC2 instance size (default: `t3.micro`, eligible for AWS Free Tier; can be changed to `t2.micro` if required by region).
* `key_name`: Name of an existing EC2 Key Pair in your AWS account (required for SSH and Windows Administrator password decryption).
* `allowed_cidr`: IPv4 CIDR block permitted to access port `22` (Ubuntu/Kali) or `3389` (Windows) (default: `0.0.0.0/0`).

## Cloud Provider Limitations & Prerequisites

1. **AWS Marketplace Subscription (Kali Linux):**
   * Official Kali Linux AMIs are distributed through the AWS Marketplace (`679593333241`).
   * Before running `terraform apply` for the first time on an AWS account, you must visit the **Kali Linux** listing on the AWS Marketplace and click **Continue to Subscribe** (accepting the $0/hr software terms). Without accepting the Marketplace terms once per AWS account, AWS EC2 will return an `OptInRequired` error.
   * *Note:* While the Kali Linux software license is free ($0/hr), standard AWS EC2 Free Tier usage limits (750 hours/month of `t2.micro`/`t3.micro`) apply across all running instances combined.
2. **Windows Server & Free Tier:**
   * AWS Free Tier includes Windows Server Base AMIs on `t2.micro` or `t3.micro` instances (up to 750 hours/month total).
   * Windows instances require a valid EC2 `key_name` to decrypt the auto-generated Administrator password via the AWS Console or CLI.
3. **AWS Naming Rules:**
   * AWS EC2 instances identify names via the `Name` tag, which supports hyphens and alphanumeric characters. All three instances adhere strictly to `resource-uvu-class-studentname`.

## How to Deploy

### Prerequisites
* [Terraform](https://hashicorp.com) (`>= 1.5.0`) installed.
* [AWS CLI](https://amazon.com) configured with valid credentials (`aws configure`).
* An existing EC2 Key Pair in the target AWS region.
* One-time AWS Marketplace subscription accepted for **Kali Linux**.

### Deployment Steps
1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Review the execution plan:**
   ```bash
   terraform plan -var="key_name=YOUR_AWS_KEY_PAIR_NAME"
   ```

4. **Deploy the infrastructure:**
   ```bash
   terraform apply -var="key_name=YOUR_AWS_KEY_PAIR_NAME" -auto-approve
   ```

5. **Tear down resources when finished (to avoid charges):**
   ```bash
   terraform destroy -var="key_name=YOUR_AWS_KEY_PAIR_NAME" -auto-approve
   ```
