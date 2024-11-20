meta:
  id: sr0
  title: SR0 DemoSAT decoder
  endian: le

doc: |
  :field dest_callsign: ax25_frame.ax25_header.dest_callsign_raw.callsign_ror.callsign
  :field src_callsign: ax25_frame.ax25_header.src_callsign_raw.callsign_ror.callsign
  :field src_ssid: ax25_frame.ax25_header.src_ssid_raw.ssid
  :field dest_ssid: ax25_frame.ax25_header.dest_ssid_raw.ssid
  :field ctl: ax25_frame.ax25_header.ctl
  :field pid: ax25_frame.ax25_header.pid
  :field callsign: message_header.call_sign
  :field frame_number: message_header.frame_number
  :field message_type: message_header.message_type
  :field transmission_power: message_header.transmission_power

seq:
  - id: lora_or_fsk
    type: u4be
  - id: packet_data
    type:
      switch-on: lora_or_fsk
      cases:
        0x53523053: lora_packet  # "SR0S" in ASCII
        0xA6A0A496: ax25_frame   # Start of AX.25 frame

types:
  lora_packet:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        type:
          switch-on: message_header.message_type
          cases:
            0: satellite_info
            1: store_and_forward_message
            2: uplink_response
            7: imu_data
            10: hms_power_data
            12: hms_temperature_data
            13: radiation_data
            14: system_config

  ax25_frame:
    seq:
      - id: ax25_header
        type: ax25_header
      - id: ax25_payload
        type: ax25_payload

  ax25_header:
    seq:
      - id: dest_callsign_raw
        type: callsign_raw
      - id: dest_ssid_raw
        type: ssid_mask
      - id: src_callsign_raw
        type: callsign_raw
      - id: src_ssid_raw
        type: ssid_mask
      - id: ctl
        type: u1
      - id: pid
        type: u1

  callsign_raw:
    seq:
      - id: callsign_ror
        process: ror(1)
        size: 6
        type: callsign

  callsign:
    seq:
      - id: callsign
        type: str
        encoding: ASCII
        size: 6

  ssid_mask:
    seq:
      - id: ssid_mask
        type: u1
    instances:
      ssid:
        value: (ssid_mask & 0x0f) >> 1

  ax25_payload:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        type:
          switch-on: message_header.message_type
          cases:
            0: satellite_info
            1: store_and_forward_message
            2: uplink_response
            7: imu_data
            10: hms_power_data
            12: hms_temperature_data
            13: radiation_data
            14: system_config

  message_header:
    seq:
      - id: call_sign
        type: str
        size: 6
        encoding: ASCII
      - id: frame_number
        type: u2
      - id: message_type
        type: u1
      - id: transmission_power
        type: u1
    instances:
      transmission_power_description:
        value: >
          transmission_power == 0 ? "100mW Radio" :
          transmission_power == 1 ? "1W Radio" : "Unknown"

  satellite_info:
    seq:
      - id: satellite_unix_time
        type: u4
      - id: obc_temperature
        type: s2
      - id: battery_temperature
        type: s2
      - id: external_temperature
        type: s2
      - id: base_plate_temperature
        type: s2
      - id: solar_panel_temperature
        type: s2
      - id: radiation
        type: s2
      - id: bus_voltage
        type: u2
      - id: bus_current
        type: s2
      - id: battery_maximum_capacity
        type: u2
      - id: battery_remaining_capacity
        type: u2
      - id: solar_bus_voltage
        type: u2
      - id: solar_bus_current
        type: u2
      - id: boot_counter
        type: u2
      - id: checksum
        type: u1
    instances:
      obc_temperature_celsius:
        value: obc_temperature / 10.0
      battery_temperature_celsius:
        value: battery_temperature / 10.0
      external_temperature_celsius:
        value: external_temperature / 10.0
      base_plate_temperature_celsius:
        value: base_plate_temperature / 10.0
      solar_panel_temperature_celsius:
        value: solar_panel_temperature / 10.0
      radiation_microsv_per_h:
        value: radiation / 100.0
      bus_voltage_v:
        value: bus_voltage / 1000.0
      bus_current_a:
        value: bus_current / 1000.0
      battery_maximum_capacity_ah:
        value: battery_maximum_capacity / 1000.0
      battery_remaining_capacity_ah:
        value: battery_remaining_capacity / 1000.0
      solar_bus_voltage_v:
        value: solar_bus_voltage / 1000.0
      solar_bus_current_a:
        value: solar_bus_current / 1000.0

  store_and_forward_message:
    seq:
      - id: message_data
        size-eos: true

  uplink_response:
    seq:
      - id: rssi
        type: s2
      - id: received_on
        type: s4
      - id: response_code
        type: s4
      - id: checksum
        type: u1
    instances:
      response_description:
        value: >
          response_code == 0 ? "No Error" :
          response_code == 1 ? "Invalid Command Error" :
          response_code == 2 ? "Invalid Satellite Id Error" :
          response_code == 3 ? "Max Length Error" :
          response_code == 4 ? "Invalid Argument Error" :
          response_code == 5 ? "Checksum Error" :
          response_code == 6 ? "Value Not In Range" :
          response_code == 7 ? "I2C Disabled Error" : "Unknown"

  imu_data:
    seq:
      - id: accelerometer_x
        type: s2
      - id: accelerometer_y
        type: s2
      - id: accelerometer_z
        type: s2
      - id: ang_velocity_x
        type: s2
      - id: ang_velocity_y
        type: s2
      - id: ang_velocity_z
        type: s2
      - id: magnetometer_x
        type: s2
      - id: magnetometer_y
        type: s2
      - id: magnetometer_z
        type: s2
      - id: linear_accel_x
        type: s2
      - id: linear_accel_y
        type: s2
      - id: linear_accel_z
        type: s2
      - id: orientation_x
        type: s2
      - id: orientation_y
        type: s2
      - id: orientation_z
        type: s2
      - id: gravity_x
        type: s2
      - id: gravity_y
        type: s2
      - id: gravity_z
        type: s2
      - id: checksum
        type: u1
    instances:
      accelerometer_x_scaled:
        value: accelerometer_x / 100.0
      accelerometer_y_scaled:
        value: accelerometer_y / 100.0
      accelerometer_z_scaled:
        value: accelerometer_z / 100.0
      ang_velocity_x_scaled:
        value: ang_velocity_x / 100.0
      ang_velocity_y_scaled:
        value: ang_velocity_y / 100.0
      ang_velocity_z_scaled:
        value: ang_velocity_z / 100.0
      magnetometer_x_scaled:
        value: magnetometer_x / 100.0
      magnetometer_y_scaled:
        value: magnetometer_y / 100.0
      magnetometer_z_scaled:
        value: magnetometer_z / 100.0
      linear_accel_x_scaled:
        value: linear_accel_x / 100.0
      linear_accel_y_scaled:
        value: linear_accel_y / 100.0
      linear_accel_z_scaled:
        value: linear_accel_z / 100.0
      orientation_x_scaled:
        value: orientation_x / 100.0
      orientation_y_scaled:
        value: orientation_y / 100.0
      orientation_z_scaled:
        value: orientation_z / 100.0
      gravity_x_scaled:
        value: gravity_x / 100.0
      gravity_y_scaled:
        value: gravity_y / 100.0
      gravity_z_scaled:
        value: gravity_z / 100.0

  hms_power_data:
    seq:
      - id: recorded_at
        type: u4
      - id: bus_voltage
        type: u2
      - id: bus_current
        type: s2
      - id: solar_bus_voltage
        type: u2
      - id: solar_bus_current
        type: u2
      - id: state_of_charge
        type: u2
      - id: battery_full_capacity
        type: u2
      - id: battery_remaining_capacity
        type: u2
      - id: checksum
        type: u1
    instances:
      bus_voltage_v:
        value: bus_voltage / 1000.0
      bus_current_a:
        value: bus_current / 1000.0
      solar_bus_voltage_v:
        value: solar_bus_voltage / 1000.0
      solar_bus_current_a:
        value: solar_bus_current / 1000.0
      battery_full_capacity_ah:
        value: battery_full_capacity / 1000.0
      battery_remaining_capacity_ah:
        value: battery_remaining_capacity / 1000.0

  hms_temperature_data:
    seq:
      - id: recorded_at
        type: u4
      - id: obc_temperature
        type: s2
      - id: battery_temperature
        type: s2
      - id: external_temperature
        type: s2
      - id: base_plate_temperature
        type: s2
      - id: solar_panel_temperature
        type: s2
      - id: checksum
        type: u1
    instances:
      obc_temperature_celsius:
        value: obc_temperature / 10.0
      battery_temperature_celsius:
        value: battery_temperature / 10.0
      external_temperature_celsius:
        value: external_temperature / 10.0
      base_plate_temperature_celsius:
        value: base_plate_temperature / 10.0
      solar_panel_temperature_celsius:
        value: solar_panel_temperature / 10.0

  radiation_data:
    seq:
      - id: recorded_at
        type: u4
      - id: radiation
        type: s2
      - id: checksum
        type: u1
    instances:
      radiation_microsv_per_h:
        value: radiation / 100.0

  system_config:
    seq:
      - id: config_data
        size-eos: true
