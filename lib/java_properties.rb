class JavaProperties

  # Takes either a file IO or a String
  def self.parse(src)
    src.each_line.each_with_object({}) do |line, obj|
      # Strip comments
      next(obj) if line =~ /^\s*#/

      # Parse out keys/values
      key, val = line.split('=')
      key.strip!
      val.strip!

      # Construct Ruby objects from string values
      parsed_val = case val
      when 'true'
        true
      when 'false'
        false
      when /^(\d+)$/
        $1.to_i
      when ''
        nil
      else
        val
      end

      obj[key] = parsed_val
    end
  end

  def self.load(path)
    File.open(path) {|f| parse(f)}
  end

end

class Hash
  def to_properties
    self.map do |key,val|
      [key.to_properties, val.to_properties].join('=')
    end.join("\n") + "\n"
  end
end

class String
  def to_properties
    self
  end
end

class Symbol
  def to_properties
    to_s
  end
end

class TrueClass
  def to_properties
    to_s
  end
end

class FalseClass
  def to_properties
    to_s
  end
end

class Numeric
  def to_properties
    to_s
  end
end

