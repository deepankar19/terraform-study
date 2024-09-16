# STEP3: OUTPUT PUBLIC IP OF EC2 INSTANCE
output "ACCESS_YOUR_JENKINS_HERE" {
  value = "http://${aws_instance.jenkins.public_ip}:8080"
}

output "Jenkins_Initial_Password" {
  value = "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
}

# STEP4: OUTPUT PUBLIC IP OF EC2 INSTANCE
output "MASTER_SERVER_PUBLIC_IP" {
  value = aws_instance.jenkins.public_ip
}

# STEP5: OUTPUT PRIVATE IP OF EC2 INSTANCE
output "MASTER_SERVER_PRIVATE_IP" {
  value = aws_instance.jenkins.private_ip
}