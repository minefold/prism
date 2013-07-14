package main

import (
  "testing"
)

func TestGetServerInfo(t *testing.T) {
  resp, err := getMinefoldServerInfo("mc.harpercraft.com")

  if err != nil {
    t.Fatal(err)
  }

  if resp.PartyCloudId != "50e0fa59197a420510000001" {
    t.Fatalf("expected 50e0fa59197a420510000001 was '%s'", resp.PartyCloudId)
  }
}
