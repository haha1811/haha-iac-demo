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
}

# RDS 模組
module "rds" {
  source                 = "./modules/rds"
  project                = var.project
  private_subnet_ids     = module.vpc.private_subnet_ids
  db_sg_id               = module.sg.db_sg_id
  alarm_sns_topic_arn    = module.sns.alarm_topic_arn
  aurora_db_name         = var.aurora_db_name
  aurora_master_username = var.aurora_master_username
  aurora_master_password = var.aurora_master_password
}

# SNS 模組
module "sns" {
  source      = "./modules/sns"
  project     = var.project
  alert_email = var.alert_email
}

# Cloud9 模組 
# → 建完後會一直跳錯誤！
# 只能透過手動 Delete Cloud9 後，把 cloud9.tf 設定值 del 才能正常執行。 
module "cloud9" {
  source             = "./modules/cloud9"
  project            = var.project
  public_subnet_1_id = module.vpc.public_subnet_ids[0]
}
