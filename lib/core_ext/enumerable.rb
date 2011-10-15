module Enumerable
  def strip_blanks
    reject {|i| i.nil? || i.empty? }
  end
end