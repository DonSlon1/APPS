set tui tab-width 4
tui enable
set style tui-active-border foreground yellow
set tui active-border-mode bold
set print pretty on
set pagination on
set history save on
set history size 10000
set history filename ~/.gdb_history
define parr
    print *(int *)$arg0 @ $arg1
end
document parr
    Prints an integer array. Usage: parr [pointer/register] [length]
end
