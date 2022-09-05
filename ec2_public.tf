resource "aws_instance" "public-servers" {
  count                       = "${var.environment == "Prod" ? 3 : 1}"
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = "t2.micro"
  key_name                    = "2022_Devops"
  subnet_id                   = element(aws_subnet.subnet-public.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "Public-Servers"
    deployedby = local.deployedby
    Owner      = local.Owner
    costcenter = local.costcenter
    teamdl     = local.teamdl
    environmet = "${var.environment}"
  }
}

#   user_data = <<-EOF
# 		    #!/bin/bash
#         sudo apt install nginx -y
# 		    sudo apt install git -y
# 		    sudo git clone https://github.com/mavrick202/webhooktesting.git
# 		    sudo rm -rf /var/www/html/index.nginx-debain.html
#         sudo cp webhooktesting/index.html /var/www/html/index.nginx-debain.html
#         sudo cp webhooktesting/style.css /var/www/html/style.css
#         sudo cp webhooktesting/scorekeeper.js /var/www/html/scorekeeper.js
#         echo "<div><h1>${var.vpc_name}-Public-Server-${count.index + 1}</h1></div>" >> /var/www/html/index.nginx-debain.html
#     EOF
# }