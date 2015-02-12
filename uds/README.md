Unix Domain Socket
==================

Code from perlipc

UDS status via procfs
---------------------

You can get unix domain sockets info by reading `/proc/net/unix`.

* Num: Kernel table slot number
* RefCount: number of users of the socket
* Protocol: always 0 (hard-coded)
* Flags: Kernel internal value; actually non-zero if the socket is not listening
* Type: always 1, since UDS currently supports only `SOCK_STREAM`
* St: status; see `linux/net.h`
* Inode: inode number
* Path

When St changes
---------------

via `linux/net/unix/af_unix.c`

Unix domain sockets can have `sock->state` either of `SS_UNCONNECTED(0)` or `SS_CONNECTED(2)`.

* Created: set to `SS_UNCONNECTED`
* Called `socketpair` (both new sockets): set to `SS_CONNECTED`
* Accepted a connection (for the new socket): set to `SS_CONNECTED`; old connection remains `SS_UNCONNECTED`
* Connected (client side): set to `SS_CONNECTED`

`sock->sk_state` changes when:

* `listen`: `TCP_LISTEN`
* `connect`: `TCP_ESTABLISHED`
* `socketpair`: `TCP_ESTABLISHED`
* release (`shutdown` or `close`): `TCP_CLOSE`

Reading `/proc/net/unix` invokes `unix_seq_show()`.

`St` field will be one of `SS_CONNECTED`, `SS_UNCONNECTED`, `SS_CONNECTIONG`, `SS_DISCONNECTING`.

Code:
```c
s->sk_socket ?$
(s->sk_state == TCP_ESTABLISHED ? SS_CONNECTED : SS_UNCONNECTED) :
(s->sk_state == TCP_ESTABLISHED ? SS_CONNECTING : SS_DISCONNECTING)
```

