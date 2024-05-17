# frozen_string_literal: true

module AsMethod
  class GetServiceObject
    AMBIGUOUS_NAME_ERROR_MSG = <<-MSG
      Ambiguous name. %s has both class and instance methods named %s.
      Please use '::method_name' or '#method_name' to specify which one you want.
    MSG

    def self.call(obj, method_name)
      new.call(obj, method_name)
    end

    def call(obj, method_name)
      raise ArgumentError, "expected #{obj} to be a Module or Class" unless obj.is_a?(Module)

      @obj = obj
      @method_name = method_name

      if method_name[0, 2] == "::"
        get_method(nil, method_name[2..-1])
      elsif method_name[0] == "#"
        get_method(method_name[1..-1], nil)
      else
        get_method(method_name, method_name)
      end
    end

    private

    def get_instance_method(name)
      return unless name
      return unless @obj.method_defined?(name) || @obj.private_method_defined?(name)

      @obj.instance_method(name)
    end

    def get_class_method(name)
      return unless name
      return unless @obj.singleton_class.method_defined?(name) || @obj.singleton_class.private_method_defined?(name)

      @obj.method(name)
    end

    def get_method(instance_method_name, class_method_name)
      imethod = get_instance_method(instance_method_name)
      cmethod = get_class_method(class_method_name)

      if [imethod, cmethod].none?
        raise NameError, "undefined method #{@method_name.inspect} for #{@obj.inspect}"
      end

      if [imethod, cmethod].all?
        raise NameError, format(AMBIGUOUS_NAME_ERROR_MSG, @obj.inspect, @method_name.inspect)
      end

      (cmethod || imethod).owner.object
    end
  end # ... GetServiceObject
end # ... AsMethod
