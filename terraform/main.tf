data "aws_ami" "amazon-linux-2" {
 most_recent = true
 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }
 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

resource "tls_private_key" "key" {
 algorithm = "RSA"
 rsa_bits  = 4096
}

resource "local_file" "scalac_key" {
  content  = tls_private_key.key.private_key_pem
  filename = var.ssh_key_private
  file_permission = "0600"
}
 
resource "aws_key_pair" "aws_key" {
 key_name   = "scalac-ssh-key"
 public_key = tls_private_key.key.public_key_openssh
}

resource "aws_instance" "app_server" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.aws_key.key_name
  subnet_id       = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.public.id]
  associate_public_ip_address = true
  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.key.private_key_pem
  }

  provisioner "file" {
    source      = "../ansible"
    destination = "/home/ec2-user"
  }

  provisioner "file" {
    source      = "../jenkins"
    destination = "/home/ec2-user/jenkins"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt -y update && sudo apt install python3-pip -y",
      "sudo pip3 install ansible",
      "ansible-playbook -i localhost /home/ec2-user/ansible/playbook.yaml"
      ]
  }
}