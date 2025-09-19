provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source     = "./modules/vpc"
  project    = var.project
  aws_region = var.aws_region
}

module "sg" {
  source  = "./modules/sg"
  project = var.project
  vpc_id  = module.vpc.vpc_id # 🔴 新增這行，把 VPC ID 傳進去
}

module "eip" {
  source  = "./modules/eip"
  project = var.project
}


module "nat" {
  source        = "./modules/nat"
  project       = var.project
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_ids[0]   # ✅ 改用清單第1個
  private_rt_id = module.vpc.private_route_table_id # add nat to private rt.
}


module "ec2" {
  source              = "./modules/ec2"
  project             = var.project
  vpc_id              = module.vpc.vpc_id
  public_subnet_1_id  = module.vpc.public_subnet_ids[0]
  public_subnet_2_id  = module.vpc.public_subnet_ids[1]
  private_subnet_1_id = module.vpc.private_subnet_ids[0]
  private_subnet_2_id = module.vpc.private_subnet_ids[1]
  manager_key_pair    = var.key_pair_name
  openvpn_sg_id       = module.sg.openvpn_sg_id
  db_sg_id            = module.sg.db_sg_id
  ap_sg_id            = module.sg.ap_sg_id
}

# ✅ 新增：EBS 模組，接收 db instance id 與 AZ 來建立並掛載兩顆 EBS
module "ebs" {
  source  = "./modules/ebs"
  project = var.project

  # EC2 DB-1
  db_1_instance_id       = module.ec2.db_1_instance_id
  db_1_availability_zone = module.ec2.db_1_availability_zone

  # EC2 DB-2
  db_2_instance_id       = module.ec2.db_2_instance_id
  db_2_availability_zone = module.ec2.db_2_availability_zone

  # EC2 NAS
  nas_instance_id       = module.ec2.nas_instance_id
  nas_availability_zone = module.ec2.nas_availability_zone
}

