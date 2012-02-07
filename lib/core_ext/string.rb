class String
  # from ActiveSupport
  def constantize
    names = split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      constant = constant.const_defined?(name, false) ? constant.const_get(name) : constant.const_missing(name)
    end
    constant
  end
end