meta:
  id: cstp_1_1
  title: CSTP-1.1 Satellite Telemetry Packet by @tckb
  endian: le

seq:
  - id: header
    type: header
  - id: payload
    type: payload
    size: header.length

types:
  header:
    seq:
      - id: net_id
        type: u1
        doc: Network identifier
      - id: source_id
        type: u1
        doc: Source device identifier
      - id: destination_id
        type: u1
        doc: Destination device identifier
      - id: msg_type_id
        type: u1
        doc: Message type identifier
      - id: length
        type: u1
        doc: Length of the payload in bytes
      - id: crc
        type: u1
        doc: Cyclic Redundancy Check for error detection

  payload:
    seq:
      - id: system_info
        type: system_info
      - id: satellite_comm
        type: satellite_comm
      - id: power_system_unit
        type: power_system_unit
      - id: batteries
        type: batteries
      - id: solar_cells
        type: solar_cells
      - id: charger
        type: charger

  system_info:
    seq:
      - id: uptime
        type: u4
        doc: Time since last reset (seconds)
      - id: records
        type: u2
        doc: Number of records stored
      - id: reset
        type: u1
        doc: Number of system resets
      - id: hardware_error
        type: u1
        doc: Hardware error code (0 = no error)

  satellite_comm:
    seq:
      - id: sat_rx_time
        type: u1
        repeat: expr
        repeat-expr: 3
        doc: Last received time from satellite (3-byte array)
      - id: sat_rssi
        type: s2
        doc: Received Signal Strength Indicator (dBm)
      - id: sat_snr
        type: s1
        doc: Signal-to-Noise Ratio (dB)
      - id: sat_uptime
        type: u4
        doc: Satellite uptime (seconds)
      - id: sat_utc
        type: u4
        doc: Current UTC time from satellite (UNIX timestamp)
      - id: reserved
        type: u1
        repeat: expr
        repeat-expr: 2
        doc: Reserved for future use (2 bytes)

  power_system_unit:
    seq:
      - id: psu_temp_raw
        type: u1
        doc: PSU temperature (raw)
      - id: vbus_raw
        type: u1
        doc: Raw bus voltage
      - id: ibus_raw
        type: u2
        doc: Raw bus current
      - id: bat_charge
        type: u1
        doc: Battery charge percentage
      - id: temp_bat_min_raw
        type: u1
        doc: Minimum battery temperature (raw)
      - id: temp_bat_max_raw
        type: u1
        doc: Maximum battery temperature (raw)
      - id: psu_flags
        type: u2
        doc: PSU status flags (bit field)
      - id: reserved
        type: u1
        doc: Reserved for future use (1 byte)
      - id: psu_flag2
        type: u1
        doc: Additional PSU status flags (bit field)
      - id: psu_flag
        type: u1
        doc: Main PSU status flag (bit field)
      - id: ipsu_channels_raw
        type: u1
        repeat: expr
        repeat-expr: 7
        doc: Raw current for each IPSU channel (7 bytes)
    instances:
      psu_temp_c:
        value: psu_temp_raw
        doc: PSU temperature (in °C)
      vbus_mv:
        value: vbus_raw * 100
        doc: Bus voltage (in mV)
      ibus_ma:
        value: ibus_raw * 0.5
        doc: Bus current (in mA)
      psu_power_mw:
        value: '(vbus_mv * ibus_ma) / 1000'
        doc: PSU power (in mW)
      temp_bat_min_c:
        value: temp_bat_min_raw
        doc: Minimum battery temperature (°C)
      temp_bat_max_c:
        value: temp_bat_max_raw
        doc: Maximum battery temperature (°C)

  batteries:
    seq:
      - id: battery1
        type: battery
      - id: battery2
        type: battery

  battery:
    seq:
      - id: flag
        type: u1
        doc: Battery status flag (bit field)
      - id: voltage_raw
        type: u1
        doc: Raw battery voltage
      - id: current_raw
        type: u2
        doc: Raw battery current
      - id: capacity_raw
        type: u2
        doc: Raw battery capacity
    instances:
      voltage_mv:
        value: voltage_raw * 100
        doc: Battery voltage (in mV)
      current_ma:
        value: current_raw * 0.5
        doc: Battery current (in mA)
      capacity_mah:
        value: capacity_raw
        doc: Battery capacity (in mAh)
      power_mw:
        value: '(voltage_mv * current_ma) / 1000'
        doc: Battery power (in mW)

  solar_cells:
    seq:
      - id: cells
        type: solar_cell
        repeat: expr
        repeat-expr: 3
        doc: Array of 3 solar cells

  solar_cell:
    seq:
      - id: voltage_raw
        type: u1
        doc: Raw solar cell voltage
      - id: current_raw
        type: u1
        doc: Raw solar cell current
    instances:
      voltage_mv:
        value: voltage_raw * 100
        doc: Solar cell voltage (in mV)
      current_ma:
        value: current_raw
        doc: Solar cell current (in mA)
      power_mw:
        value: '(voltage_mv * current_ma) / 1000'
        doc: Solar cell power (in mW)

  charger:
    seq:
      - id: flag
        type: u1
        doc: Charger status flag (bit field)
