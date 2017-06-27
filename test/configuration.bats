#!/usr/bin/env bats

load fail_if_not_on_kovan

@test "update and get the debt ceiling [sai cork, sai hat]" {
  sai cork 120000.0
  [ "$(sai hat)" == "120000.000000000000000000" ]
}

@test "update and get the liquidation ratio and the liquidation penalty [sai chop, sai cuff, sai mat, sai axe]" {
  sai chop 1.0
  sai cuff 1.0
  [ "$(sai mat)" == "1.000000000000000000000000000" ]
  [ "$(sai axe)" == "1.000000000000000000000000000" ]

  sai cuff 1.5
  sai chop 1.2
  [ "$(sai mat)" == "1.500000000000000000000000000" ]
  [ "$(sai axe)" == "1.200000000000000000000000000" ]
}

@test "update and get the stability fee [sai crop, sai tax]" {
  sai crop 1.0
  [ "$(sai tax)" == "1.000000000000000000000000000" ]

  sai crop 1.000000000000015
  [ "$(sai tax)" == "1.000000000000015000000000000" ]
}

@test "update and get the holder fee [sai coax, sai way]" {
  sai coax 1.0
  [ "$(sai way)" == "1.000000000000000000000000000" ]

  sai coax 1.00000000000028
  [ "$(sai way)" == "1.000000000000280000000000000" ]
}