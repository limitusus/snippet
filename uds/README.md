Unix Domain Socket
==================

Code from perlipc

UDS status via procfs
---------------------

You can get unix domain sockets info by reading `/proc/net/unix`.

* Num: Kernel table slot number
* RefCount: number of users of the socket
* Protocol: always 0
* Flags: Kernel internal value; multiplexed bitmap of `SOCK_*`.
* Type: always 1
* St: status; see `linux/net.h`
* Inode: inode number
* Path

When St changes
---------------

via `linux/net/unix/af_unix.c`

Unix domain sockets can have `St` either of `SS_UNCONNECTED(0)` or `SS_CONNECTED(2)`.

* Created: set to `SS_UNCONNECTED`
* Called `socketpair` (both new sockets): set to `SS_CONNECTED`
* Accepted a connection (for the new socket): set to `SS_CONNECTED`; old connection remains `SS_UNCONNECTED`
* Connected (client side): set to `SS_CONNECTED`

