require 'likewise_sid2uid/version'

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

  def self.sid2uid(sid_string)
    sid_string_delim = '-'
    parse_mode = 'PARSE_MODE_OPEN'

    tokens = sid_string.split(sid_string_delim)

    token_count = 0
    tail = {}
    revision = 0
    auth = 0

    tokens.each do |token|
      case parse_mode
        when 'PARSE_MODE_OPEN'
          if token == 'S'
            parse_mode = 'PARSE_MODE_REVISION'
          end

        when 'PARSE_MODE_REVISION'
          revision = token.to_i
          if revision > 0
            parse_mode = 'PARSE_MODE_AUTHORITY'
          end

        when 'PARSE_MODE_AUTHORITY'
          auth = token.to_i

          parse_mode = 'PARSE_MODE_TAIL'

        when 'PARSE_MODE_TAIL'
          tail[token_count - 3] = token.to_i
      end
      token_count += 1
    end

    uid_hash = 0

    if tail.count() > 3
      uid_hash ^= tail[tail.count() - 4]
      uid_hash ^= tail[tail.count() - 3]
      uid_hash ^= tail[tail.count() - 2]
    end

    uid_hash_temp = uid_hash

    uid_hash = (uid_hash_temp & 0xFFF00000) >> 20
    uid_hash += (uid_hash_temp & 0x000FFF00) >> 8
    uid_hash += (uid_hash_temp & 0x000000FF)
    uid_hash &= 0x00000FFF

    uid_hash <<= 19
    uid_hash += (tail[tail.count() - 1] & 0x0007FFFF)

    uid_hash
  end
end
