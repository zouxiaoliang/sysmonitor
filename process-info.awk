{
    cpu = $3
    mem = $4
    res = $5
    vsz = $6
    cmdline = ""
    for (i = 11 ; i <= NF; ++i) {
        if (length(cmdline) > 0) {
            cmdline = cmdline " "
        }
        cmdline = cmdline $i
    }
    print "name: " name ", pid: " pid ", cpu: " cpu ", mem: " mem ", res: " res ", vsz: " vsz ", cmdline: \"" cmdline "\""
}