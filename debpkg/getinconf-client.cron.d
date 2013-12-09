#
# Regular cron jobs for the getinconf-client package
#
0 *	* * *	root	[ -x /usr/sbin/getinconf-client ] && "/usr/sbin/getinconf-client install"
