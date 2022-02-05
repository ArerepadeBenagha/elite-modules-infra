output "launch_template_id" {
  description = "The ID of the launch template"
  value       = join("", aws_launch_template.this.*.id)
}

output "launch_template_arn" {
  description = "The ARN of the launch template"
  value       = join("", aws_launch_template.this.*.arn)
}