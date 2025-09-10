module "ec2" {
  source = "./ec2"
  vpc_cidr_range = var.vpc_cidr_range
  availability_zone = var.availability_zone
}
