component="backend"
source common.sh
mysql_root_password=$1

if [ -z "${mysql_root_password}" ]; then
  echo mysql root password is missing
  exit 1
fi

print_head "Disable Old Version"
dnf module disable nodejs -y &>>${log_file}
func_stat_check $?

print_head "Enable Newer Version"
dnf module enable nodejs:18 -y &>>${log_file}
func_stat_check $?

print_head "Install Node"
dnf install nodejs -y &>>${log_file}
func_stat_check $?

print_head "Copy Backend Service File"
cp ${component}.service /etc/systemd/system/${component}.service &>>${log_file}
func_stat_check $?

print_head "Add Application User"
id expense $? &>>${log_file}
if [ "$?" -ne 0 ]; then
  useradd ${user_name} &>>${log_file}
fi

func_stat_check $?

func_app_prereq "/app"

print_head "Install Dependencies"
npm install &>>${log_file}
func_stat_check $?

print_head "Install Mysql"
dnf install mysql -y &>>${log_file}
func_stat_check $?

print_head "Load Schema"
mysql -h mysql-dev.akrdevops.online -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>${log_file}
func_stat_check $?

print_head "Start Service"
systemctl daemon-reload &>>${log_file}
systemctl enable backend &>>${log_file}
systemctl restart backend &>>${log_file}
func_stat_check $?
