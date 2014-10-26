module LikewiseSid2uid

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

    if tail.count > 3
      uid_hash ^= tail[tail.count - 4]
      uid_hash ^= tail[tail.count - 3]
      uid_hash ^= tail[tail.count - 2]
    end

    uid_hash_temp = uid_hash

    uid_hash = (uid_hash_temp & 0xFFF00000) >> 20
    uid_hash += (uid_hash_temp & 0x000FFF00) >> 8
    uid_hash += (uid_hash_temp & 0x000000FF)
    uid_hash &= 0x00000FFF

    uid_hash <<= 19
    uid_hash += (tail[tail.count - 1] & 0x0007FFFF)

    uid_hash
  end

end