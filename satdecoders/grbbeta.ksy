---
meta:
  id: grbbeta
  title: GRBBeta beacon, message and digi decoder
  endian: be
doc-ref: "https://grbbeta.tuke.sk/index.php/en/home/"
# 2024-08-01, DL7NDR
doc: |
  :field uptime_total: id1.id2.uptime_total
  :field radio_boot_count: id1.id2.radio_boot_count
  :field radio_mcu_act_temperature: id1.id2.radio_mcu_act_temperature
  :field rf_power_amplifier_act_temperature: id1.id2.rf_power_amplifier_act_temperature
  :field cw_beacon: id1.id2.cw_beacon
  :field digi_dest_callsign: id1.id2.id3.ax25_frame.ax25_header.dest_callsign_raw.callsign_ror.callsign
  :field digi_src_callsign: id1.id2.id3.ax25_frame.ax25_header.src_callsign_raw.callsign_ror.callsign
  :field digi_src_ssid: id1.id2.id3.ax25_frame.ax25_header.src_ssid_raw.ssid
  :field digi_dest_ssid: id1.id2.id3.ax25_frame.ax25_header.dest_ssid_raw.ssid
  :field rpt_instance___callsign: id1.id2.id3.ax25_frame.ax25_header.repeater.rpt_instance.___.rpt_callsign_raw.callsign_ror.callsign
  :field rpt_instance___ssid: id1.id2.id3.ax25_frame.ax25_header.repeater.rpt_instance.___.rpt_ssid_raw.ssid
  :field rpt_instance___hbit: id1.id2.id3.ax25_frame.ax25_header.repeater.rpt_instance.___.rpt_ssid_raw.hbit
  :field digi_ctl: id1.id2.id3.ax25_frame.ax25_header.ctl
  :field digi_pid: id1.id2.id3.ax25_frame.ax25_header.pid
  :field digi_message: id1.id2.id3.ax25_frame.digi_message
  :field uhf_uptime_since_reset: id1.id2.id3.id4.ax25_frame.ax25_payload.uhf_uptime_since_reset
  :field uhf_uptime_total: id1.id2.id3.id4.ax25_frame.ax25_payload.uhf_uptime_total
  :field uhf_radio_boot_count: id1.id2.id3.id4.ax25_frame.ax25_payload.uhf_radio_boot_count
  :field uhf_rf_segment_reset_count: id1.id2.id3.id4.ax25_frame.ax25_payload.uhf_rf_segment_reset_count
  :field uhf_radio_mcu_act_temperature: id1.id2.id3.id4.ax25_frame.ax25_payload.uhf_radio_mcu_act_temperature
  :field uhf_rf_chip_act_temperature: id1.id2.id3.id4.ax25_frame.ax25_payload.uhf_rf_chip_act_temperature
  :field uhf_rf_power_amplifier_act_temperature: id1.id2.id3.id4.ax25_frame.ax25_payload.uhf_rf_power_amplifier_act_temperature
  :field uhf_digipeater_forwarded_message_count: id1.id2.id3.id4.ax25_frame.ax25_payload.uhf_digipeater_forwarded_message_count
  :field uhf_last_digipeater_user_sender_s_callsign: id1.id2.id3.id4.ax25_frame.ax25_payload.uhf_last_digipeater_user_sender_s_callsign
  :field uhf_rx_data_packets: id1.id2.id3.id4.ax25_frame.ax25_payload.uhf_rx_data_packets
  :field uhf_tx_data_packets: id1.id2.id3.id4.ax25_frame.ax25_payload.uhf_tx_data_packets
  :field uhf_actual_rssi: id1.id2.id3.id4.ax25_frame.ax25_payload.uhf_actual_rssi
  :field uhf_value_of_rssi_when_carrier_detected: id1.id2.id3.id4.ax25_frame.ax25_payload.uhf_value_of_rssi_when_carrier_detected
  :field vhf_uptime_since_reset: id1.id2.id3.id4.ax25_frame.ax25_payload.vhf_uptime_since_reset
  :field vhf_uptime_total: id1.id2.id3.id4.ax25_frame.ax25_payload.vhf_uptime_total
  :field vhf_radio_boot_count: id1.id2.id3.id4.ax25_frame.ax25_payload.vhf_radio_boot_count
  :field vhf_rf_segment_reset_count: id1.id2.id3.id4.ax25_frame.ax25_payload.vhf_rf_segment_reset_count
  :field vhf_radio_mcu_act_temperature: id1.id2.id3.id4.ax25_frame.ax25_payload.vhf_radio_mcu_act_temperature
  :field vhf_rf_chip_act_temperature: id1.id2.id3.id4.ax25_frame.ax25_payload.vhf_rf_chip_act_temperature
  :field vhf_rf_power_amplifier_act_temperature: id1.id2.id3.id4.ax25_frame.ax25_payload.vhf_rf_power_amplifier_act_temperature
  :field vhf_digipeater_forwarded_message_count: id1.id2.id3.id4.ax25_frame.ax25_payload.vhf_digipeater_forwarded_message_count
  :field vhf_last_digipeater_user_sender_s_callsign: id1.id2.id3.id4.ax25_frame.ax25_payload.vhf_last_digipeater_user_sender_s_callsign
  :field vhf_rx_data_packets: id1.id2.id3.id4.ax25_frame.ax25_payload.vhf_rx_data_packets
  :field vhf_tx_data_packets: id1.id2.id3.id4.ax25_frame.ax25_payload.vhf_tx_data_packets
  :field vhf_actual_rssi: id1.id2.id3.id4.ax25_frame.ax25_payload.vhf_actual_rssi
  :field vhf_value_of_rssi_when_carrier_detected: id1.id2.id3.id4.ax25_frame.ax25_payload.vhf_value_of_rssi_when_carrier_detected
  :field message: id1.id2.id3.id4.id5.ax25_frame.message

