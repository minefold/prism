Fix this:

Jul 17 21:02:53 i-e331c191 prism-3: panic: runtime error: invalid memory address or nil pointer dereference
Jul 17 21:02:53 i-e331c191 prism-3: #011panic: runtime error: invalid memory address or nil pointer dereference
Jul 17 21:02:53 i-e331c191 prism-3: [signal 0xb code=0x1 addr=0x0 pc=0x45a600]
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 709 [running]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sub).Close(0xf8402506e0, 0x7f3700449100)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:265 +0x20
Jul 17 21:02:53 i-e331c191 prism-3: ----- stack segment boundary -----
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf8402684c8, 0xf840259c30, 0xf8402684d0, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:183 +0x315
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 1 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840077240, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).accept(0xf840077240, 0x472dfe, 0x0, 0xf8400469f0, 0xf84005f040, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:622 +0x20d
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPListener).AcceptTCP(0xf84005f308, 0x515460, 0x0, 0x0, 0x10, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:320 +0x71
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPListener).Accept(0xf84005f308, 0x0, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:330 +0x49
Jul 17 21:02:53 i-e331c191 prism-3: main.main()
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:316 +0x57c
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 2 [syscall]:
Jul 17 21:02:53 i-e331c191 prism-3: created by runtime.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/runtime/proc.c:221
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 3 [runnable]:
Jul 17 21:02:53 i-e331c191 prism-3: syscall.Syscall6()
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/syscall/asm_linux_amd64.s:61 +0x6a
Jul 17 21:02:53 i-e331c191 prism-3: syscall.EpollWait(0xf800000006, 0xf8400780c0, 0xa0000000a, 0xffffffff, 0xc, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/syscall/zerrors_linux_amd64.go:1846 +0xa1
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollster).WaitFD(0xf8400780b0, 0xf840044640, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd_linux.go:146 +0x110
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).Run(0xf840044640, 0x0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:236 +0xe4
Jul 17 21:02:53 i-e331c191 prism-3: created by net.newPollServer
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/newpollserver.go:35 +0x382
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 808 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382a20, 0x200000002, 0xf8403873d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403873d8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203ba6d01, 0xf840382a20, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703ba6df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840384c00, 0x300000027, 0xf840382a00, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403842a0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402f6000)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402f6000)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 105 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840077630, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840077630, 0xf84015c000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf84009ee48, 0xf84015c000, 0x800000008000, 0xf800000008, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400a4f10, 0xf840047bd0, 0xf84009ee48, 0xcf37, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf84009e800, 0xf840047bd0, 0xf84009ee48, 0xf84009e800, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf84009e800, 0xf840047bd0, 0xf84009ee48, 0xf84009ff90, 0xf84009e800, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf84009e800, 0xf840047bd0, 0xf84009ee48, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*ConnectionRequest).ProxyConnection(0xf840000700, 0xf8400642a0, 0xf84009ee48, 0xf840114de0, 0x14, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:274 +0x370
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Approved
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:222 +0x1a4
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 131 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84005fbb8, 0xf8401298c0, 0xf840125e70, 0xf84005fbb0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 12 [syscall]:
Jul 17 21:02:53 i-e331c191 prism-3: created by addtimer
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/runtime/ztime_amd64.c:72
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 13 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84005fba8, 0xf84005ee90, 0xf84009e2f8, 0xf84005fba0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 38 [finalizer wait]:
Jul 17 21:02:53 i-e331c191 prism-3: created by runtime.gc
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/runtime/mgc0.c:882
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 35 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8400caed0, 0xf8400cf440, 0xf8400cae28, 0xf8400caec8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 610 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403a22d0, 0x300000003, 0xf84027cdc0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84027cdc0, 0x1520000010a, 0x1520000010a, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x240395801, 0xf8403a22d0, 0x300000003, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendIface(0xf8400446c0, 0xf840044680, 0x52f0cc, 0x5355504c00000005, 0x7f3703a80d58, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:322 +0x22f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Lpush(0xf84005e2d0, 0x542e9c, 0x79616c700000001a, 0x4b47c0, 0xf8403958a0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:318 +0xde
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).PushConnectionReq(0xf840079000, 0xf84039c230, 0xf84031e4c8, 0xf840395530)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:89 +0xd1
Jul 17 21:02:53 i-e331c191 prism-3: main.(*ConnectionRequest).Process(0xf84039c230, 0xf8400642a0, 0xf84012dba8, 0xf840398f80, 0xf8403a8060, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:207 +0x17b
Jul 17 21:02:53 i-e331c191 prism-3: main.handleLogin(0xf8400642a0, 0xf84012dba8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:102 +0x423
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84012dba8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:56 +0x1ca
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 104 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84012d678, 0xf840120230, 0xf8400dcf88, 0xf84012d670, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 113 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840094a20, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840094a20, 0xf84017c000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400b67e0, 0xf84017c000, 0x800000008000, 0xf80000000a, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400a4930, 0xf840047bd0, 0xf8400b67e0, 0x1b7da, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf84009e448, 0xf840047bd0, 0xf8400b67e0, 0xf84009e448, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf84009e448, 0xf840047bd0, 0xf8400b67e0, 0xf84009ff90, 0xf84009e448, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf84009e448, 0xf840047bd0, 0xf8400b67e0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*ConnectionRequest).ProxyConnection(0xf840124150, 0xf8400642a0, 0xf8400b67e0, 0xf840137120, 0x14, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:274 +0x370
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Approved
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:222 +0x1a4
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 112 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84012dde0, 0xf840120950, 0xf8401254c0, 0xf84012ddd8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 48 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84009eda0, 0xf84005e340, 0xf84009ef00, 0xf84009ed98, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 738 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8402b8498, 0xf840259710, 0xf840268148, 0xf8402b8490, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 56 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84009e7c8, 0xf8400a4f50, 0xf84009e520, 0xf84009e7c0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 57 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf8400773f0, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf8400773f0, 0xf840109000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf84009e070, 0xf840109000, 0x800000008000, 0xf800000020, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf84005ec70, 0xf840047bd0, 0xf84009e070, 0xe603c, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf84009ef98, 0xf840047bd0, 0xf84009e070, 0xf84009ef98, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf84009ef98, 0xf840047bd0, 0xf84009e070, 0xf84009ff90, 0xf84009ef98, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf84009ef98, 0xf840047bd0, 0xf84009e070, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).ProxyConnection
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:273 +0x2e6
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 52 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840077750, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840077750, 0xf840101000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf84009ef98, 0xf840101000, 0x800000008000, 0xf80000000a, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400a4a30, 0xf840047bd0, 0xf84009ef98, 0x140ec, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf84009e070, 0xf840047bd0, 0xf84009ef98, 0xf84009e070, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf84009e070, 0xf840047bd0, 0xf84009ef98, 0xf84009ff90, 0xf84009e070, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf84009e070, 0xf840047bd0, 0xf84009ef98, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*ConnectionRequest).ProxyConnection(0xf840000150, 0xf8400642a0, 0xf84009ef98, 0xf8400b3220, 0x14, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:274 +0x370
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Approved
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:222 +0x1a4
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 152 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840132510, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840132510, 0xf840164000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf84009e800, 0xf840164000, 0x800000008000, 0xf8000000ee, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf84005e560, 0xf840047bd0, 0xf84009e800, 0x252a83, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf84009ee48, 0xf840047bd0, 0xf84009e800, 0xf84009ee48, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf84009ee48, 0xf840047bd0, 0xf84009e800, 0xf84009ff90, 0xf84009ee48, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf84009ee48, 0xf840047bd0, 0xf84009e800, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).ProxyConnection
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:273 +0x2e6
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 156 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf8401116c0, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf8401116c0, 0xf8401a4000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400b6f70, 0xf8401a4000, 0x800000008000, 0xf8000000a9, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf84005e1e0, 0xf840047bd0, 0xf8400b6f70, 0x24b5a8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf8400cada0, 0xf840047bd0, 0xf8400b6f70, 0xf8400cada0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf8400cada0, 0xf840047bd0, 0xf8400b6f70, 0xf84009ff90, 0xf8400cada0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf8400cada0, 0xf840047bd0, 0xf8400b6f70, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).ProxyConnection
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:273 +0x2e6
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 119 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84013e450, 0xf840120fe0, 0xf840125900, 0xf84013e448, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 933 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e8940, 0x200000002, 0xf8403e9b58)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e9b58, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a45d01, 0xf8403e8940, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a45df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403ed6c0, 0x300000027, 0xf8403e8920, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e4120, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403eab08)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403eab08)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 127 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84005fe98, 0xf840129600, 0xf840125ce0, 0xf84005fe90, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 158 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840111990, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840111990, 0xf8401c4000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400b6b50, 0xf8401c4000, 0x800000008000, 0xf800000164, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400a43b0, 0xf840047bd0, 0xf8400b6b50, 0x128e03, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf8400ca730, 0xf840047bd0, 0xf8400b6b50, 0xf8400ca730, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf8400ca730, 0xf840047bd0, 0xf8400b6b50, 0xf84009ff90, 0xf8400ca730, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf8400ca730, 0xf840047bd0, 0xf8400b6b50, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).ProxyConnection
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:273 +0x2e6
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 154 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840132000, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840132000, 0xf840184000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf84009e448, 0xf840184000, 0x800000008000, 0xf8000000e7, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400a4aa0, 0xf840047bd0, 0xf84009e448, 0x3cd0cd, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf8400b67e0, 0xf840047bd0, 0xf84009e448, 0xf8400b67e0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf8400b67e0, 0xf840047bd0, 0xf84009e448, 0xf84009ff90, 0xf8400b67e0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf8400b67e0, 0xf840047bd0, 0xf84009e448, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).ProxyConnection
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:273 +0x2e6
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 163 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840084990, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840084990, 0xf8401f6000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400cafc8, 0xf8401f6000, 0x800000008000, 0xf80000007b, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400cf710, 0xf840047bd0, 0xf8400cafc8, 0x24341d, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf8400ca670, 0xf840047bd0, 0xf8400cafc8, 0xf8400ca670, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf8400ca670, 0xf840047bd0, 0xf8400cafc8, 0xf84009ff90, 0xf8400ca670, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf8400ca670, 0xf840047bd0, 0xf8400cafc8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).ProxyConnection
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:273 +0x2e6
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 124 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840094e10, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840094e10, 0xf84019c000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400cada0, 0xf84019c000, 0x800000008000, 0xf80000002a, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400a4080, 0xf840047bd0, 0xf8400cada0, 0x1cca8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf8400b6f70, 0xf840047bd0, 0xf8400cada0, 0xf8400b6f70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf8400b6f70, 0xf840047bd0, 0xf8400cada0, 0xf84009ff90, 0xf8400b6f70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf8400b6f70, 0xf840047bd0, 0xf8400cada0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*ConnectionRequest).ProxyConnection(0xf840124620, 0xf8400642a0, 0xf8400cada0, 0xf840137a00, 0x14, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:274 +0x370
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Approved
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:222 +0x1a4
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 169 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84005ff60, 0xf8400cfd00, 0xf8400b6590, 0xf84005ff58, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 120 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf8400c4360, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf8400c4360, 0xf84018c000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400ca108, 0xf84018c000, 0x800000008000, 0xf800000022, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400a43d0, 0xf840047bd0, 0xf8400ca108, 0x1e7ce, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf84009e020, 0xf840047bd0, 0xf8400ca108, 0xf84009e020, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf84009e020, 0xf840047bd0, 0xf8400ca108, 0xf84009ff90, 0xf84009e020, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf84009e020, 0xf840047bd0, 0xf8400ca108, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*ConnectionRequest).ProxyConnection(0xf840124310, 0xf8400642a0, 0xf8400ca108, 0xf8401372c0, 0x14, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:274 +0x370
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Approved
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:222 +0x1a4
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 770 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8402d5db0, 0xf84026d070, 0xf84027fc88, 0xf8402d5da8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 128 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840111000, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840111000, 0xf8401ac000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400ca890, 0xf8401ac000, 0x800000008000, 0xf800000022, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400a4000, 0xf840047bd0, 0xf8400ca890, 0x19bb4, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf8400b6de0, 0xf840047bd0, 0xf8400ca890, 0xf8400b6de0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf8400b6de0, 0xf840047bd0, 0xf8400ca890, 0xf84009ff90, 0xf8400b6de0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf8400b6de0, 0xf840047bd0, 0xf8400ca890, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*ConnectionRequest).ProxyConnection(0xf8401247e0, 0xf8400642a0, 0xf8400ca890, 0xf840137ba0, 0x14, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:274 +0x370
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Approved
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:222 +0x1a4
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 157 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840111870, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840111870, 0xf8401b4000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400b6de0, 0xf8401b4000, 0x800000008000, 0xf8000000bb, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf84005e200, 0xf840047bd0, 0xf8400b6de0, 0x2ed7c8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf8400ca890, 0xf840047bd0, 0xf8400b6de0, 0xf8400ca890, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf8400ca890, 0xf840047bd0, 0xf8400b6de0, 0xf84009ff90, 0xf8400ca890, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf8400ca890, 0xf840047bd0, 0xf8400b6de0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).ProxyConnection
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:273 +0x2e6
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 155 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf8401115a0, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf8401115a0, 0xf840194000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf84009e020, 0xf840194000, 0x800000008000, 0xf8000000db, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf84005e1d0, 0xf840047bd0, 0xf84009e020, 0x304b87, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf8400ca108, 0xf840047bd0, 0xf84009e020, 0xf8400ca108, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf8400ca108, 0xf840047bd0, 0xf84009e020, 0xf84009ff90, 0xf8400ca108, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf8400ca108, 0xf840047bd0, 0xf84009e020, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).ProxyConnection
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:273 +0x2e6
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 134 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84005f860, 0xf840129b80, 0xf840125ff8, 0xf84005f858, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 135 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840111090, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840111090, 0xf8401bc000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400ca730, 0xf8401bc000, 0x800000008000, 0xf80000000a, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400cfe80, 0xf840047bd0, 0xf8400ca730, 0x166c8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf8400b6b50, 0xf840047bd0, 0xf8400ca730, 0xf8400b6b50, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf8400b6b50, 0xf840047bd0, 0xf8400ca730, 0xf84009ff90, 0xf8400b6b50, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf8400b6b50, 0xf840047bd0, 0xf8400ca730, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*ConnectionRequest).ProxyConnection(0xf8401248c0, 0xf8400642a0, 0xf8400ca730, 0xf840137100, 0x14, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:274 +0x370
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Approved
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:222 +0x1a4
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 160 [select]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf8400b6590, 0xf8400cfd00, 0xf8400b6598, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:177 +0x789
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 143 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840094c60, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840094c60, 0xf8401dc000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400dc1f8, 0xf8401dc000, 0x800000008000, 0xf800000008, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400cf370, 0xf840047bd0, 0xf8400dc1f8, 0x131b7, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf8400b6628, 0xf840047bd0, 0xf8400dc1f8, 0xf8400b6628, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf8400b6628, 0xf840047bd0, 0xf8400dc1f8, 0xf84009ff90, 0xf8400b6628, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf8400b6628, 0xf840047bd0, 0xf8400dc1f8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*ConnectionRequest).ProxyConnection(0xf840124ee0, 0xf8400642a0, 0xf8400dc1f8, 0xf840137c80, 0x14, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:274 +0x370
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Approved
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:222 +0x1a4
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 934 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e8a80, 0x200000002, 0xf8403e9d38)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e9d38, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bacd01, 0xf8403e8a80, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bacdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403ed870, 0x300000027, 0xf8403e8a60, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e4180, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403eacb8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403eacb8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 123 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84013e730, 0xf840129340, 0xf840125b58, 0xf84013e728, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 116 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84013e0c8, 0xf840120cc0, 0xf840125710, 0xf84013e0c0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 87 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840111480, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840111480, 0xf84005fa80, 0x800000001, 0x7f37ffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400dc640, 0xf84005fa80, 0x800000001, 0xf84005fa80, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.ReadAtLeast(0xf840047bd0, 0xf8400dc640, 0xf84005fa80, 0x800000001, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:266 +0xc3
Jul 17 21:02:53 i-e331c191 prism-3: io.ReadFull(0xf840047bd0, 0xf8400dc640, 0xf84005fa80, 0x800000001, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:285 +0x69
Jul 17 21:02:53 i-e331c191 prism-3: encoding/binary.Read(0xf840047bd0, 0xf8400dc640, 0xf840064c00, 0x50041b935, 0x4b3a40, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/encoding/binary/binary.go:133 +0xd2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*McReader).Byte(0xf84005e990, 0xf840144b01, 0x0, 0x0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:89 +0xb2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*McReader).PingPacket(0xf84005e990, 0xf840144b40, 0x0, 0x0, 0xf8400dc640, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:30 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8400dc640)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:19 +0xc5
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8400dc640)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 109 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840094480, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840094480, 0xf84016c000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400b6fd0, 0xf84016c000, 0x800000008000, 0xf80000002a, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400a4a70, 0xf840047bd0, 0xf8400b6fd0, 0x19674, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf84009e7b0, 0xf840047bd0, 0xf8400b6fd0, 0xf84009e7b0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf84009e7b0, 0xf840047bd0, 0xf8400b6fd0, 0xf84009ff90, 0xf84009e7b0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf84009e7b0, 0xf840047bd0, 0xf8400b6fd0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*ConnectionRequest).ProxyConnection(0xf840116f50, 0xf8400642a0, 0xf8400b6fd0, 0xf840114f80, 0x14, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:274 +0x370
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Approved
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:222 +0x1a4
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 108 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84012db00, 0xf840120530, 0xf8401251b0, 0xf84012daf8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 168 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840132b40, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840132b40, 0xf8400b4000, 0x100000001000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf84005fe68, 0xf8400b4000, 0x100000001000, 0xfba00000000, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: bufio.(*Reader).fill(0xf840144a00, 0xfba00000000)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/bufio/bufio.go:77 +0xf0
Jul 17 21:02:53 i-e331c191 prism-3: bufio.(*Reader).ReadSlice(0xf840144a00, 0x41b60a, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/bufio/bufio.go:257 +0x1b6
Jul 17 21:02:53 i-e331c191 prism-3: bufio.(*Reader).ReadBytes(0xf840144a00, 0xf84014470a, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/bufio/bufio.go:335 +0xb8
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*conn).readReply(0xf840137320, 0xf840144800, 0x45a511, 0xf8400cea00)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/conn.go:288 +0x4e
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sub).read(0xf8400cea00, 0xf840137320, 0xf840144800, 0x414cca, 0xf8400cea00, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:211 +0x29
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sub).listen(0xf8400cea00, 0x0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:244 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: created by github.com/simonz05/godis/redis.(*Sub).subscribe
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:260 +0x5d
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 138 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84005f718, 0xf840129e80, 0xf84012d1f0, 0xf84005f710, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 142 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84005f278, 0xf84012f140, 0xf84012d380, 0xf84005f270, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 932 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e8800, 0x200000002, 0xf8403e9978)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e9978, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bafd01, 0xf8403e8800, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bafdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403e6760, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e4ea0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403ea8a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403ea8a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 707 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf840268cc8, 0xf8402932c0, 0xf840298120, 0xf840268cc0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 510 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840318480, 0x200000002, 0xf84030beb8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84030beb8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bb1d01, 0xf840318480, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bb1df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf84030dcf0, 0x300000027, 0xf840318460, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf84030d180, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84031e048)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84031e048)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 165 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8400caf20, 0xf8400cf770, 0xf8400b6310, 0xf8400caf18, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 150 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf8401111b0, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf8401111b0, 0xf8401ee000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400ca670, 0xf8401ee000, 0x800000008000, 0xf80000002a, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400cf170, 0xf840047bd0, 0xf8400ca670, 0x164ad, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf8400cafc8, 0xf840047bd0, 0xf8400ca670, 0xf8400cafc8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf8400cafc8, 0xf840047bd0, 0xf8400ca670, 0xf84009ff90, 0xf8400cafc8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf8400cafc8, 0xf840047bd0, 0xf8400ca670, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*ConnectionRequest).ProxyConnection(0xf840124c40, 0xf8400642a0, 0xf8400ca670, 0xf8401379e0, 0x14, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:274 +0x370
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Approved
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:222 +0x1a4
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 153 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840132480, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840132480, 0xf840174000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf84009e7b0, 0xf840174000, 0x800000008000, 0xf800000011, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf84005e570, 0xf840047bd0, 0xf84009e7b0, 0x1e6007, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf8400b6fd0, 0xf840047bd0, 0xf84009e7b0, 0xf8400b6fd0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf8400b6fd0, 0xf840047bd0, 0xf84009e7b0, 0xf84009ff90, 0xf8400b6fd0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf8400b6fd0, 0xf840047bd0, 0xf84009e7b0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).ProxyConnection
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:273 +0x2e6
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 161 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840111b40, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840111b40, 0xf8401e4000, 0x800000008000, 0xffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8400b6628, 0xf8401e4000, 0x800000008000, 0xf8000000f2, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf84009ffc0, 0xf8400cf700, 0xf840047bd0, 0xf8400b6628, 0x1f5ca4, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:360 +0x20c
Jul 17 21:02:53 i-e331c191 prism-3: net.genericReadFrom(0xf840047c00, 0xf8400dc1f8, 0xf840047bd0, 0xf8400b6628, 0xf8400dc1f8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/sock.go:86 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).ReadFrom(0xf8400dc1f8, 0xf840047bd0, 0xf8400b6628, 0xf84009ff90, 0xf8400dc1f8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:95 +0xb6
Jul 17 21:02:53 i-e331c191 prism-3: io.Copy(0xf840047c00, 0xf8400dc1f8, 0xf840047bd0, 0xf8400b6628, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:352 +0xc2
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).ProxyConnection
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:273 +0x2e6
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 935 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e8b20, 0x200000002, 0xf8403e9e58)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e9e58, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a82e01, 0xf8403e8b20, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f3703a82e70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8403e0730, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8403eae88, 0xf840064c00, 0x24030cdc0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8403eae88, 0x0, 0x0, 0xf8403eae88, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403eae88)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 498 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84030c308, 0xf840276840, 0xf840274b18, 0xf84030c300, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 956 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403fb600, 0x200000002, 0xf8403f6f18)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403f6f18, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a6ad01, 0xf8403fb600, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a6adf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403fa4b0, 0x300000027, 0xf8403fb5e0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403f5900, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403fd318)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403fd318)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 790 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840377ae0, 0x200000002, 0xf840376978)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840376978, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a6bd01, 0xf840377ae0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a6bdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840332cb0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840377a60, 0x14, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402df260)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402df260)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 716 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f3703a6ce58, 0x100000001, 0xf840258198)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840258198, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f3703a6ce58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f3703a6ce58, 0x100000001, 0x7f3703bc7eb8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f3703a6ce90, 0xf840233960, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840270c80, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf840288378, 0xf840280250, 0xf840288388, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 755 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402ff880, 0x200000002, 0xf8402a3978)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402a3978, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a6dd01, 0xf8402ff880, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a6ddf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402a8ae0, 0x300000027, 0xf8402ff860, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8401d46f0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c7718)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c7718)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 789 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840377980, 0x200000002, 0xf840376798)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840376798, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a6ed01, 0xf840377980, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a6edf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840332be0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840377900, 0x14, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402df4a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402df4a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 715 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f3703a6fe58, 0x100000001, 0xf840258138)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840258138, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f3703a6fe58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f3703a6fe58, 0x100000001, 0x7f3703bc8858, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f3703a6fe90, 0xf840255840, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840270d00, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf8402883e0, 0xf8402803a0, 0xf8402883e8, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 940 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403f4040, 0x200000002, 0xf8403ef738)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403ef738, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a70e01, 0xf8403f4040, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f3703a70e70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8403e07a0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8403f05d8, 0xf840064c00, 0x2403066e0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8403f05d8, 0x0, 0x0, 0xf8403f05d8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f05d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 941 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403f41a0, 0x200000002, 0xf8403ef918)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403ef918, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a71d01, 0xf8403f41a0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a71df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403f5090, 0x300000027, 0xf8403f4180, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e41e0, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f0678)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f0678)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 943 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403f4780, 0x200000002, 0xf8403f6558)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403f6558, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a83d01, 0xf8403f4780, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a83df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403f5cf0, 0x300000027, 0xf8403f4760, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403f5600, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f0978)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f0978)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 945 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403f4d40, 0x200000002, 0xf8403f6858)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403f6858, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bb5d01, 0xf8403f4d40, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bb5df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403fa000, 0x300000027, 0xf8403f4d20, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e4f00, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f0c58)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f0c58)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 946 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403f4ca0, 0x200000002, 0xf8403f6738)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403f6738, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bb6d01, 0xf8403f4ca0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bb6df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403f5ea0, 0x300000027, 0xf8403f4c80, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e4f60, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f0bb8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f0bb8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 947 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403f4660, 0x200000002, 0xf8403f6318)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403f6318, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bb7d01, 0xf8403f4660, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bb7df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403f5450, 0x300000027, 0xf8403f4640, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403f5720, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f0e98)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f0e98)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 944 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403f4700, 0x200000002, 0xf8403f6438)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403f6438, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bb8d01, 0xf8403f4700, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bb8df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403f55a0, 0x300000027, 0xf8403f46e0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403f5660, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f0aa8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f0aa8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 949 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403fb0a0, 0x200000002, 0xf8403e1498)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e1498, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bb9d01, 0xf8403fb0a0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bb9df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403e4450, 0x300000027, 0xf8403fb080, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403f57e0, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f8630)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f8630)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 713 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f3703bbae58, 0x100000001, 0xf8401ed1f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8401ed1f8, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f3703bbae58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f3703bbae58, 0x100000001, 0x7f3703bc82d8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f3703bbae90, 0xf84023f9f0, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840079c00, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf84027f398, 0xf840276710, 0xf84027f3a0, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 948 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d9f60, 0x200000002, 0xf8403e12b8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e12b8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a72d01, 0xf8403d9f60, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a72df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403d1dc0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403f5780, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f81a8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f81a8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 950 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403fb2e0, 0x200000002, 0xf8403e1858)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e1858, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a73d01, 0xf8403fb2e0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a73df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403fa7b0, 0x300000027, 0xf8403fb2c0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403f5840, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f8810)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f8810)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 952 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403fb380, 0x200000002, 0xf8403e1978)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e1978, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a84e01, 0xf8403fb380, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f3703a84e70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8403f8298, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8403f8ba0, 0xf840064c00, 0x2403001e8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8403f8ba0, 0x0, 0x0, 0xf8403f8ba0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f8ba0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 959 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403fb8a0, 0x200000002, 0xf8403ff3d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403ff3d8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a50d01, 0xf8403fb8a0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a50df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403f9c90, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403fa960, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403fd6b8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403fd6b8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 454 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402eea20, 0x300000003, 0xf84029b2c0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84029b2c0, 0x1520000010a, 0x1520000010a, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x240308801, 0xf8402eea20, 0x300000003, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendIface(0xf8400446c0, 0xf840044680, 0x52f0cc, 0x5355504c00000005, 0x7f3703a51d58, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:322 +0x22f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Lpush(0xf84005e2d0, 0x542e9c, 0x79616c700000001a, 0x4b47c0, 0xf8403088d0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:318 +0xde
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).PushConnectionReq(0xf840079000, 0xf840365ee0, 0xf8402d58c8, 0xf840308be0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:89 +0xd1
Jul 17 21:02:53 i-e331c191 prism-3: main.(*ConnectionRequest).Process(0xf840365ee0, 0xf8400642a0, 0xf8402dfb68, 0xf8402eb740, 0xf8403691a0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:207 +0x17b
Jul 17 21:02:53 i-e331c191 prism-3: main.handleLogin(0xf8400642a0, 0xf8402dfb68)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:102 +0x423
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402dfb68)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:56 +0x1ca
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 478 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402f5c60, 0x300000003, 0xf840373000)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840373000, 0x15800000110, 0x15800000110, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x240332901, 0xf8402f5c60, 0x300000003, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendIface(0xf8400446c0, 0xf840044680, 0x52f0cc, 0x5355504c00000005, 0x7f3703a52d58, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:322 +0x22f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Lpush(0xf84005e2d0, 0x542e9c, 0x79616c700000001a, 0x4b47c0, 0xf8403329a0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:318 +0xde
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).PushConnectionReq(0xf840079000, 0xf840095230, 0xf8402dfe48, 0xf840332580)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:89 +0xd1
Jul 17 21:02:53 i-e331c191 prism-3: main.(*ConnectionRequest).Process(0xf840095230, 0xf8400642a0, 0xf840300078, 0xf8402e4000, 0xf840369780, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:207 +0x17b
Jul 17 21:02:53 i-e331c191 prism-3: main.handleLogin(0xf8400642a0, 0xf840300078)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:102 +0x423
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840300078)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:56 +0x1ca
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 453 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8402df9e8, 0xf84026df20, 0xf840274208, 0xf8402df9e0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 953 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403f4ea0, 0x200000002, 0xf8403f6a38)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403f6a38, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a54d01, 0xf8403f4ea0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a54df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403f9800, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403f4e20, 0x14, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f8c28)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f8c28)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 475 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8402f6ae0, 0xf8402765c0, 0xf840274928, 0xf8402f6ad8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 951 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403fb260, 0x200000002, 0xf8403e1738)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e1738, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a56d01, 0xf8403fb260, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a56df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403fa660, 0x300000027, 0xf8403fb240, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403f58a0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f8920)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f8920)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 960 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403fb9a0, 0x200000002, 0xf8403ff5b8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403ff5b8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a57d01, 0xf8403fb9a0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a57df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403fafc0, 0x300000027, 0xf8403fb980, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403fa9c0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403fdaa0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403fdaa0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 957 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403fba20, 0x200000002, 0xf8403ff6d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403ff6d8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a75d01, 0xf8403fba20, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a75df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840401120, 0x300000027, 0xf8403fba00, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403fa8a0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403fd4f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403fd4f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 954 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403f4ee0, 0x200000002, 0xf8403f6b58)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403f6b58, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a76d01, 0xf8403f4ee0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a76df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403f9870, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e4fc0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f8e20)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f8e20)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 955 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403fb400, 0x200000002, 0xf8403f6d38)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403f6d38, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a77d01, 0xf8403fb400, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a77df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403fa360, 0x300000027, 0xf8403f4fe0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403f5a20, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403fd0d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403fd0d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 781 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8402dfce8, 0xf8402803a0, 0xf8402883e0, 0xf8402dfce0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 504 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84030c818, 0xf840276bb0, 0xf840274f68, 0xf84030c810, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 714 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f3703a1be58, 0x100000001, 0xf8401ed378)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8401ed378, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f3703a1be58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f3703a1be58, 0x100000001, 0x7f3703bc82d8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f3703a1be90, 0xf84023fba0, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840079c80, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf840288f40, 0xf840276020, 0xf840288f48, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 958 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403fb860, 0x200000002, 0xf8403ff2b8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403ff2b8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a85d01, 0xf8403fb860, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a85df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403fad20, 0x300000027, 0xf8403fb840, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403fa900, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403fd608)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403fd608)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 937 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e8e00, 0x200000002, 0xf8403ef378)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403ef378, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20045bd01, 0xf8403e8e00, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370045bdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403edcc0, 0x300000027, 0xf8403e8de0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840303030, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f0178)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f0178)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 938 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e8f20, 0x200000002, 0xf8403ef558)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403ef558, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20045cd01, 0xf8403e8f20, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370045cdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403ede70, 0x300000027, 0xf8403e8f00, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840303090, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f0358)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f0358)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 501 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84030c590, 0xf8402598c0, 0xf840274af0, 0xf84030c588, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 774 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8402d57d0, 0xf840276710, 0xf84027f398, 0xf8402d57c8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 788 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840377820, 0x200000002, 0xf8403765b8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403765b8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20045fd01, 0xf840377820, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370045fdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840301600, 0x300000027, 0xf840377800, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402b4810, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402df6d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402df6d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 559 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84009e628, 0xf840280710, 0xf84027fc58, 0xf84009e620, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 936 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e8ce0, 0x200000002, 0xf8403ef198)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403ef198, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200461d01, 0xf8403e8ce0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700461df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403edb10, 0x300000027, 0xf8403e8cc0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf84030df90, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403eafb8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403eafb8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 787 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8402df628, 0xf8402862e0, 0xf84028f2c0, 0xf8402df620, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 607 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84012deb8, 0xf8402864a0, 0xf840288320, 0xf84012deb0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 779 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8401ed600, 0x0, 0x0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sub).write(0xf840369d40, 0xf840231580, 0xad00000047, 0xad00000047, 0x7f3700467e78, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:218 +0x46
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf84009d880, 0xf840369d40, 0x200467e00, 0xf840369d60, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.appendSendStr(0xf84009d880, 0xf840369d40, 0x5308fc, 0x5342555300000009, 0x7f3700467e78, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:337 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sub).Subscribe(0xf840369d40, 0x7f3700467e78, 0x100000001, 0x7f3700467e10, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:858 +0x75
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Subscribe(0xf84005e2d0, 0x7f3700467e78, 0x100000001, 0xf8402f5d80, 0x7f370000002d, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:814 +0xa5
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).ConnectionReqReply(0xf84027dc00, 0xf8403325f0, 0xc, 0xf84027dc00, 0x100415301, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:93 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf8402dfe48, 0xf840332580, 0xf8402dfe50, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:147 +0x98
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 777 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8402d53b0, 0xf840276020, 0xf840288f40, 0xf8402d53a8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 712 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f3703a86e58, 0x100000001, 0xf8401ed198)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8401ed198, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f3703a86e58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f3703a86e58, 0x100000001, 0x7f3703bc82d8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f3703a86e90, 0xf84023f2a0, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840079b80, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf84027fc88, 0xf84026d070, 0xf84027fc90, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 884 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403c0980, 0x200000002, 0xf8403c7078)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403c7078, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20043bd01, 0xf8403c0980, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370043bdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403c25a0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840393510, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403c5330)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403c5330)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 837 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84031eaf0, 0xf84029eec0, 0xf8402a1808, 0xf84031eae8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 882 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403c07e0, 0x200000002, 0xf8403bdd38)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bdd38, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20041ae01, 0xf8403c07e0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f370041ae70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf840334d18, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8403c50e0, 0xf840064c00, 0x24009e0c8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8403c50e0, 0x0, 0x0, 0xf8403c50e0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403c50e0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 813 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382f00, 0x200000002, 0xf840387eb8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840387eb8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200420d01, 0xf840382f00, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700420df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840389450, 0x300000027, 0xf840382ee0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403843c0, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403002e8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403002e8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 812 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382de0, 0x200000002, 0xf840387cd8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840387cd8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200422d01, 0xf840382de0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700422df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403892a0, 0x300000027, 0xf840382dc0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840384f90, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840300528)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840300528)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 740 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402f2e60, 0x200000002, 0xf840292a38)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840292a38, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200424d01, 0xf8402f2e60, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700424df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840297c60, 0x300000027, 0xf8402f2e40, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402b4cc0, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402b82d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402b82d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 767 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840335640, 0x200000002, 0xf8401ed018)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8401ed018, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200425d01, 0xf840335640, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700425df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402e0000, 0x300000027, 0xf840335620, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402d3240, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402cd248)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402cd248)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 763 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840335a60, 0x200000002, 0xf8402b3978)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402b3978, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200427d01, 0xf840335a60, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700427df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402e0690, 0x300000027, 0xf840335a40, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402d3ea0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402cd7e8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402cd7e8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 691 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84025bbd8, 0xf840286d60, 0xf8402887c8, 0xf84025bbd0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 735 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8402b8770, 0xf840259a50, 0xf840268930, 0xf8402b8768, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 694 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84025b748, 0xf84028d760, 0xf84028f0f0, 0xf84025b740, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 697 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84025b5a8, 0xf84028da60, 0xf84028f2e8, 0xf84025b5a0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 794 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840377e80, 0x200000002, 0xf840376f78)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840376f78, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20042ed01, 0xf840377e80, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370042edf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402f5420, 0x300000027, 0xf840377e60, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402f53c0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402efa90)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402efa90)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 450 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8402df760, 0xf84026d6e0, 0xf840268b50, 0xf8402df758, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 730 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402587e0, 0x0, 0x0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sub).write(0xf8402e1480, 0xf840311630, 0xaa00000044, 0xaa00000044, 0x7f3700440e78, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:218 +0x46
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf84009d880, 0xf8402e1480, 0x200440e00, 0xf8402e14a0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.appendSendStr(0xf84009d880, 0xf8402e1480, 0x5308fc, 0x5342555300000009, 0x7f3700440e78, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:337 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sub).Subscribe(0xf8402e1480, 0x7f3700440e78, 0x100000001, 0x7f3700440e10, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:858 +0x75
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Subscribe(0xf84005e2d0, 0x7f3700440e78, 0x100000001, 0xf8402a80f0, 0x7f370000002a, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:814 +0xa5
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).ConnectionReqReply(0xf840079080, 0xf84028d130, 0x9, 0xf840079080, 0xf840236560, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:93 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf8402b8b30, 0xf84028d1c0, 0xf8402b8b38, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:147 +0x98
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 700 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84025b108, 0xf84028ddd0, 0xf84028f540, 0xf84025b100, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 739 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402f2c40, 0x200000002, 0xf8402927f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402927f8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200432d01, 0xf8402f2c40, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700432df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402e33c0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402b4a50, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402b8510)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402b8510)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 358 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f3700433e58, 0x100000001, 0xf8402c2d38)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402c2d38, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f3700433e58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f3700433e58, 0x100000001, 0x7f3703bc9cf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f3700433e90, 0xf840291630, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840122080, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf84028f540, 0xf84028ddd0, 0xf84028f548, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 784 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8402dfab8, 0xf840280250, 0xf840288378, 0xf8402dfab0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 710 [runnable]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f3700444e58, 0x100000001, 0xf840248438)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840248438, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f3700444e58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f3700444e58, 0x100000001, 0x7f3703bc7eb8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f3700444e90, 0xf840233330, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840122c80, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf840268930, 0xf840259a50, 0xf840268938, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 711 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f3700446e58, 0x100000001, 0xf8401ed078)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8401ed078, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f3700446e58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f3700446e58, 0x100000001, 0x7f3703bc82d8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f3700446e90, 0xf84023ff90, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840079b00, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf840268148, 0xf840259710, 0xf840268150, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 732 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8402b88d0, 0xf840259c30, 0xf8402684c8, 0xf8402b88c8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 364 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840269750, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf840269750, 0xf840298318, 0x800000001, 0x7f37ffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8402982e8, 0xf840298318, 0x800000001, 0xf840298318, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.ReadAtLeast(0xf840047bd0, 0xf8402982e8, 0xf840298318, 0x800000001, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:266 +0xc3
Jul 17 21:02:53 i-e331c191 prism-3: io.ReadFull(0xf840047bd0, 0xf8402982e8, 0xf840298318, 0x800000001, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:285 +0x69
Jul 17 21:02:53 i-e331c191 prism-3: encoding/binary.Read(0xf840047bd0, 0xf8402982e8, 0xf840064c00, 0x50041b935, 0x4b3a40, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/encoding/binary/binary.go:133 +0xd2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*McReader).Byte(0xf840293cf0, 0xf84029d001, 0x0, 0x0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:89 +0xb2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*McReader).PingPacket(0xf840293cf0, 0xf84029d0c0, 0x0, 0x0, 0xf8402982e8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:30 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402982e8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:19 +0xc5
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402982e8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 362 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf8402981d8, 0xf840259bf0, 0xf840268080, 0xf8402981d0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 339 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf8401d7c60, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf8401d7c60, 0xf84025b4f0, 0x800000001, 0x7f37ffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf84025b4c0, 0xf84025b4f0, 0x800000001, 0xf84025b4f0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.ReadAtLeast(0xf840047bd0, 0xf84025b4c0, 0xf84025b4f0, 0x800000001, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:266 +0xc3
Jul 17 21:02:53 i-e331c191 prism-3: io.ReadFull(0xf840047bd0, 0xf84025b4c0, 0xf84025b4f0, 0x800000001, 0x800000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:285 +0x69
Jul 17 21:02:53 i-e331c191 prism-3: encoding/binary.Read(0xf840047bd0, 0xf84025b4c0, 0xf840064c00, 0x50041b935, 0x4b3a40, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/encoding/binary/binary.go:133 +0xd2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*McReader).Byte(0xf840259820, 0xf84025aa01, 0x0, 0x0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:89 +0xb2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*McReader).PingPacket(0xf840259820, 0xf84025aac0, 0x0, 0x0, 0xf84025b4c0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:30 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84025b4c0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:19 +0xc5
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84025b4c0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 931 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e8bc0, 0x200000002, 0xf8403e9f78)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e9f78, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a97d01, 0xf8403e8bc0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a97df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403ed960, 0x300000027, 0xf8403e8ba0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e4e40, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403ea730)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403ea730)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 930 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e8580, 0x200000002, 0xf8403e9498)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e9498, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bbbd01, 0xf8403e8580, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bbbdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403e6590, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e4de0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403ea3d0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403ea3d0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 929 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e8620, 0x200000002, 0xf8403e95b8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e95b8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bbcd01, 0xf8403e8620, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bbcdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403ed1b0, 0x300000027, 0xf8403e8600, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e4d80, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403ea2c0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403ea2c0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 844 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84031e1e8, 0xf8402adac0, 0xf8402a7910, 0xf84031e1e0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 928 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e86a0, 0x200000002, 0xf8403e96d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e96d8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bbed01, 0xf8403e86a0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bbedf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403ed300, 0x300000027, 0xf8403e8680, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e4d20, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403ea1b0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403ea1b0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 927 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e8360, 0x200000002, 0xf8403e9138)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e9138, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bbfd01, 0xf8403e8360, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bbfdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403e4a50, 0x300000027, 0xf8403e8340, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e4cc0, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403e0fd0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403e0fd0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 942 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403f4540, 0x200000002, 0xf8403f6138)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403f6138, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003ffd01, 0xf8403f4540, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003ffdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403e6f00, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840303390, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403f0898)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403f0898)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 925 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e81c0, 0x200000002, 0xf8403e1e58)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e1e58, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bc0d01, 0xf8403e81c0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bc0df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403e4840, 0x300000027, 0xf8403e81a0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e4c00, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403e0ca0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403e0ca0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 924 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403e80a0, 0x200000002, 0xf8403e1c78)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e1c78, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20044ed01, 0xf8403e80a0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370044edf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403e4690, 0x300000027, 0xf8403e8080, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403e40c0, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403e0b18)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403e0b18)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 923 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d9760, 0x200000002, 0xf8403bca98)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bca98, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bc1e01, 0xf8403d9760, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f3703bc1e70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8403e0448, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8403e0a78, 0xf840064c00, 0x2403277b0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8403e0a78, 0x0, 0x0, 0xf8403e0a78, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403e0a78)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 914 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d9b20, 0x200000002, 0xf8403dbc18)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403dbc18, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203bc2d01, 0xf8403d9b20, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703bc2df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403dc840, 0x300000027, 0xf8403d9b00, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403c4e70, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403d8c08)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403d8c08)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 921 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d95a0, 0x200000002, 0xf8403bc798)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bc798, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20044fd01, 0xf8403d95a0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370044fdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403d1f10, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403dcc00, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403e0688)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403e0688)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 922 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d96c0, 0x200000002, 0xf8403bc978)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bc978, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003dad01, 0xf8403d96c0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003dadf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403dced0, 0x300000027, 0xf8403d96a0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403c4f90, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403e0898)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403e0898)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 920 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840045680, 0x200000002, 0xf84030b498)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84030b498, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a1fe01, 0xf840045680, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f3703a1fe70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8403e0540, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8400dce58, 0xf840064c00, 0x2004b50e8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8400dce58, 0x0, 0x0, 0xf8400dce58, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8400dce58)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 916 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d9d20, 0x200000002, 0xf8403dbf18)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403dbf18, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200450d01, 0xf8403d9d20, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700450df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403d1bc0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403d9ca0, 0x14, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403e00f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403e00f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 915 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d9bc0, 0x200000002, 0xf8403dbd38)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403dbd38, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200451d01, 0xf8403d9bc0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700451df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403dc9f0, 0x300000027, 0xf8403d9ba0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403c4ed0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403d8ee8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403d8ee8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 912 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d98a0, 0x200000002, 0xf8403db858)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403db858, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200452d01, 0xf8403d98a0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700452df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403d18d0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403c4db0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403d8760)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403d8760)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 913 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d9a00, 0x200000002, 0xf8403dba38)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403dba38, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200453d01, 0xf8403d9a00, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700453df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403d19b0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403d9980, 0x14, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403d8988)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403d8988)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 911 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d9460, 0x200000002, 0xf8403bc678)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bc678, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200454d01, 0xf8403d9460, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700454df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403dc4e0, 0x300000027, 0xf8403d9440, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403caf30, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403d8678)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403d8678)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 910 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d92a0, 0x200000002, 0xf8403db378)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403db378, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200455d01, 0xf8403d92a0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700455df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403dc2a0, 0x300000027, 0xf8403d9280, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403caed0, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403d82c0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403d82c0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 717 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f3700456e58, 0x100000001, 0xf840292198)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840292198, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f3700456e58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f3700456e58, 0x100000001, 0x7f3703bc8858, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f3700456e90, 0xf840255540, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840270b80, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf84028f2c0, 0xf8402862e0, 0xf84028f2c8, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 814 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038d700, 0x200000002, 0xf84038f678)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84038f678, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200457d01, 0xf84038d700, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700457df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840389900, 0x300000027, 0xf84038d6e0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402ca8a0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840300178)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840300178)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 908 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d92c0, 0x200000002, 0xf8403db3d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403db3d8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200458d01, 0xf8403d92c0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700458df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403d16f0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403cae10, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403d8180)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403d8180)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 907 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d9300, 0x200000002, 0xf8403db4f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403db4f8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200459d01, 0xf8403d9300, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700459df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403d1750, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403cacc0, 0x21, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403cce70)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403cce70)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 909 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf8403c3f30, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf8403c3f30, 0xf8403d8578, 0x800000002, 0x7f37ffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8403d8240, 0xf8403d8578, 0x800000002, 0xf8403d8578, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.ReadAtLeast(0xf840047bd0, 0xf8403d8240, 0xf8403d8578, 0x800000002, 0x2, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:266 +0xc3
Jul 17 21:02:53 i-e331c191 prism-3: io.ReadFull(0xf840047bd0, 0xf8403d8240, 0xf8403d8578, 0x800000002, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:285 +0x69
Jul 17 21:02:53 i-e331c191 prism-3: encoding/binary.Read(0xf840047bd0, 0xf8403d8240, 0xf840064c00, 0x1, 0x4b1eb0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/encoding/binary/binary.go:133 +0xd2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*McReader).String(0xf8403d1370, 0x0, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:111 +0xf8
Jul 17 21:02:53 i-e331c191 prism-3: main.(*McReader).PingPacket(0xf8403d1370, 0xf8403d2340, 0x0, 0x0, 0xf8403d8240, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:34 +0xd4
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403d8240)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:19 +0xc5
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403d8240)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 905 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403cbf20, 0x200000002, 0xf8403cd918)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403cd918, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003bbd01, 0xf8403cbf20, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003bbdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403ca990, 0x300000027, 0xf8403cbf00, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403c4510, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403ccb88)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403ccb88)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 906 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403d9060, 0x200000002, 0xf8403cdb58)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403cdb58, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003bcd01, 0xf8403d9060, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003bcdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403c4cc0, 0x300000027, 0xf8403d9040, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403c4570, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403cccf8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403cccf8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 894 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403cb320, 0x200000002, 0xf8403c7f18)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403c7f18, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003bde01, 0xf8403cb320, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f37003bde70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8403c5e70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8403cc278, 0xf840064c00, 0x240334ac8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8403cc278, 0x0, 0x0, 0xf8403cc278, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403cc278)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 893 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403cb260, 0x200000002, 0xf8403c7df8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403c7df8, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003dbe01, 0xf8403cb260, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f37003dbe70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8403c5e60, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8403cc1d8, 0xf840064c00, 0x24005fe30)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8403cc1d8, 0x0, 0x0, 0xf8403cc1d8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403cc1d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 892 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403cb1c0, 0x200000002, 0xf8403c7cd8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403c7cd8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003dcd01, 0xf8403cb1c0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003dcdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403ca300, 0x300000027, 0xf8403cb1a0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403c4330, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403cc028)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403cc028)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 826 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038dce0, 0x200000002, 0xf84038f858)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84038f858, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003bed01, 0xf84038dce0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003bedf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840389a50, 0x300000027, 0xf84038dcc0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840392180, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84030c8d0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84030c8d0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 889 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403c0f40, 0x200000002, 0xf8403c78b8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403c78b8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200400d01, 0xf8403c0f40, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700400df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403ca150, 0x300000027, 0xf8403c0f20, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf84030de10, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403c5c08)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403c5c08)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 887 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403c0c20, 0x200000002, 0xf8403c74f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403c74f8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a98d01, 0xf8403c0c20, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a98df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403c4a50, 0x300000027, 0xf8403c0c00, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403c4d20, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403c56e8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403c56e8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 718 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f37003dde58, 0x100000001, 0xf8402921f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402921f8, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f37003dde58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f37003dde58, 0x100000001, 0x7f3703bc9250, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f37003dde90, 0xf840272c00, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840122d00, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf840298b40, 0xf840259360, 0xf840298b58, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 891 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403cb0a0, 0x200000002, 0xf8403c7af8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403c7af8, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003dee01, 0xf8403cb0a0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f37003dee70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8403c5e10, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8403c5f88, 0xf840064c00, 0x24005f550)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8403c5f88, 0x0, 0x0, 0xf8403c5f88, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403c5f88)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 856 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403a8f80, 0x200000002, 0xf8403b2678)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403b2678, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200401d01, 0xf8403a8f80, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700401df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403a2e10, 0x300000027, 0xf8403a8f60, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840392330, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403272c8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403272c8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 885 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403c0a80, 0x200000002, 0xf8403c7258)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403c7258, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200402d01, 0xf8403c0a80, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700402df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403c4840, 0x300000027, 0xf8403c0a60, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403c4c60, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403c5518)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403c5518)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 890 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403c0fe0, 0x200000002, 0xf8403c79d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403c79d8, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a99e01, 0xf8403c0fe0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f3703a99e70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8403c5e00, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8403c5de8, 0xf840064c00, 0x24009ee00)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8403c5de8, 0x0, 0x0, 0xf8403c5de8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403c5de8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 883 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403b7ec0, 0x200000002, 0xf8403bc558)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bc558, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200403d01, 0xf8403b7ec0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700403df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403c4630, 0x300000027, 0xf8403b7ea0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403934b0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403c5180)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403c5180)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 881 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403c0720, 0x200000002, 0xf8403bdc18)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bdc18, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200404e01, 0xf8403c0720, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f3700404e70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf840334d08, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8403c5040, 0xf840064c00, 0x2400b6e50)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8403c5040, 0x0, 0x0, 0xf8403c5040, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403c5040)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 878 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403c0560, 0x200000002, 0xf8403bd918)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bd918, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a9ad01, 0xf8403c0560, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a9adf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403bacc0, 0x300000027, 0xf8403c0540, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403c4090, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840334908)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840334908)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 879 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403c0680, 0x200000002, 0xf8403bdaf8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bdaf8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a9bd01, 0xf8403c0680, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a9bdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403bae70, 0x300000027, 0xf8403c0660, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403c40f0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840334e80)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840334e80)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 888 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403c0e20, 0x200000002, 0xf8403c76d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403c76d8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20039ad01, 0xf8403c0e20, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370039adf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403c4ba0, 0x300000027, 0xf8403c0e00, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf84030dcc0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403c5a28)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403c5a28)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 873 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403c0040, 0x200000002, 0xf8403bd438)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bd438, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20039be01, 0xf8403c0040, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f370039be70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8403343c8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8403346f8, 0xf840064c00, 0x2400b6750)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8403346f8, 0x0, 0x0, 0xf8403346f8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403346f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 872 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403b7b80, 0x200000002, 0xf8403bd318)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bd318, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20039ce01, 0xf8403b7b80, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f370039ce70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8403343b8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf840334648, 0xf840064c00, 0x2400b64d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf840334648, 0x0, 0x0, 0xf840334648, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840334648)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 871 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403b7ac0, 0x200000002, 0xf8403bd1f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bd1f8, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003bfe01, 0xf8403b7ac0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f37003bfe70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8403343a8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8403345a8, 0xf840064c00, 0x2400b63e0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8403345a8, 0x0, 0x0, 0xf8403345a8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403345a8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 869 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf84038a5a0, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf84038a5a0, 0xf8403341b8, 0x800000002, 0x7f37ffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf840334178, 0xf8403341b8, 0x800000002, 0xf8403341b8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.ReadAtLeast(0xf840047bd0, 0xf840334178, 0xf8403341b8, 0x800000002, 0x2, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:266 +0xc3
Jul 17 21:02:53 i-e331c191 prism-3: io.ReadFull(0xf840047bd0, 0xf840334178, 0xf8403341b8, 0x800000002, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:285 +0x69
Jul 17 21:02:53 i-e331c191 prism-3: encoding/binary.Read(0xf840047bd0, 0xf840334178, 0xf840064c00, 0x1, 0x4b1eb0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/encoding/binary/binary.go:133 +0xd2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*McReader).String(0xf8403b3980, 0x0, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:111 +0xf8
Jul 17 21:02:53 i-e331c191 prism-3: main.(*McReader).PingPacket(0xf8403b3980, 0xf8403bf140, 0x0, 0x0, 0xf840334178, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:34 +0xd4
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840334178)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:19 +0xc5
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840334178)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 868 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038dfc0, 0x200000002, 0xf8403bc2b8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bc2b8, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20039ee01, 0xf84038dfc0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f370039ee70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf84032da40, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8403340c0, 0xf840064c00, 0x2400cae78)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8403340c0, 0x0, 0x0, 0xf8403340c0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403340c0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 867 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf84035ccf0, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:53 i-e331c191 prism-3: net.(*netFD).Read(0xf84035ccf0, 0xf84032d0c8, 0x800000002, 0x7f37ffffffff, 0xf8400469f0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:53 i-e331c191 prism-3: net.(*TCPConn).Read(0xf84032d1e8, 0xf84032d0c8, 0x800000002, 0xf84032d0c8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:53 i-e331c191 prism-3: io.ReadAtLeast(0xf840047bd0, 0xf84032d1e8, 0xf84032d0c8, 0x800000002, 0x2, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:266 +0xc3
Jul 17 21:02:53 i-e331c191 prism-3: io.ReadFull(0xf840047bd0, 0xf84032d1e8, 0xf84032d0c8, 0x800000002, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:285 +0x69
Jul 17 21:02:53 i-e331c191 prism-3: encoding/binary.Read(0xf840047bd0, 0xf84032d1e8, 0xf840064c00, 0x1, 0x4b1eb0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/encoding/binary/binary.go:133 +0xd2
Jul 17 21:02:53 i-e331c191 prism-3: main.(*McReader).String(0xf8403b36d0, 0x0, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:111 +0xf8
Jul 17 21:02:53 i-e331c191 prism-3: main.(*McReader).PingPacket(0xf8403b36d0, 0xf8403be840, 0x0, 0x0, 0xf84032d1e8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:34 +0xd4
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84032d1e8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:19 +0xc5
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84032d1e8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 719 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840248ae0, 0x0, 0x0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sub).write(0xf84028e1c0, 0xf8401ec420, 0xac00000046, 0xac00000046, 0x7f370039fe78, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:218 +0x46
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf84009d880, 0xf84028e1c0, 0x20039fe00, 0xf84028e1e0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.appendSendStr(0xf84009d880, 0xf84028e1c0, 0x5308fc, 0x5342555300000009, 0x7f370039fe78, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:337 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sub).Subscribe(0xf84028e1c0, 0x7f370039fe78, 0x100000001, 0x7f370039fe10, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:858 +0x75
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Subscribe(0xf84005e2d0, 0x7f370039fe78, 0x100000001, 0xf840272630, 0x7f370000002c, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:814 +0xa5
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).ConnectionReqReply(0xf840122f80, 0xf840293f70, 0xb, 0xf840122f80, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:93 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf840298358, 0xf840293ae0, 0xf840298360, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:147 +0x98
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 866 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038df20, 0x200000002, 0xf8403bc198)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bc198, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003a0d01, 0xf84038df20, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003a0df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840393360, 0x300000027, 0xf84038df00, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403931e0, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84032d128)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84032d128)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 834 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84031ec80, 0xf840293950, 0xf8402980f8, 0xf84031ec78, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 720 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f37003a2e58, 0x100000001, 0xf840292258)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840292258, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f37003a2e58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f37003a2e58, 0x100000001, 0x7f3703bc9250, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f37003a2e90, 0xf840272090, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840079d80, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf8402980f8, 0xf840293950, 0xf8402a1ff8, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 865 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403b7880, 0x200000002, 0xf8403bcdf8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bcdf8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003a3d01, 0xf8403b7880, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003a3df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403ba960, 0x300000027, 0xf8403b7860, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840393180, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84032d4f0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84032d4f0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 839 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403a0420, 0x0, 0x0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sub).write(0xf8403a8220, 0xf840383c60, 0xaa00000044, 0xaa00000044, 0x7f37003a4e78, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:218 +0x46
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf84009d880, 0xf8403a8220, 0x2003a4e00, 0xf8403a8240, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.appendSendStr(0xf84009d880, 0xf8403a8220, 0x5308fc, 0x5342555300000009, 0x7f37003a4e78, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:337 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sub).Subscribe(0xf8403a8220, 0x7f37003a4e78, 0x100000001, 0x7f37003a4e10, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:858 +0x75
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Subscribe(0xf84005e2d0, 0x7f37003a4e78, 0x100000001, 0xf8403a2360, 0x7f370000002a, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:814 +0xa5
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).ConnectionReqReply(0xf840270800, 0xf8403954c0, 0x9, 0xf840270800, 0x100415301, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:93 +0xa7
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf84031e4c8, 0xf840395530, 0xf84031e4d0, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:147 +0x98
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 861 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038dde0, 0x200000002, 0xf84038fb58)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84038fb58, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003a5d01, 0xf84038dde0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003a5df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403b3820, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840392510, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84032dc00)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84032dc00)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 864 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403b7900, 0x200000002, 0xf8403bcf18)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bcf18, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003a6d01, 0xf8403b7900, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003a6df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403baa50, 0x300000027, 0xf8403b78e0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840393120, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84032d5c0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84032d5c0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 862 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038de80, 0x200000002, 0xf8403bc078)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bc078, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200406e01, 0xf84038de80, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f3700406e70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf840327538, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf84032d920, 0xf840064c00, 0x2400dcf48)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf84032d920, 0x0, 0x0, 0xf84032d920, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84032d920)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 863 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402ffe60, 0x200000002, 0xf84038ff18)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84038ff18, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003c0d01, 0xf8402ffe60, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003c0df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403ba6f0, 0x300000027, 0xf8402ffe40, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840392570, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84032d7f0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84032d7f0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 870 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403b7e60, 0x200000002, 0xf8403bc4f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403bc4f8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003c1d01, 0xf8403b7e60, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003c1df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840393420, 0x300000027, 0xf8403b7e40, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403ba4e0, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840334298)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840334298)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 804 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382780, 0x200000002, 0xf84037ef78)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84037ef78, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003c2d01, 0xf840382780, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003c2df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840380730, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402f95c0, 0xe, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402f6638)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402f6638)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 859 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403b75c0, 0x200000002, 0xf8403b2af8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403b2af8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003a7d01, 0xf8403b75c0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003a7df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403b35b0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840392450, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84032df88)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84032df88)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 857 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403b7500, 0x200000002, 0xf8403b2918)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403b2918, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003a8d01, 0xf8403b7500, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003a8df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403b34f0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840392390, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840327078)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840327078)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 831 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84030c100, 0xf840259360, 0xf840298b40, 0xf84030c0f8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 858 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403b7640, 0x200000002, 0xf8403b2c18)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403b2c18, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003dfd01, 0xf8403b7640, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003dfdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403ba270, 0x300000027, 0xf8403b7620, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403923f0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840327040)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840327040)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 828 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840394080, 0x200000002, 0xf8403919d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403919d8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003aad01, 0xf840394080, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003aadf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840392de0, 0x300000027, 0xf840394060, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840349450, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84030c670)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84030c670)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 827 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038dda0, 0x200000002, 0xf84038fa38)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84038fa38, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003abd01, 0xf84038dda0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003abdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf84038bdc0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403493f0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84030c880)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84030c880)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 825 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038dae0, 0x200000002, 0xf8403916d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403916d8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003acd01, 0xf84038dae0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003acdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf84038ba80, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403920c0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84030cc80)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84030cc80)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 824 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038d8a0, 0x200000002, 0xf8403911f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403911f8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003e0d01, 0xf84038d8a0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003e0df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840392030, 0x300000027, 0xf84038d880, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840392000, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840306450)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840306450)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 823 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038db60, 0x200000002, 0xf8403917f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403917f8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003add01, 0xf84038db60, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003addf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840392c30, 0x300000027, 0xf84038db40, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840389f90, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403063d0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403063d0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 721 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f37003aee58, 0x100000001, 0xf840292438)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840292438, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f37003aee58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f37003aee58, 0x100000001, 0x7f3703bc9670, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f37003aee90, 0xf84027ec30, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840079800, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf8402a1808, 0xf84029eec0, 0xf8402a1810, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 841 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf84031e590, 0xf84029e340, 0xf8402a7fd8, 0xf84031e588, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 822 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038d900, 0x200000002, 0xf8403913d8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403913d8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003b0d01, 0xf84038d900, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003b0df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf84038b720, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840389f30, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840306560)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840306560)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 821 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038d960, 0x200000002, 0xf840391438)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840391438, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003b1d01, 0xf84038d960, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003b1df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840392900, 0x300000027, 0xf84038d940, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840389ed0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840306d88)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840306d88)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 820 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038d640, 0x200000002, 0xf84038f4f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84038f4f8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003b2d01, 0xf84038d640, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003b2df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403897b0, 0x300000027, 0xf84038d620, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840389d80, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840306918)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840306918)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 819 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038d660, 0x200000002, 0xf84038f558)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84038f558, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003b3d01, 0xf84038d660, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003b3df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf84038b520, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840389d20, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840306ab0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840306ab0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 818 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038d5a0, 0x200000002, 0xf84038f378)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84038f378, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003b4d01, 0xf84038d5a0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003b4df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf84038b470, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402caae0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840306cb8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840306cb8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 817 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038d440, 0x200000002, 0xf84038f138)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84038f138, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003b5d01, 0xf84038d440, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003b5df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf84038b1e0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402caa20, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403000b0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403000b0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 816 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038d1c0, 0x200000002, 0xf84037ea38)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84037ea38, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003b6e01, 0xf84038d1c0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f37003b6e70, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf840300708, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf840306f10, 0xf840064c00, 0x240125578)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:53 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf840306f10, 0x0, 0x0, 0xf840306f10, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840306f10)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 815 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf84038da20, 0x200000002, 0xf840391558)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840391558, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003b7d01, 0xf84038da20, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003b7df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403929f0, 0x300000027, 0xf84038da00, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402ca960, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840306fd0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840306fd0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 809 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382b00, 0x200000002, 0xf840387558)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840387558, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003e1d01, 0xf840382b00, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003e1df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840380b30, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840384300, 0x22, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840300dc8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840300dc8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 810 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382be0, 0x200000002, 0xf840387738)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840387738, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003e2d01, 0xf840382be0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003e2df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840380c00, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840349510, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840300d30)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840300d30)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 811 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403776c0, 0x200000002, 0xf840292138)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840292138, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003e3d01, 0xf8403776c0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003e3df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840380e80, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840384360, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403009f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403009f8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 807 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382cc0, 0x200000002, 0xf840387af8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840387af8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003e4d01, 0xf840382cc0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003e4df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840380d50, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402ca7e0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402f6250)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402f6250)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 806 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382ca0, 0x200000002, 0xf840387a98)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840387a98, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003e5d01, 0xf840382ca0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003e5df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840380d30, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402ca720, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402f61c0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402f61c0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 722 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f37003e6e58, 0x100000001, 0xf840292498)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840292498, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f37003e6e58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f37003e6e58, 0x100000001, 0x7f3703bc9b40, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f37003e6e90, 0xf84028c2d0, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840079780, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf8402a7fd8, 0xf84029e340, 0xf8402a7dc8, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 793 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840377f60, 0x200000002, 0xf84037e198)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84037e198, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003e7d01, 0xf840377f60, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003e7df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840332ff0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402f5330, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402efb98)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402efb98)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 847 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf840327e38, 0xf8402ad4e0, 0xf8402a75c0, 0xf840327e30, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 kernel: [42425360.440803] init: prism-3 main process (24036) terminated with status 2
Jul 17 21:02:53 i-e331c191 kernel: [42425360.440851] init: prism-3 main process ended, respawning
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 805 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382c40, 0x200000002, 0xf8403878b8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403878b8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003e9d01, 0xf840382c40, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003e9df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840380c70, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402c5330, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402f6400)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402f6400)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 803 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403826c0, 0x200000002, 0xf84037edf8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84037edf8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003ead01, 0xf8403826c0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003eadf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403806e0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402c5120, 0x23, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402f6808)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402f6808)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 801 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382560, 0x200000002, 0xf84037ec18)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84037ec18, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003ebd01, 0xf840382560, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003ebdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840384810, 0x300000027, 0xf840382540, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840301bd0, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402f6d58)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402f6d58)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 799 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840377560, 0x200000002, 0xf8402582b8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402582b8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003ecd01, 0xf840377560, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003ecdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840332860, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf840384240, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402f6fd8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402f6fd8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 798 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382300, 0x200000002, 0xf84037e798)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84037e798, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a20d01, 0xf840382300, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a20df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403841b0, 0x300000027, 0xf8403822e0, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402c5db0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402ef8a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402ef8a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 797 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382260, 0x200000002, 0xf84037e678)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84037e678, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003edd01, 0xf840382260, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003eddf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840384060, 0x300000027, 0xf840382240, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402f5750, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402ef350)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402ef350)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 723 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f37003eee58, 0x100000001, 0xf840292618)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840292618, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f37003eee58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f37003eee58, 0x100000001, 0x7f3703bc9250, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f37003eee90, 0xf8402721e0, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:53 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840079100, 0xf8400642a0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:53 i-e331c191 prism-3: main._func_002(0xf8402a7910, 0xf8402adac0, 0xf8402a7918, 0x414cca, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:53 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 796 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382080, 0x200000002, 0xf84037e378)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84037e378, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003efd01, 0xf840382080, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003efdf8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840349e70, 0x300000027, 0xf840382060, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402f56f0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402ef6e0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402ef6e0)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 795 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840382140, 0x200000002, 0xf84037e498)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84037e498, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003f0d01, 0xf840382140, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003f0df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840380150, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8403820c0, 0x14, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402ef920)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402ef920)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 792 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840377ca0, 0x200000002, 0xf840376c18)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840376c18, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003f1d01, 0xf840377ca0, 0x200000002, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003f1df8, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403498a0, 0x300000027, 0xf840377c80, 0xf800000018, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:53 i-e331c191 prism-3: main.getServerInfo(0xf8402f5240, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:53 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402effe8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:53 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402effe8)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:53 i-e331c191 prism-3: created by main.main
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 850 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: main._func_003(0xf840327cc0, 0xf8402bec90, 0xf8402a7348, 0xf840327cb8, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:53 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:53 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:53 i-e331c191 prism-3:
Jul 17 21:02:53 i-e331c191 prism-3: goroutine 725 [chan receive]:
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f37003f3e58, 0x100000001, 0xf8403a0c78)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403a0c78, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f37003f3e58, 0x100000001, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f37003f3e58, 0x100000001, 0x7f3703bc9250, ...)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:53 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f37003f3e90, 0xf840272510, 0x40605f)
Jul 17 21:02:53 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:54 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840079200, 0xf8400642a0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:54 i-e331c191 prism-3: main._func_002(0xf8402a7348, 0xf8402bec90, 0xf8402a7350, 0x414cca, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:54 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 724 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f37003b8e58, 0x100000001, 0xf8403a0c18)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403a0c18, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f37003b8e58, 0x100000001, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f37003b8e58, 0x100000001, 0x7f3703bc9250, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f37003b8e90, 0xf840272300, 0x40605f)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:54 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840079180, 0xf8400642a0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:54 i-e331c191 prism-3: main._func_002(0xf8402a75c0, 0xf8402ad4e0, 0xf8402a75c8, 0x414cca, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:54 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 852 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403a8e20, 0x200000002, 0xf8403b2378)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403b2378, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003b9d01, 0xf8403a8e20, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003b9df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403b3290, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8403921e0, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840327950)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840327950)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 855 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403a8e60, 0x200000002, 0xf8403b2498)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403b2498, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003c3d01, 0xf8403a8e60, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003c3df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403b3300, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8403938a0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf840327768)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf840327768)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 791 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840377ce0, 0x200000002, 0xf840376d38)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840376d38, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003f4d01, 0xf840377ce0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003f4df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840332e40, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8402f5180, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402df078)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402df078)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 772 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403371e0, 0x0, 0x0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sub).write(0xf840369360, 0xf8403668f0, 0xaa00000044, 0xaa00000044, 0x7f370037ae78, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:218 +0x46
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf84009d880, 0xf840369360, 0x20037ae00, 0xf840369380, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.appendSendStr(0xf84009d880, 0xf840369360, 0x5308fc, 0x5342555300000009, 0x7f370037ae78, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:337 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sub).Subscribe(0xf840369360, 0x7f370037ae78, 0x100000001, 0x7f370037ae10, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:858 +0x75
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Subscribe(0xf84005e2d0, 0x7f370037ae78, 0x100000001, 0xf8402eed80, 0x7f370000002a, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:814 +0xa5
Jul 17 21:02:54 i-e331c191 prism-3: main.(*RedisClient).ConnectionReqReply(0xf840270880, 0xf840308b50, 0x9, 0xf840270880, 0x100000000, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:93 +0xa7
Jul 17 21:02:54 i-e331c191 prism-3: main._func_002(0xf8402d58c8, 0xf840308be0, 0xf8402d58d0, 0x414cca, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:147 +0x98
Jul 17 21:02:54 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 642 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: main._func_003(0xf840228638, 0xf840286730, 0xf8402884b8, 0xf840228630, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:54 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 766 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840369880, 0x200000002, 0xf8403375b8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403375b8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20037cd01, 0xf840369880, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370037cdf8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840308390, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf840369800, 0x14, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402cd3d8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402cd3d8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 765 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840335c20, 0x200000002, 0xf840337bb8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840337bb8, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20037de01, 0xf840335c20, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f370037de70, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8402cdd60, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:54 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8402cd330, 0xf840064c00, 0x240228300)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:54 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8402cd330, 0x0, 0x0, 0xf8402cd330, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402cd330)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 897 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: main._func_003(0xf8403cc440, 0xf8402ccfd0, 0xf8402b1808, 0xf8403cc438, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:54 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 764 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840335b80, 0x200000002, 0xf8402b3df8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402b3df8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20037fd01, 0xf840335b80, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370037fdf8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402e0ab0, 0x300000027, 0xf840335b60, 0xf800000018, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8402d3f00, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402cd570)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402cd570)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 900 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: main._func_003(0xf8403cc6c8, 0xf8402cc750, 0xf8402b15e0, 0xf8403cc6c0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:54 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 762 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403352a0, 0x200000002, 0xf8402b3558)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402b3558, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200381d01, 0xf8403352a0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700381df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402e04b0, 0x300000027, 0xf840335280, 0xf800000018, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8402d3de0, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402cda58)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402cda58)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 761 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403350e0, 0x200000002, 0xf8402b32b8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402b32b8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003f5d01, 0xf8403350e0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003f5df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402d3bd0, 0x300000027, 0xf8403350c0, 0xf800000018, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8402d3d80, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402cdcb8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402cdcb8)
Jul 17 21:02:54 i-e331c191 prism-3: 2013-07-17T21:02:54Z [info] listening gomaxprocs=1 port=25565 prism=prism-3
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 760 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402ff360, 0x200000002, 0xf8402baf18)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402baf18, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200382e01, 0xf8402ff360, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f3700382e70, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8402cdeb8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:54 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8402cdbf8, 0xf840064c00, 0x24022e4b0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:54 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8402cdbf8, 0x0, 0x0, 0xf8402cdbf8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402cdbf8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 655 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf8400d2cf0, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:54 i-e331c191 prism-3: net.(*netFD).Read(0xf8400d2cf0, 0xf84022e150, 0x800000001, 0x7f37ffffffff, 0xf8400469f0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:54 i-e331c191 prism-3: net.(*TCPConn).Read(0xf84022e1b0, 0xf84022e150, 0x800000001, 0xf84022e150, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:54 i-e331c191 prism-3: io.ReadAtLeast(0xf840047bd0, 0xf84022e1b0, 0xf84022e150, 0x800000001, 0x1, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:266 +0xc3
Jul 17 21:02:54 i-e331c191 prism-3: io.ReadFull(0xf840047bd0, 0xf84022e1b0, 0xf84022e150, 0x800000001, 0x1, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:285 +0x69
Jul 17 21:02:54 i-e331c191 prism-3: encoding/binary.Read(0xf840047bd0, 0xf84022e1b0, 0xf840064c00, 0x50041b935, 0x4b3a40, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/encoding/binary/binary.go:133 +0xd2
Jul 17 21:02:54 i-e331c191 prism-3: main.(*McReader).Byte(0xf840141e80, 0xf840140601, 0x0, 0x0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:89 +0xb2
Jul 17 21:02:54 i-e331c191 prism-3: main.(*McReader).PingPacket(0xf840141e80, 0xf840140640, 0x0, 0x0, 0xf84022e1b0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:30 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf84022e1b0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:19 +0xc5
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf84022e1b0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 759 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402ff1e0, 0x200000002, 0xf8402ba918)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402ba918, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200384d01, 0xf8402ff1e0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700384df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8400de9c0, 0x300000027, 0xf8402ff140, 0xf800000018, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8400de990, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c70e8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c70e8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 758 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403354a0, 0x200000002, 0xf84014a618)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf84014a618, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003f6d01, 0xf8403354a0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003f6df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402ca5a0, 0x300000027, 0xf840335420, 0xf800000018, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8400de060, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c7030)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c7030)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 726 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f37003f7e58, 0x100000001, 0xf8403c7f78)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403c7f78, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f37003f7e58, 0x100000001, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f37003f7e58, 0x100000001, 0x7f3703bc8c20, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f37003f7e90, 0xf840260960, 0x40605f)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:54 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840270a80, 0xf8403517d0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:54 i-e331c191 prism-3: main._func_002(0xf8402b1c80, 0xf8402be440, 0xf8402b1a40, 0x414cca, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:54 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 756 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf8401cc630, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:54 i-e331c191 prism-3: net.(*netFD).Read(0xf8401cc630, 0xf8402c72c0, 0x800000002, 0x7f37ffffffff, 0xf8400469f0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:54 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8402c74d0, 0xf8402c72c0, 0x800000002, 0xf8402c72c0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:54 i-e331c191 prism-3: io.ReadAtLeast(0xf840047bd0, 0xf8402c74d0, 0xf8402c72c0, 0x800000002, 0x2, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:266 +0xc3
Jul 17 21:02:54 i-e331c191 prism-3: io.ReadFull(0xf840047bd0, 0xf8402c74d0, 0xf8402c72c0, 0x800000002, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:285 +0x69
Jul 17 21:02:54 i-e331c191 prism-3: encoding/binary.Read(0xf840047bd0, 0xf8402c74d0, 0xf840064c00, 0x1, 0x4b1eb0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/encoding/binary/binary.go:133 +0xd2
Jul 17 21:02:54 i-e331c191 prism-3: main.(*McReader).String(0xf840321560, 0x0, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:111 +0xf8
Jul 17 21:02:54 i-e331c191 prism-3: main.(*McReader).PingPacket(0xf840321560, 0xf8402c9640, 0x0, 0x0, 0xf8402c74d0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:34 +0xd4
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c74d0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:19 +0xc5
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c74d0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 757 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402ffba0, 0x200000002, 0xf8402ba1f8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402ba1f8, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x2003f9d01, 0xf8402ffba0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f37003f9df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403211c0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8401d47b0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c7360)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c7360)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 754 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402ffbe0, 0x200000002, 0xf8402ba438)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402ba438, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20035ad01, 0xf8402ffbe0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370035adf8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf840321150, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8401d4690, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c7800)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c7800)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 753 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402e1d80, 0x200000002, 0xf8402a33d8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402a33d8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20035bd01, 0xf8402e1d80, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370035bdf8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402a87e0, 0x300000027, 0xf8402e1cc0, 0xf800000018, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8401d4630, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c7a40)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c7a40)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 752 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840309ba0, 0x200000002, 0xf8402a6f18)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402a6f18, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20035cd01, 0xf840309ba0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370035cdf8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402c5c00, 0x300000027, 0xf840309b80, 0xf800000018, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8401d4420, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c7dc0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c7dc0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 751 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840309aa0, 0x200000002, 0xf8402a6c18)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402a6c18, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20035dd01, 0xf840309aa0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370035ddf8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402c58a0, 0x300000027, 0xf840309a80, 0xf800000018, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8402a84e0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c7df0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c7df0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 750 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840309960, 0x200000002, 0xf8402a66d8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402a66d8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20035ed01, 0xf840309960, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370035edf8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402c5630, 0x300000027, 0xf840309940, 0xf800000018, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8402a8480, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c1160)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c1160)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 727 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f370035fe58, 0x100000001, 0xf8403a0eb8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403a0eb8, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f370035fe58, 0x100000001, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f370035fe58, 0x100000001, 0x7f3703bc9f08, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f370035fe90, 0xf840297600, 0x40605f)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:54 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840270a00, 0xf8400642a0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:54 i-e331c191 prism-3: main._func_002(0xf8402b1808, 0xf8402ccfd0, 0xf8402b1810, 0x414cca, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:54 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 903 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: main._func_003(0xf8403cca50, 0xf8402cc000, 0xf8402b1028, 0xf8403cca48, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:54 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 685 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf8400947e0, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:54 i-e331c191 prism-3: net.(*netFD).Read(0xf8400947e0, 0xf84025b758, 0x800000002, 0x7f37ffffffff, 0xf8400469f0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:54 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8402530d8, 0xf84025b758, 0x800000002, 0xf84025b758, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:54 i-e331c191 prism-3: io.ReadAtLeast(0xf840047bd0, 0xf8402530d8, 0xf84025b758, 0x800000002, 0x2, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:266 +0xc3
Jul 17 21:02:54 i-e331c191 prism-3: io.ReadFull(0xf840047bd0, 0xf8402530d8, 0xf84025b758, 0x800000002, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:285 +0x69
Jul 17 21:02:54 i-e331c191 prism-3: encoding/binary.Read(0xf840047bd0, 0xf8402530d8, 0xf840064c00, 0x1, 0x4b1eb0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/encoding/binary/binary.go:133 +0xd2
Jul 17 21:02:54 i-e331c191 prism-3: main.(*McReader).String(0xf840247ef0, 0x0, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:111 +0xf8
Jul 17 21:02:54 i-e331c191 prism-3: main.(*McReader).PingPacket(0xf840247ef0, 0xf840229380, 0x0, 0x0, 0xf8402530d8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:34 +0xd4
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402530d8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:19 +0xc5
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402530d8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 741 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402f2a60, 0x200000002, 0xf840264438)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840264438, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200362d01, 0xf8402f2a60, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700362df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402f9d90, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8402b4db0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c1ef0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c1ef0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 728 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f3700363e58, 0x100000001, 0xf8403a0f18)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403a0f18, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f3700363e58, 0x100000001, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f3700363e58, 0x100000001, 0x7f3703bc8c20, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f3700363e90, 0xf840260b70, 0x40605f)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:54 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840270980, 0xf8400642a0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:54 i-e331c191 prism-3: main._func_002(0xf8402b15e0, 0xf8402cc750, 0xf8402b15e8, 0x414cca, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:54 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 904 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403cbfe0, 0x200000002, 0xf8403cda98)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403cda98, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200364d01, 0xf8403cbfe0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700364df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8403d14c0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8403ca5a0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8403ccaf8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8403ccaf8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 749 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840309780, 0x200000002, 0xf8402a6138)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402a6138, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200365e01, 0xf840309780, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f3700365e70, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8402b8ba8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:54 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8402c1300, 0xf840064c00, 0x24023e568)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:54 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8402c1300, 0x0, 0x0, 0xf8402c1300, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c1300)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 748 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403098a0, 0x200000002, 0xf8402a6378)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402a6378, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200366d01, 0xf8403098a0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700366df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402f97e0, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf840309820, 0x14, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c1400)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c1400)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 746 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403092e0, 0x200000002, 0xf840264a98)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840264a98, 0x4000000025, 0x4000000025, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200367d01, 0xf8403092e0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700367df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402f9a30, 0xf, 0x0, 0xf800000000, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8402b40f0, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c1858)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c1858)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 747 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf840309580, 0x200000002, 0xf840264198)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840264198, 0x400000002d, 0x400000002d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200368e01, 0xf840309580, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x52b98c, 0x54454700000003, 0x7f3700368e70, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Get(0xf84005e2d0, 0xf840045560, 0x19, 0x4b3a40, 0xf8402b8b80, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:181 +0xa0
Jul 17 21:02:54 i-e331c191 prism-3: main.(*RedisClient).GetMaintenenceMsg(0xf840079000, 0xf8402c1350, 0xf840064c00, 0x24023e1d8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:68 +0x35
Jul 17 21:02:54 i-e331c191 prism-3: main.maintenanceMode(0xf8400642a0, 0xf8402c1350, 0x0, 0x0, 0xf8402c1350, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:62 +0x2d
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c1350)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:55 +0x1a6
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 745 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403094e0, 0x200000002, 0xf840264078)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840264078, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a21d01, 0xf8403094e0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a21df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402bdc00, 0x300000027, 0xf8403094c0, 0xf800000018, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8402b4090, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c17a0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c17a0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 744 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8403093e0, 0x200000002, 0xf840264bb8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840264bb8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200369d01, 0xf8403093e0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3700369df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402bd960, 0x300000027, 0xf8403093c0, 0xf800000018, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8402b4fc0, 0x25, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c18a8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c18a8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 729 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0x7f370036ae58, 0x100000001, 0xf8403e19d8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8403e19d8, 0x400000000e, 0x400000000e, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x200000001, 0x7f370036ae58, 0x100000001, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.Send(0xf8400446c0, 0xf840044680, 0x7f370036ae58, 0x100000001, 0x7f3703bca220, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:302 +0x5c
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Quit(0xf84005e2d0, 0x7f370036ae90, 0xf8402a0360, 0x40605f)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:719 +0xa6
Jul 17 21:02:54 i-e331c191 prism-3: main.(*RedisClient).Quit(0xf840270900, 0xf8400642a0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/redis.go:52 +0x28
Jul 17 21:02:54 i-e331c191 prism-3: main._func_002(0xf8402b1028, 0xf8402cc000, 0xf8402b1030, 0x414cca, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:152 +0x1ac
Jul 17 21:02:54 i-e331c191 prism-3: created by main.(*ConnectionRequest).Process
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:204 +0x15b
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 743 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402f22e0, 0x200000002, 0xf8402647f8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf8402647f8, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x203a22d01, 0xf8402f22e0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f3703a22df8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402bd390, 0x300000027, 0xf8402f22c0, 0xf800000018, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8402b4f60, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c1c18)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c1c18)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 742 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).getConn(0xf840044680, 0xf8402f21c0, 0x200000002, 0xf840264618)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:132 +0x3f
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Sync).write(0xf840044680, 0xf840264618, 0x400000003d, 0x400000003d, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:113 +0x3a
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.sendGen(0xf8400446c0, 0xf840044680, 0x20036cd01, 0xf8402f21c0, 0x200000002, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:278 +0x70
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.SendStr(0xf8400446c0, 0xf840044680, 0x530704, 0x5241435300000005, 0x7f370036cdf8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/godis.go:343 +0x94
Jul 17 21:02:54 i-e331c191 prism-3: github.com/simonz05/godis/redis.(*Client).Scard(0xf84005e2d0, 0xf8402bdf90, 0x300000027, 0xf8402f2180, 0xf800000018, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/github.com/simonz05/godis/redis/commands.go:449 +0x92
Jul 17 21:02:54 i-e331c191 prism-3: main.getServerInfo(0xf8402b4e10, 0x24, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:61 +0x1d8
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402c1ea0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:31 +0x241
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402c1ea0)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 683 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: net.(*pollServer).WaitRead(0xf840044640, 0xf840094240, 0xf840047090, 0xb, 0x1, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:268 +0x73
Jul 17 21:02:54 i-e331c191 prism-3: net.(*netFD).Read(0xf840094240, 0xf840253228, 0x800000002, 0x7f37ffffffff, 0xf8400469f0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/fd.go:428 +0x1ec
Jul 17 21:02:54 i-e331c191 prism-3: net.(*TCPConn).Read(0xf8402533a8, 0xf840253228, 0x800000002, 0xf840253228, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/net/tcpsock_posix.go:87 +0xce
Jul 17 21:02:54 i-e331c191 prism-3: io.ReadAtLeast(0xf840047bd0, 0xf8402533a8, 0xf840253228, 0x800000002, 0x2, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:266 +0xc3
Jul 17 21:02:54 i-e331c191 prism-3: io.ReadFull(0xf840047bd0, 0xf8402533a8, 0xf840253228, 0x800000002, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/io/io.go:285 +0x69
Jul 17 21:02:54 i-e331c191 prism-3: encoding/binary.Read(0xf840047bd0, 0xf8402533a8, 0xf840064c00, 0x1, 0x4b1eb0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/usr/lib/go/src/pkg/encoding/binary/binary.go:133 +0xd2
Jul 17 21:02:54 i-e331c191 prism-3: main.(*McReader).String(0xf8402347d0, 0x0, 0x0, 0x0, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:111 +0xf8
Jul 17 21:02:54 i-e331c191 prism-3: main.(*McReader).PingPacket(0xf8402347d0, 0xf84011d000, 0x0, 0x0, 0xf8402533a8, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/mc_reader.go:34 +0xd4
Jul 17 21:02:54 i-e331c191 prism-3: main.handleServerPing(0xf8400642a0, 0xf8402533a8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/server_ping.go:19 +0xc5
Jul 17 21:02:54 i-e331c191 prism-3: main.handleConnection(0xf8400642a0, 0xf8402533a8)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:53 +0x180
Jul 17 21:02:54 i-e331c191 prism-3: created by main.main
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:323 +0x699
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 688 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: main._func_003(0xf84025bd30, 0xf840286970, 0xf8402888a8, 0xf84025bd28, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:54 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab
Jul 17 21:02:54 i-e331c191 prism-3:
Jul 17 21:02:54 i-e331c191 prism-3: goroutine 704 [chan receive]:
Jul 17 21:02:54 i-e331c191 prism-3: main._func_003(0xf840268e30, 0xf8402937f0, 0xf84028fcf8, 0xf840268e28, 0x0, ...)
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:165 +0x3e
Jul 17 21:02:54 i-e331c191 prism-3: created by main._func_002
Jul 17 21:02:54 i-e331c191 prism-3: #011/opt/prism-1/releases/20130714211750/main.go:175 +0x2ab