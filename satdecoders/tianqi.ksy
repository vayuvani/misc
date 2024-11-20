meta:
  id: tianqi
  title: TianQi / GaoFen Constellation by @tckb
  endian: le

seq:
  - id: header
    type: header
  - id: unknown_blocks
    type: unknown_blocks
  - id: timestamp
    type: timestamp
  - id: orbital_data
    type: orbital_data
  - id: padding
    size-eos: true

types:
  header:
    seq:
      - id: net_id
        type: u1
      - id: message_type_id
        type: u1
      - id: head_unknown
        type: u1
      - id: sat_timestamp
        type: u4be
      - id: sat_id
        type: u1

  unknown_blocks:
    seq:
      - id: block1
        type: unknown_block1
      - id: block2
        type: unknown_block2
      - id: block3
        type: unknown_block3

  unknown_block1:
    seq:
      - id: unknown3
        type: u1
      - id: unknown4
        type: u1
      - id: unknown5
        type: u1
      - id: unknown6
        type: u1
      - id: unknown7
        type: u1
      - id: unknown8
        type: u1
      - id: unknown9
        type: u1

  unknown_block2:
    seq:
      - id: unknown10_1
        type: u1
      - id: unknown10_2
        type: u1
      - id: unknown10_3
        type: u1

  unknown_block3:
    seq:
      - id: unknown11_1
        type: u1
      - id: unknown11_2
        type: u1
      - id: unknown11_3
        type: u1
      - id: unknown11_4
        type: u1
      - id: unknown11_5
        type: u1
      - id: unknown11_6
        type: u1
      - id: unknown12_1
        type: u1
      - id: unknown12_2
        type: u1
      - id: unknown12_3
        type: u1
      - id: unknown12_4
        type: u1

  timestamp:
    seq:
      - id: last_rx_time
        type: u4be
      - id: unknown13
        type: u1
      - id: unknown14
        type: u1

  orbital_data:
    seq:
      - id: set1
        type: orbital_elements
      - id: set2
        type: orbital_elements

  orbital_elements:
    seq:
      - id: semi_major_axis
        type: f4be
      - id: eccentricity
        type: f4be
      - id: inclination
        type: f4be
      - id: ascending_node
        type: f4be
      - id: angle_x
        type: f4be
      - id: angle_y
        type: f4be
