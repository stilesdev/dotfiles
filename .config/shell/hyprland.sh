# if uwsm check may-start && uwsm select; then
if uwsm check may-start -q; then
	exec uwsm start default
fi
