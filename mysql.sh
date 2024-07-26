dnf install mysql-server -y
mysql_secure_installation --set-root-pass ExpenseApp@1
systemctl enable mysqld
systemctl start mysqld

