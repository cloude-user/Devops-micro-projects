resource "aws_cloudwatch_log_group" "flow_logs" {
  name = "/aws/vpc/flow-logs"
}

resource "aws_flow_log" "vpc_flow_logs" {
  vpc_id          = var.vpc_id
  log_destination = aws_cloudwatch_log_group.flow_logs.arn
  traffic_type    = "ALL"  # Logs both ACCEPT and REJECT traffic
  iam_role_arn    = aws_iam_role.flow_log_role.arn
}
