## 🛠️ How to Use

### Initialize Remote Backend

Navigate to the `backend-state` folder:
cd backend-state
terraform init
terraform apply

Navigate to the main infrastructure directory:
cd ../ec2-with-elb
terraform init
terraform apply -target="data.aws_subnets.default_subnets"
terraform apply
