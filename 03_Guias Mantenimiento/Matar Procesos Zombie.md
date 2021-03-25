# Matar Procesos Zombie

1. Conseguir su numero de proceso PID
   ```bash
   ps -el | grep 'Z'
   ```
   ```bash
   ps aux | grep defunct
   ```
2. Matar el proceso
   ```bash
   kill -HUP `ps -A -ostat,ppid,pid,cmd | grep -e ‘^[Zz]’ | awk ‘{print $2}’`
   ```
3. Opcional encontrar el proceso padre y matar el proceso padre ppid
   ```bash
   ps -eo pid,ppid | grep <PID>
   ```
   ```bash
   kill -9 <PPID>
   ```