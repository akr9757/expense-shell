dnf module disable mysql -y
cp mysql.repo /etc/yum.repos.d/mysql.repo
dnf install mysql-community-server -y
mysql_secure_installation --set-root-pass ExpenseApp@1
mysql -uroot -pExpenseApp@1
systemctl enable mysqld
systemctl restart mysqld
