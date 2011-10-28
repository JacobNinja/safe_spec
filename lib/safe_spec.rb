module SafeSpec
  def assert_valid_methods!(sym_or_hash)
    methods_to_stub = Hash === sym_or_hash ? sym_or_hash.keys : [sym_or_hash]
    methods_to_stub.each do |meth|
      raise NoMethodError, "#{meth} was not found in the method list on #{self}" unless self.respond_to?(meth)
    end
  end

  def method_missing(meth, *args, &block)
    method_regex = /^safe_(.+)/
    if meth.to_s =~ method_regex
      assert_valid_methods!(args.first)
      delegate_to = method_regex.match(meth.to_s)[1]
      self.send(delegate_to, *args, &block)
    else
      super
    end
  end
end