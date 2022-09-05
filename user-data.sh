#!/bin/bash
  user_data = <<-EOF
# 		    #!/bin/bash
#         sudo apt install nginx -y
# 		    sudo apt install git -y
# 		    sudo git clone -b https://github.com/Kiran2361993/Docker-webhooking.git
# 		    sudo rm -rf /var/www/html/index.nginx-debain.html
#         sudo cp webhooktesting/index.html /var/www/html/index.nginx-debain.html
#         sudo cp webhooktesting/style.css /var/www/html/style.css
#         sudo cp webhooktesting/scorekeeper.js /var/www/html/scorekeeper.js
#         echo "<div><h1>${var.vpc_name}-Public-Server-${count.index + 1}</h1></div>" >> /var/www/html/index.nginx-debain.html
#     EOF
# }