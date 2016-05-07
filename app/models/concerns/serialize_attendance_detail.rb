class SerializeAttendanceDetail

  def dump(obj)
    obj = obj.map do |o|
      if o.class == AttendanceDetail
        o
      else
        AttendanceDetail.new(o[0], o[1])
      end
    end
    YAML.dump obj
  end

  def load(yaml)
    return nil if yaml.blank?
    YAML.load yaml
  end
end
