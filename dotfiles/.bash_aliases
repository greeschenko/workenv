# общие команды ggt
alias ggst="git status"
alias ggadd="git add --all && git commit -a -m"
alias ggco="git commit -a -m"
alias ggpull="git pull"
alias ggpush="git push"
alias ggtag="git tag"
alias ggbr="git branch"
alias gggo="git checkout"
# выводит раскрашенную историю коммитов с датами и тегами,
# без хешей объектов, последний коммит снизу
alias gghist="git log --pretty=tformat:'%ad %Cgreen%s %Cblue%an %Cred%d%Creset' --reverse --date=short"
# показывает что изменялось в последнем коммите
alias gglast="git log --stat --no-merges --max-count=1"
# показывает граф
alias gggraf="git log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short"

#вызов списка задач

alias nday="cd prodev/workdocs/ && nvim -c 'call NewDayTaskConstruct()' ~/prodev/workdocs/today.dt"
