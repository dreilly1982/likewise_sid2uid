module LikewiseSid2uid
  def self.decode_sid(sid_packed)
    sid = sid_packed.unpack('C*')

    revision = '%s' % sid[0]
    word_count = sid[1]

    if sid[2] != 0 || sid[3] !=0
      i = 0
      auth_temp = ''
      while i < 6
        auth_temp << '%.2X' % sid[2+i]
        i += 1
      end
      auth = auth_temp
    else
      auth = (sid[4] << 24) | (sid[5] << 16) | (sid[6] << 8) | (sid[7] << 0)
      auth = '%i' % auth
    end

    sid_string = 'S-%s-%s' % [revision, auth]

    i = 0
    while i < word_count
      sid_part = ''
      (0..3).each do |j|
        sid_part.prepend(sid[8+(i*4)+j].to_s(base=16))
      end
      sid_string << '-%i' % sid_part.to_i(16)
      i += 1
    end

    sid_string
  end
end