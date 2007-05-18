module AsynapseSupport
  def has_(prefix, item)
    prefix = prefix.to_s
    item = item.to_s

    sy = "#{prefix}_#{item}"
    mo = sy.camelcase.singularize

    self.class_eval <<EOE
    has_many :_#{sy}, :class_name => "#{mo}"
    def #{sy}
      _#{sy}.map { |f| f.#{item.singularize} }
    end
EOE
  end
end
