module LikewiseSid2uid

  def self.endianness
    num = 0x12345678
    little = '78563412'
    big = '12345678'
    native = [num].pack('l')
    netunpack = native.unpack('N')[0]
    str = '%8x' % netunpack
    case str
      when little
        'LITTLE'
      when big
        'BIG'
      else
        'OTHER'
    end
  end

end