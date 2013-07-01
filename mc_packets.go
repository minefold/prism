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

// 0xFE
type PingPacket struct {
	MagicNumber     byte
	NewHeader       byte
	UserAgent       string
	PayloadSize     int16
	ProtocolVersion byte
	Host            string
	Port            int
}

// 0xFF
type KickPacket struct {
	Reason string
}
