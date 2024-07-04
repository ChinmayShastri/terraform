#! /bin/bash
yum update -y
yum install -y apache2
systemctl start apache2
systemctl enable apache2
echo "<h1>Ruchita machine is deployed by Terraform...!! </h1>" | sudo tee /var/www/html/index.html