# if uwsm check may-start && uwsm select; then
if command -v uwsm > /dev/null 2>&1 && uwsm check may-start -q; then
	exec uwsm start default
fi