seq:
  - id: id1
    type: type1

types:
  type1:
# checking for CW
    seq:
      - id: id2
        type:
          switch-on: message_type1
          cases:
            0x6465206861326772: cw_message # de ha2gr
            _: not_cw_message

    instances:
      message_type1:
        type: u8
        pos: 0

  cw_message:
   seq:
     - id: de_ha2grb
       type: str
       size: 13
       encoding: ASCII
       valid:
        any-of:
          - '"de ha2grb = u"'
          - '"DE HA2GRB = U"'

     - id: uptime_total_raw
       type: str
       terminator: 0x72  # r
       encoding: UTF-8

     - id: radio_boot_count_raw
       type: str
       terminator: 0x74  # t
       encoding: UTF-8

     - id: radio_mcu_act_temperature_raw
       type: str
       terminator: 0x70  # p
       encoding: UTF-8

     - id: rf_power_amplifier_act_temperature_raw
       type: str
       encoding: UTF-8
       terminator: 0x20 # 'space'

   instances:
          uptime_total:
            value: uptime_total_raw.to_i *60 # to get seconds
          radio_boot_count:
            value: radio_boot_count_raw.to_i
          radio_mcu_act_temperature:
            value: radio_mcu_act_temperature_raw.to_i
          rf_power_amplifier_act_temperature:
            value: rf_power_amplifier_act_temperature_raw.to_i
          cw_beacon:
            value: '"de ha2grb = u"+uptime_total_raw+"r"+radio_boot_count_raw+"t"+radio_mcu_act_temperature_raw+"p"+rf_power_amplifier_act_temperature_raw+" ar"'

# checking for Digi
  not_cw_message:
    seq:
      - id: id3
        type:
          switch-on: message_type2
          cases:
            0x9082648E: digi # HA2G
            _: not_digi

    instances:
      message_type2:
        type: u4
        pos: 14 # beginning of digi callsign

  digi:
    seq:
      - id: ax25_frame
        type: ax25_frame

    types:
      ax25_frame:
        seq:
          - id: ax25_header
            type: ax25_header
          - id: digi_message
            type: str
            encoding: utf-8
            size-eos: true

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
          - id: repeater
            type: repeater
            if: (src_ssid_raw.ssid_mask & 0x01) == 0
            doc: 'Repeater flag is set!'
          - id: ctl
            type: u1
          - id: pid
            type: u1

      repeater:
        seq:
          - id: rpt_instance
            type: repeaters
            repeat: until
            repeat-until: ((_.rpt_ssid_raw.ssid_mask & 0x1) == 0x1)
            doc: 'Repeat until no repeater flag is set!'

      repeaters:
        seq:
          - id: rpt_callsign_raw
            type: callsign_raw
          - id: rpt_ssid_raw
            type: ssid_mask

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
          hbit:
            value: (ssid_mask & 0x80) >> 7

