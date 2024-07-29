component="frontend"
source common.sh

print_head "Install Nginx"
dnf install nginx -y &>>${log_file}
func_stat_check $?

print_head "Copy Expense Conf"
cp expense.conf /etc/nginx/default.d/expense.conf &>>${log_file}
func_stat_check $?

func_app_prereq "/usr/share/nginx/html"

print_head "Start Nginx Service"
systemctl enable nginx &>>${log_file}
systemctl restart nginx &>>${log_file}
func_stat_check $?