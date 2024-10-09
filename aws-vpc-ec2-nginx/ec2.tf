resource "aws_instance" "NginxServer" {
  ami           = "ami-0ea3c35c5c3284d82"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.Public-subnet.id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  associate_public_ip_address = true
  user_data = <<-EOF
           #!/bin/bash
           sudo apt update
           sudo apt install nginx -y
           sudo systemctl start nginx
           sudo systemctl enable nginx
           EOF

tags = {
    Name = "NginxServer"
  }
}