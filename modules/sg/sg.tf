###########
## ap-sg ##
###########
resource "aws_security_group" "ap_sg" {
  name   = "${var.project}-ap-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # ✅ 允許 all traffic
    cidr_blocks = ["10.100.0.0/16"] # ✅ 僅限內部私有網段
    description = "allow haha-iac-demo vpc"
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # ✅ 允許 all traffic
    cidr_blocks = ["13.114.139.179/32"] # allow AWS Cloud9 Terminal IP
    description = "allow cloud9 public ip"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                 # ✅ 允許 all traffic
    cidr_blocks = ["210.64.53.104/32"] # PTC IP
    description = "allow ptc ip"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-ap-sg" # ✅ 加入標籤
  }
}


###########
## db-sg ##
###########

resource "aws_security_group" "db_sg" {
  name   = "${var.project}-db-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # ✅ 允許 all traffic
    cidr_blocks = ["10.100.0.0/16"] # ✅ 僅限內部私有網段
    description = "allow haha-iac-demo vpc"
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # ✅ 允許 all traffic
    cidr_blocks = ["13.114.139.179/32"] # allow AWS Cloud9 Terminal IP
    description = "allow cloud9 public ip"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                 # ✅ 允許 all traffic
    cidr_blocks = ["210.64.53.104/32"] # PTC IP
    description = "allow ptc ip"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-db-sg" # ✅ 加入標籤
  }
}

#############
## openvpn ##
#############

resource "aws_security_group" "openvpn_sg" {
  name   = "${var.project}-openvpn-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # ✅ 允許 all traffic
    cidr_blocks = ["10.100.0.0/16"] # ✅ 僅限內部私有網段
    description = "allow haha-iac-demo vpc"
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # ✅ 允許 all traffic
    cidr_blocks = ["13.114.139.179/32"] # allow AWS Cloud9 Terminal IP
    description = "allow cloud9 public ip"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                 # ✅ 允許 all traffic
    cidr_blocks = ["210.64.53.104/32"] # PTC IP
    description = "allow ptc ip"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-openvpn-sg" # ✅ 加入標籤
  }
}

