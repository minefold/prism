package main

import (
	"encoding/binary"
	"github.com/djimenez/iconv-go"
	"io"
)

type McReader struct {
	r io.Reader
}

func NewMcReader(r io.Reader) *McReader {
	return &McReader{
		r: r,
	}
}

func (r *McReader) Header() (header byte, err error) {
	err = binary.Read(r.r, binary.BigEndian, &header)
	return
}

func (r *McReader) PingPacket() (packet *PingPacket, err error) {
	packet = new(PingPacket)
	packet.MagicNumber, err = r.Byte()
	if err != nil {
		return
	}
	packet.NewHeader, err = r.Byte()
	if err != nil {
		return
	}
	packet.UserAgent, err = r.String()
	if err != nil {
		return
	}
	packet.PayloadSize, err = r.Short()
	if err != nil {
		return
	}
	packet.ProtocolVersion, err = r.Byte()
	if err != nil {
		return
	}
	packet.Host, err = r.String()
	if err != nil {
		return
	}
	packet.Port, err = r.Int()
	if err != nil {
		return
	}
	return
}

func (r *McReader) HandshakePacket() (packet *HandshakePacket, err error) {
	packet = new(HandshakePacket)
	err = binary.Read(r.r, binary.BigEndian, &packet.ProtocolVersion)
	if err != nil {
		return
	}
	packet.Username, err = r.String()
	if err != nil {
		return
	}
	packet.Host, err = r.String()
	if err != nil {
		return
	}
	packet.Port, err = r.Int()
	if err != nil {
		return
	}
	return
}

func (r *McReader) KeepAlive() (packet *KeepAlivePacket, err error) {
	packet = new(KeepAlivePacket)
	packet.Id, err = r.Int()
	if err != nil {
		return
	}
	return
}

func (r *McReader) Byte() (byte, error) {
	var val byte
	err := binary.Read(r.r, binary.BigEndian, &val)
	return val, err
}

func (r *McReader) Int() (int, error) {
	var val int32
	err := binary.Read(r.r, binary.BigEndian, &val)
	if err != nil {
		return 0, err
	}

	return int(val), nil
}

func (r *McReader) Short() (int16, error) {
	var val int16
	err := binary.Read(r.r, binary.BigEndian, &val)
	return val, err
}

func (r *McReader) String() (val string, err error) {
	var charLen int16
	err = binary.Read(r.r, binary.BigEndian, &charLen)
	if err != nil {
		return
	}

	ucs2 := make([]byte, charLen*2)
	_, err = io.ReadFull(r.r, ucs2)
	if err != nil {
		return
	}

	utf8 := make([]byte, charLen)
	_, _, err = iconv.Convert(ucs2, utf8, "ucs-2be", "utf-8")
	if err != nil {
		return
	}
	val = string(utf8)

	return
}