# checking for beacon
  not_digi:
    seq:
      - id: id4
        type:
          switch-on: message_type3
          cases:
            0x552C: beacon_uhf
            0x562C: beacon_vhf
            _: not_beacon

    instances:
      message_type3:
        type: u2
        pos: 16 # beginning of payload

  beacon_uhf:
    seq:
     - id: ax25_frame
       type: ax25_frame

    types:
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
          - id: uhf_beacon_identification
            type: str
            terminator: 0x2c
            encoding: utf8
          - id: uhf_uptime_since_reset_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: uhf_uptime_total_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: uhf_radio_boot_count_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: uhf_rf_segment_reset_count_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: uhf_radio_mcu_act_temperature_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: uhf_rf_chip_act_temperature_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: uhf_rf_power_amplifier_act_temperature_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: uhf_digipeater_forwarded_message_count_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: uhf_last_digipeater_user_sender_s_callsign
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: uhf_rx_data_packets_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: uhf_tx_data_packets_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: uhf_actual_rssi_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: uhf_value_of_rssi_when_carrier_detected_raw
            type: str
            terminator: 0x00
            encoding: utf8

        instances:
          uhf_uptime_since_reset:
            value: uhf_uptime_since_reset_raw.to_i
          uhf_uptime_total:
            value: uhf_uptime_total_raw.to_i
          uhf_radio_boot_count:
            value: uhf_radio_boot_count_raw.to_i
          uhf_rf_segment_reset_count:
            value: uhf_rf_segment_reset_count_raw.to_i
          uhf_radio_mcu_act_temperature:
            value: uhf_radio_mcu_act_temperature_raw.to_i
          uhf_rf_chip_act_temperature:
            value: uhf_rf_chip_act_temperature_raw.to_i
          uhf_rf_power_amplifier_act_temperature:
            value: uhf_rf_power_amplifier_act_temperature_raw.to_i
          uhf_digipeater_forwarded_message_count:
            value: uhf_digipeater_forwarded_message_count_raw.to_i
          uhf_rx_data_packets:
            value: uhf_rx_data_packets_raw.to_i
          uhf_tx_data_packets:
            value: uhf_tx_data_packets_raw.to_i
          uhf_actual_rssi:
            value: uhf_actual_rssi_raw.to_i
          uhf_value_of_rssi_when_carrier_detected:
            value: uhf_value_of_rssi_when_carrier_detected_raw.to_i

  beacon_vhf:
    seq:
     - id: ax25_frame
       type: ax25_frame

    types:
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
          - id: vhf_beacon_identification
            type: str
            terminator: 0x2c
            encoding: utf8
          - id: vhf_uptime_since_reset_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: vhf_uptime_total_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: vhf_radio_boot_count_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: vhf_rf_segment_reset_count_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: vhf_radio_mcu_act_temperature_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: vhf_rf_chip_act_temperature_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: vhf_rf_power_amplifier_act_temperature_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: vhf_digipeater_forwarded_message_count_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: vhf_last_digipeater_user_sender_s_callsign
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: vhf_rx_data_packets_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: vhf_tx_data_packets_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: vhf_actual_rssi_raw
            type: str
            terminator: 0x2C
            encoding: utf8
          - id: vhf_value_of_rssi_when_carrier_detected_raw
            type: str
            terminator: 0x00
            encoding: utf8

        instances:
          vhf_uptime_since_reset:
            value: vhf_uptime_since_reset_raw.to_i
          vhf_uptime_total:
            value: vhf_uptime_total_raw.to_i
          vhf_radio_boot_count:
            value: vhf_radio_boot_count_raw.to_i
          vhf_rf_segment_reset_count:
            value: vhf_rf_segment_reset_count_raw.to_i
          vhf_radio_mcu_act_temperature:
            value: vhf_radio_mcu_act_temperature_raw.to_i
          vhf_rf_chip_act_temperature:
            value: vhf_rf_chip_act_temperature_raw.to_i
          vhf_rf_power_amplifier_act_temperature:
            value: vhf_rf_power_amplifier_act_temperature_raw.to_i
          vhf_digipeater_forwarded_message_count:
            value: vhf_digipeater_forwarded_message_count_raw.to_i
          vhf_rx_data_packets:
            value: vhf_rx_data_packets_raw.to_i
          vhf_tx_data_packets:
            value: vhf_tx_data_packets_raw.to_i
          vhf_actual_rssi:
            value: vhf_actual_rssi_raw.to_i
          vhf_value_of_rssi_when_carrier_detected:
            value: vhf_value_of_rssi_when_carrier_detected_raw.to_i
    
# checking for Message
  not_beacon:
    seq:
      - id: id5
        type:
          switch-on: message_type4
          cases:
            0x846103f0: msg # (HA2GR)B + ssid mask + ctl + pid

    instances:
      message_type4:
        type: u4
        pos: 12

  msg:
    seq:
      - id: ax25_frame
        type: ax25_frame

    types:
      ax25_frame:
        seq:
          - id: ax25_header
            type: ax25_header
          - id: message
            type: str
            encoding: utf-8
            size-eos: true

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
          hbit:
            value: (ssid_mask & 0x80) >> 7
