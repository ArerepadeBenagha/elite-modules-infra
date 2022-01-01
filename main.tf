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