/*output "ec2_public_Ip" {
  value = aws_instance.my_instance.public_ip # interpolation 

}

output "ec2_public_dns" {
  value = aws_instance.my_instance.public_dns

}

output "ec2_private_ip" {
  value = aws_instance.my_instance.private_ip

}
*/

# this is output file for creting multiple instances

output "ec2_public_Ip" {
    value = [
        for instance in aws_instance.my_instance : instance.public_ip
    ]
  
}