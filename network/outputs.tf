output "Lab2_public_subnet_ids" {
  value = module.vpc-Lab2.public_subnet_ids
}

output "prod_private_subnet_ids" {
  value = module.vpc-Lab2.private_subnet_ids
}

output "vpc_id" {
  value = module.vpc-Lab2.vpc_id
}

