package main

import (
	"encoding/binary"
	// "fmt"
	"github.com/djimenez/iconv-go"
	"io"
)

type McWriter struct {
	w io.Writer
}

func NewMcWriter(w io.Writer) *McWriter {
	return &McWriter{
		w: w,
	}
}

// 0x00
func (w *McWriter) KeepAlivePacket(packet KeepAlivePacket) (err error) {
	err = w.Byte(0x00)
	if err != nil {
		return
	}

	return w.Int(packet.Id)
}

// 0x02
func (w *McWriter) HandshakePacket(packet HandshakePacket) (err error) {
	err = w.Byte(0x02)
	if err != nil {
		return
	}

	err = w.Byte(packet.ProtocolVersion)
	if err != nil {
		return
	}

	err = w.String(packet.Username)
	if err != nil {
		return
	}

	err = w.String(packet.Host)
	if err != nil {
		return
	}

	err = w.Int(packet.Port)
	if err != nil {
		return
	}
	return
}

// 0x02
func (w *McWriter) OldHandshakePacket(packet OldHandshakePacket) (err error) {
	err = w.Byte(0x02)
	if err != nil {
		return
	}

	err = w.String(packet.Username)
	if err != nil {
		return
	}
	return
}

// 0xFF
func (w *McWriter) KickPacket(packet KickPacket) (err error) {
	err = w.Byte(0xFF)
	if err != nil {
		return
	}

	err = w.String(packet.Reason)
	if err != nil {
		return
	}
	return
}

func (w *McWriter) Byte(val byte) (err error) {
	return binary.Write(w.w, binary.BigEndian, val)
}

func (w *McWriter) Int(val int) (err error) {
	return binary.Write(w.w, binary.BigEndian, int32(val))
}

func (w *McWriter) String(val string) (err error) {
	err = binary.Write(w.w, binary.BigEndian, int16(len(val)))
	if err != nil {
		return
	}

	ucs2 := make([]byte, len(val)*2)
	_, _, err = iconv.Convert([]byte(val), ucs2, "utf-8", "ucs-2be")
	if err != nil {
		return
	}

	err = binary.Write(w.w, binary.BigEndian, ucs2)
	if err != nil {
		return
	}
	return
}
