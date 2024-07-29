user_name="expense"
log_file=/tmp/expene.log

func_stat_check() {
  if [ "$1" -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[33mFAILURE\e[0m"
    exit 1
  fi
}

print_head() {
  echo -e "\e[32m>>>>>>>>>>>>>>>>> $1  <<<<<<<<<<<<<<<<<<<<<<\e[0m"
  echo -e "\e[32m>>>>>>>>>>>>>>>>> $1 <<<<<<<<<<<<<<<<<<<<<<\e[0m" &>>${log_file}
}

func_app_prereq() {
  dir=$1

  print_head "Remove Old App Content and Create"
  rm -rf $1 &>>${log_file}
  mkdir $1 &>>${log_file}
  func_stat_check $?

  print_head "Download App Content"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
  func_stat_check $?

  print_head "Unzip App Content"
  cd $1 &>>${log_file}
  unzip /tmp/${component}.zip &>>${log_file}
  func_stat_check $?
}