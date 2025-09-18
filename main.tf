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
  source    = "./modules/nat"
  project   = var.project
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_ids[0] # ✅ 改用清單第1個
  # 如果你想用第二個 AZ 的 public 子網，就改成 [1]
  # eip_id = module.eip.eip_nat_id # ✅ 改對輸出名稱
  # 可選：避免 race 的明確依賴
  # depends_on = [module.vpc, module.eip] # ✅ module 層級才用 depends_on

  private_rt_id = module.vpc.private_route_table_id # add nat to private rt.
  # nat_gateway_id = module.nat.nat_gateway_id
}


module "ec2" {
  source              = "./modules/ec2"
  project             = var.project
  vpc_id              = module.vpc.vpc_id
  public_subnet_1_id  = module.vpc.public_subnet_ids[0]
  private_subnet_1_id = module.vpc.private_subnet_ids[0]
  manager_key_pair    = var.key_pair_name
  openvpn_sg_id       = module.sg.openvpn_sg_id
  db_sg_id            = module.sg.db_sg_id
  ap_sg_id            = module.sg.ap_sg_id
  #  eip_openvpn_id      = module.eip.eip_openvpn_id
}

# ✅ 新增：EBS 模組，接收 db instance id 與 AZ 來建立並掛載兩顆 EBS
module "ebs" {
  source = "./modules/ebs"
  #  project = var.project

  # EC2 DB
  #  instance_id       = module.ec2.db_instance_id
  #  availability_zone = module.ec2.db_availability_zone
}

