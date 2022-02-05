# module "vpc" {
#   source = "./modules/vpc"

#   name = "my-vpc"
#   cidr = "10.0.0.0/16"

#   azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#   enable_nat_gateway = true
#   enable_vpn_gateway = true

#   tags = merge(local.common_tags,
#     { Name = "Infra-vpc"
#   Application = "public" })
# }

# module "elb_http" {
#   source = "./modules/elb"

#   name = "elb-example"

#   subnets         = ["subnet-051b912a53c926e48", "subnet-02a75b4a215dca888"]
#   security_groups = ["sg-02fbdd1982941bf25", "sg-056743c27f847cef4"]
#   internal        = false

#   listener = [
#     {
#       instance_port     = 8080
#       instance_protocol = "http"
#       lb_port           = 80
#       lb_protocol       = "http"
#     },
#     {
#       instance_port      = 8080
#       instance_protocol  = "http"
#       lb_port            = 443
#       lb_protocol        = "https"
#       ssl_certificate_id = "arn:aws:acm:us-east-1:375866976303:certificate/573cf29d-5413-4ac1-ba86-02297de6fed2"
#     },
#   ]

#   health_check = {
#     target              = "HTTP:8080/"
#     interval            = 30
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 5
#   }

#   access_logs = {
#     bucket = "testbucket-xyzhtes"
#     # enabled = false
#   }

#   // ELB attachments
#   number_of_instances = 1
#   instances           = ["i-0c2dc94a33d6516ae"]
#   #   create_attachment = false
#   elb = "elb-example"

#   tags = {
#     Owner       = "user"
#     Environment = "dev"
#   }
# }

# module "cloudfront" {
#   source                 = "./modules/cloudfront"
#   domain_name            = var.domain_name
#   bucket_name            = var.bucket_name
#   http_port              = var.http_port
#   https_port             = var.https_port
#   origin_protocol_policy = var.origin_protocol_policy
#   enabled                = var.enabled
#   is_ipv6_enabled        = var.is_ipv6_enabled
#   viewer_protocol_policy = var.viewer_protocol_policy
#   ssl                    = var.ssl
#   bucket_appname         = var.bucket_appname
#   env                    = var.env
#   region                 = var.region
#   ssl_name               = var.ssl_name
# }

# module "nat_gateways" {
#   source = "./modules/natgw"

#   subnet_count = module.public_subnets.subnet_count
#   subnet_ids   = module.public_subnets.subnet_ids

#   tags              = var.tags
#   tags_for_resource = var.tags_for_resource
# }

module "vpc" {
  source = "./modules/vpc"

  cidr_block           = "10.0.0.0/16"
  enable_dhcp_options  = var.enable_dhcp_options
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(local.common_tags,
  { Name = "main-vpc" })
  tags_for_resource = var.tags_for_resource
}

resource "aws_route" "rtb" {
  count = var.subnet_count

  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = element(module.public_subnets.route_table_ids, count.index)
  gateway_id             = module.vpc.internet_gateway_id
}


module "public_subnets" {
  source = "./modules/subnets"

  vpc_id                  = module.vpc.vpc_id
  gateway_id              = module.vpc.internet_gateway_id
  propagating_vgws        = var.public_propagating_vgws
  map_public_ip_on_launch = var.map_public_ip_on_launch

  cidr_block         = "10.0.0.0/26"
  subnet_count       = "1"
  availability_zones = ["us-east-1a"]

  tags = merge(local.common_tags,
  { Name = "main-subnet" })
  tags_for_resource = var.tags_for_resource
}

module "autoscale_group" {
  source          = "./modules/autoscale"
  launch_template = 1
  name            = "autoscale-config"

  image_id           = "ami-04505e74c0741db8d"
  instance_type      = "t2.micro"
  security_group_ids = ["sg-012e91b37216e9712"]
  # # subnet_ids                  = ["subnet-xxxxxxxx", "subnet-yyyyyyyy", "subnet-zzzzzzzz"]
  # health_check_type           = "EC2"
  # min_size                    = 2
  # max_size                    = 3
  # wait_for_capacity_timeout   = "5m"
  # associate_public_ip_address = true

  # All inputs to `block_device_mappings` have to be defined
  block_device_mappings = [
    {
      device_name  = "/dev/sda1"
      no_device    = "false"
      virtual_name = "root"
      ebs = {
        encrypted             = true
        volume_size           = 200
        delete_on_termination = true
        iops                  = null
        kms_key_id            = null
        snapshot_id           = null
        volume_type           = "standard"
      }
    }
  ]

  tags = local.common_tags

  # Auto-scaling policies and CloudWatch metric alarms
  # autoscaling_policies_enabled           = true
  # cpu_utilization_high_threshold_percent = "70"
  # cpu_utilization_low_threshold_percent  = "20"
}