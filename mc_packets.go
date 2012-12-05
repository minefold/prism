package main

// 0x00
type KeepAlivePacket struct {
	Id int
}

// 0x02
type HandshakePacket struct {
	ProtocolVersion byte
	Username        string
	Host            string
	Port            int
}

// 0x02 old 1.2.5 login packet, for tekkit. Jeez.
type OldHandshakePacket struct {
	Username string
}

// 0xFF
type KickPacket struct {
	Reason string
}
