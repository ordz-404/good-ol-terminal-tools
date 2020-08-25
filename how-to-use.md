## Usage Parameters

`./server.sh start|stop|attach|status|backup`

### start

Creates a terminal multiplxer (tmux is different from screen) session and starts a minecraft server within.
If a current instance is already running, the server will indicate. 

### stop

Sends `stop` command to running minecraft server instance to safely shut down.

### attach

Re attaches to a TMUX screen session if the server is running. To exit, press `CTRL + B ` together follwed by `b` key.

### status

lists active screen sessions with `SCREEN_SESSIONNAME`.

### backup

Backs up the world as a `tar.gz` archive in `./backup/`.
If a running server is detected,
the world is flushed to disk and autosave is disabled temporarily to prevent chunk corruption.

The command specified in `$BACKUP_HOOK` is
executed on every successful backup. `$ARCHNAME` contains the relative path to the archive.
This can be used to further process the created backup.

## Start automatically

Create user and group `minecraft` with home in `/var/minecraft`.
Populate the directory with server.sh and a server jar.
Place `minecraft.service` in `/etc/systemd/system/`
and run `systemctl start minecraft` to start once or
`systemctl enable minecraft` to enable autostarting.

To backup automatically, place or symlink `mc-backup.service` and
`mc-backup.timer` in `/etc/systemd/system/`. Run the following:

```
sudo systemctl  enable mc-backup.timer
sudo sytemctl start mc-backup.timer
```

This wil start the enable the timer upon startup and start the timer
to run the backup after every interval specified in mc-backup.timer.
