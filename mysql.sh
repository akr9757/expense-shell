source common.sh

print_head "Disable Mysql Older Version"
dnf module disable mysql -y &>>${log_file}
func_stat_check $?

print_head "Copy Mysql Repo"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}
func_stat_check $?

print_head "Install Mysql"
dnf install mysql-community-server -y &>>${log_file}
func_stat_check $?

print_head "Start Mysql Service"
systemctl enable mysqld &>>${log_file}
systemctl restart mysqld &>>${log_file}
func_stat_check $?

print_head "Set Mysql Password"
mysql_secure_installation --set-root-pass ${mysql_root_password} &>>${log_file}
func_stat_check $?
