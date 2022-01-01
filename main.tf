module "vpc" {
  source = "./modules/vpc"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = merge(local.common_tags,
    { Name = "Infra-vpc"
  Application = "public" })
}

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