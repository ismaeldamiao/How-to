# How to execute a command/script at boot

Put in `/etc/rc.local`:
```bash
#!/bin/bash

# Your bash commands

exit 0
```

Make it executable with `chmod 755 /etc/rc.local`.
