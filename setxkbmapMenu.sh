#/bin/bash

 E='echo -e';e='echo -en';trap "R;exit" 2
 ESC=$( $e "\e")
  TPUT(){ $e "\e[${1};${2}H";}
 CLEAR(){ $e "\ec";}
 CIVIS(){ $e "\e[?5l";}
  DRAW(){ $e "\e%@\e(0";}
 WRITE(){ $e "\e(B";}
# цвет и вид фона перед курсором
# MARK(){ $e "\e[40m";} чёрный без курсора
# MARK(){ $e "\e[41m";} бардовый без курсора
# MARK(){ $e "\e[42m";} зелюный без курсора
# MARK(){ $e "\e[43m";} коричневый без курсора
# MARK(){ $e "\e[44m";} синий без курсора
# MARK(){ $e "\e[45m";} сиреневый без курсора
# MARK(){ $e "\e[46m";} голубой без курсора
# MARK(){ $e "\e[47m";} серый без курсора
  MARK(){ $e "\e[44m";}
# цвет и вид текста меню
# UNMARK(){ $e "\e[27m";}
# UNMARK(){ $e "\e[1m";} белый фон
# UNMARK(){ $e "\e[2m";} серый фон
# UNMARK(){ $e "\e[3m";} серо-белый фон
# UNMARK(){ $e "\e[22m";} серый фон
# UNMARK(){ $e "\e[23m";} белый фон
# UNMARK(){ $e "\e[30m";} серый фон
# UNMARK(){ $e "\e[31m";} розовый фон
# UNMARK(){ $e "\e[32m";} зелюный фон
 UNMARK(){ $e "\e[32m";}
# цвет и вид фона меню
      R(){ CLEAR ;stty sane;$e "\ec\e[37;1m\e[J";};
   HEAD(){ DRAW
# Цикл боковых элементов
           for each in $(seq 1 17);do
           $E "x                                              x"
           done
           WRITE;MARK;TPUT 1 2
           $E "    setxkbmap Переключение клавиатуры         ";UNMARK;}
           i=0; CLEAR; CIVIS;NULL=/dev/null
   FOOT(){ MARK;TPUT 17 2
       printf "    Enter - select,next                       ";UNMARK;}
  ARROW(){ read -s -n3 key 2>/dev/null >&2
           if [[ $key = $ESC[A ]];then echo up;fi
           if [[ $key = $ESC[B ]];then echo dn;fi;}
# M0(){ TPUT отступ сверху отступ слева; $e "текст";}
 M0(){ TPUT  3  5; $e " Установить утилиту setxkbmap          ";}
 M1(){ TPUT  4  5; $e " English keyboard                      ";}
 M2(){ TPUT  5  5; $e " Show script                           ";}
 M3(){ TPUT  6  5; $e " Українська клавіатура                 ";}
 M4(){ TPUT  7  5; $e " Show script                           ";}
 M5(){ TPUT  8  5; $e " Русская клавиатура                    ";}
 M6(){ TPUT  9  5; $e " Show script                           ";}
 M7(){ TPUT 10  5; $e " Deutsche Tastatur                     ";}
 M8(){ TPUT 11  5; $e " Show script                           ";}
 M9(){ TPUT 12  5; $e " Просмотр настроек клавиатуры          ";}
M10(){ TPUT 13  5; $e " Показать текущую раскладку клавиатуры ";}
M11(){ TPUT 14  5; $e " Показать краткую сводку ключей        ";}
M12(){ TPUT 15  5; $e " EXIT                                  ";}
# Количество прохождения ступеней краткую сводку ключей
LM=12
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
     ES(){ MARK;$e "Enter = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
        0) S=M0;SC;if [[ $cur == "" ]];then R;echo "sudo apt-get install x11-xkb-utils";ES;fi;;
        1) S=M1;SC;if [[ $cur == "" ]];then R;setxkbmap us;ES;fi;;
        2) S=M2;SC;if [[ $cur == "" ]];then R;echo "setxkbmap us";ES;fi;;
        3) S=M3;SC;if [[ $cur == "" ]];then R;setxkbmap ua;ES;fi;;
        4) S=M4;SC;if [[ $cur == "" ]];then R;echo "setxkbmap ua";ES;fi;;
        5) S=M5;SC;if [[ $cur == "" ]];then R;setxkbmap ru;ES;fi;;
        6) S=M6;SC;if [[ $cur == "" ]];then R;echo "setxkbmap ru";ES;fi;;
        7) S=M7;SC;if [[ $cur == "" ]];then R;setxkbmap de;ES;fi;;
        8) S=M8;SC;if [[ $cur == "" ]];then R;echo "setxkbmap de";ES;fi;;
        9) S=M9;SC;if [[ $cur == "" ]];then R;echo "setxkbmap -print -verbose 10";ES;fi;;
       10)S=M10;SC;if [[ $cur == "" ]];then R;echo "setxkbmap -query";ES;fi;;
       11)S=M11;SC;if [[ $cur == "" ]];then R;echo "setxkbmap -?";ES;fi;;
       12)S=M12;SC;if [[ $cur == "" ]];then R;exit 0;fi;;
 esac;POS;done
