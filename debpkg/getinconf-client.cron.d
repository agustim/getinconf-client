#
# Regular cron jobs for the getinconf-client package
#
0 0	* * *	root	[ -x /usr/sbin/stvclient ] && /usr/sbin/stvclient
