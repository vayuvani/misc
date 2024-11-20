meta:
  id: satellite_data
  endian: le

seq:
  - id: header
    type: header
  - id: payload
    type: payload
    size-eos: true

types:
  header:
    seq:
      - id: net_id
        type: u1
      - id: source_id
        type: u1
      - id: destination_id
        type: u1
      - id: msg_type_id
        type: u1
      - id: length
        type: u1
      - id: crc
        type: u1

  payload:
    seq:
      - id: timestamp
        type: u4
      - id: records
        type: u2
      - id: reset
        type: u1
      - id: hw_err
        type: u1
      - id: sat_rx_time
        type: u1
        repeat: expr
        repeat-expr: 3
      - id: sat_rssi
        type: s1
      - id: sat_snr
        type: u2
      - id: sat_uptime
        type: u4
      - id: sat_utc
        type: u4
      - id: res1
        type: u1
      - id: res2
        type: u1
      - id: psu_temp
        type: u1
      - id: v_bus
        type: u1
      - id: i_bus
        type: u2
      - id: bat_charge
        type: u1
      - id: temp_bat_min
        type: u1
      - id: temp_bat_max
        type: u1
      - id: psu_flags
        type: u2
      - id: res3
        type: u1
      - id: psu_flag2
        type: u1
      - id: psu_e_flag
        type: u1
      - id: i_psu_ch1
        type: u1
      - id: i_psu_ch2
        type: u1
      - id: i_psu_ch3
        type: u1
      - id: i_psu_ch4
        type: u1
      - id: i_psu_ch5
        type: u1
      - id: i_psu_ch6
        type: u1
      - id: i_psu_ch7
        type: u1
      - id: bat1_flag
        type: u1
      - id: bat1_v
        type: u1
      - id: bat1_i
        type: s2
      - id: bat1_cap
        type: u2
      - id: bat2_flag
        type: u1
      - id: bat2_v
        type: u1
      - id: bat2_i
        type: s2
      - id: bat2_cap
        type: u2
      - id: solar_cell1_v
        type: u1
      - id: solar_cell1_i
        type: u1
      - id: solar_cell2_v
        type: u1
      - id: solar_cell2_i
        type: u1
      - id: solar_cell3_v
        type: u1
      - id: solar_cell3_i
        type: u1
      - id: charger_flag
        type: u1