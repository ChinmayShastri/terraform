#AWS Launch Configuration defination for shivay project
# resource "aws_launch_configuration" "shivay_lc"{
#   name_prefix   = "shivay_LC"
#   image_id      = lookup(var.AMIS, var.AWS_REGION)
#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.shivay_key.key_name
# }

#Provider
provider "aws" {
  region = "us-east-2"  # Specify the desired AWS region
}

# Launch Template
resource "aws_launch_template" "shivay-lt" {
  name_prefix   = "shivay-lt"
  image_id      = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.shivay_key.key_name
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "shivay-asg-instance"
    }
  }
}

#Generate Key
resource "aws_key_pair" "shivay_key" {
  key_name   = "shivay_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Autoscaling Group defination
resource "aws_autoscaling_group" "shivay_asg" {
  name                      = "shivay_asg"
  vpc_zone_identifier       = ["subnet-04d74c6fc2503ce24"]
#  launch_configuration      = aws_launch_configuration.shivay_lc.name
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 200
  health_check_type         = "EC2"
  force_delete              = true
  launch_template {
    id      = aws_launch_template.shivay-lt.id
    version = "$Latest"
  }

  tag {
    key                 = "NAME"
    value               = "shivay_asg_1"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "shivay-policy" {
  name                   = "cpu-utilization-target-tracking"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.shivay_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 60.0
  }
}



#ASG Cloud wathc alarm
resource "aws_cloudwatch_metric_alarm" "shivay-cpu-alarm-up" {
  alarm_name          = "shivay-cpu-alarm-up"
  alarm_description   = "Alarm once CPU is increased above 60%"
#  comparison_operator = "GraterThanOrEqualToThreshold"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  actions_enabled     = true
  alarm_actions       = [aws_autoscaling_policy.shivay-policy.arn]

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.shivay_asg.name
  }
}

# #ASG Configuration policy defination
# resource "aws_autoscaling_policy" "shivay_policy-out" {
#   name                   = "shivay-cpu-policy"
#   autoscaling_group_name = aws_autoscaling_group.shivay_asg.name
#   adjustment_type        = "ChangeInCapacity"
#   scaling_adjustment     = "1"
#   cooldown               = "200"
#   policy_type            = "SimpleScaling"
# }

# #ASG Cloud wathc alarm
# resource "aws_cloudwatch_metric_alarm" "shivay-cpu-alarm-up" {
#   alarm_name          = "shivay-cpu-alarm-up"
#   alarm_description   = "Alarm once CPU is increased above 60%"
#   comparison_operator = "GraterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "60"
#   actions_enabled     = true
#   alarm_actions       = [aws_autoscaling_policy.shivay-policy-out.arn]

#   dimensions = {
#     "AutoScalingGroupName" = aws_autoscaling_group.shivay_asg.name
#   }
# }

# #ASG descaling policy
# resource "aws_autoscaling_policy" "shivay_policy-in" {
#   name                   = "shivay_policy-down"
#   autoscaling_group_name = aws_autoscaling_group.shivay_asg.name
#   adjustment_type        = "ChangeInCapacity"
#   scaling_adjustment     = "-1"
#   cooldown               = "120"
#   policy_type            = "SimpleScaling"
# }

# #Auto descaling cloud watch 
# resource "aws_cloudwatch_metric_alarm" "shivay-CPU-alarm-in" {
#   alarm_name          = "shivay-CPU-alarm-down"
#   alarm_description   = "Alarm once CPU Uses Decrease"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "50"

#   dimensions = {
#     "AutoScalingGroupName" = aws_autoscaling_group.shivay_asg.name
#   }

#   actions_enabled = true
#   alarm_actions   = [aws_autoscaling_policy.shivay_policy-in.arn]
# }