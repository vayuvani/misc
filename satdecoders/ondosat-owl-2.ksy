meta:
  id: ondosat_owl
  title: OndoSat OWL Decoder by @tckb
  endian: le

seq:
  - id: header
    type: header
  - id: message
    type: message

types:
  header:
    seq:
      - id: callsign
        type: str
        size: 6
        encoding: ASCII
      - id: spacer1
        type: str
        size: 1
        encoding: ASCII
      - id: sat_id
        type: str
        size: 4
        encoding: ASCII
      - id: spacer2
        type: u1

  message:
    seq:
      - id: type1_data
        type: type1_data
      - id: type2_data
        type: type2_data

  type1_data:
    seq:
      - id: battery_voltage
        type: u1
        doc: Battery voltage (8bit)
      - id: battery_charge
        type: u1
        doc: Battery charge (8bit)
      - id: byte3
        type: u1
      - id: byte4
        type: u1
      - id: battery_temperature
        type: u1
        doc: Battery temperature in Celsius (8bit)
    instances:
      format_id:
        value: byte3 & 0b1  # bit 1
        enum: house_keep_id
      operation_modes:
        value: (byte3 >> 1) & 0b11  # bits 2,3
        enum: operation_mode
      antenna_deploy_status:
        value: (byte3 >> 3) & 0b1  # Bit 4
        enum: deploy_status
      solar_panel_x_power:
        value: (byte3 >> 4) & 0b1  # Bit 5
        enum: solar_panel_status
      solar_panel_y_neg_power:
        value: (byte3 >> 5) & 0b1  # Bit 6
        enum: solar_panel_status
      solar_panel_z_power:
        value: (byte3 >> 6) & 0b1  # Bit 7
        enum: solar_panel_status
      solar_panel_y_power:
        value: (byte3 >> 7) & 0b1  # Bit 8
        enum: solar_panel_status
      solar_panel_z_pos_power:
        value: byte4 & 0b1  # bit 1
        enum: solar_panel_status
      time_after_last_reset:
        value: (byte4 >> 1) & 0b11111  # bits 2-6
      kill_switch_reset:
        value: (byte4 >> 6) & 0b1  # bit 7
        enum: kill_switch_status
      kill_switch_eps:
        value: (byte4 >> 7) & 0b1  # bit 8
        enum: kill_switch_status

  type2_data:
    seq:
      - id: gyro_x
        type: u1
        doc: Gyro X-axis rotation in degrees per second (8bit)
      - id: gyro_y
        type: u1
        doc: Gyro Y-axis rotation in degrees per second (8bit)
      - id: gyro_z
        type: u1
        doc: Gyro Z-axis rotation in degrees per second (8bit)
      - id: byte4
        type: u1
      - id: byte5
        type: u1
    instances:
      format_id:
        value: byte4 & 0b1  # bit 1
        enum: house_keep_id
      com_to_main_flag:
        value: (byte4 >> 1) & 0b1  # bit 2
        enum: comm_status
      reset_to_main_flag:
        value: (byte4 >> 2) & 0b1  # bit 3
        enum: comm_status
      eps_to_main_flag:
        value: (byte4 >> 3) & 0b1  # bit 4
        enum: comm_status
      uplink_success:
        value: (byte4 >> 4) & 0b1  # bit 5
        enum: uplink_status
      reservation_command:
        value: (byte4 >> 5) & 0b1  # bit 6
        enum: reservation_status
      gps_iridium_flag:
        value: (byte4 >> 6) & 0b1  # bit 7
        enum: gps_iridium_status
      main_to_gps_flag:
        value: (byte4 >> 7) & 0b1  # bit 8
        enum: comm_status
      mission_status:
        value: byte5 & 0b1111  # bits 1-4
        enum: mission_status
      mission_operating_status:
        value: (byte5 >> 4) & 0b1111  # bits 5-8
        enum: mission_operating_status

enums:
  house_keep_id:
    0: type1
    1: type2
  operation_mode:
    2: safe
    3: normal
  deploy_status:
    0: fail
    1: success
  solar_panel_status:
    0: shadow
    1: sunshine
  kill_switch_status:
    0: normal
    1: kill
  comm_status:
    0: no_comm
    1: comm
  uplink_status:
    0: not_success
    1: success
  reservation_status:
    0: nothing
    1: reserve
  gps_iridium_status:
    0: iridium
    1: gps
  mission_status:
    0: off
    1: on
  mission_operating_status:
    0: not_operating
    1: operating