require 'spec_helper'

describe SlackChatter::Api::Im do
  METHOD_CONFIG["im"].each do |action, args|
    it_behaves_like "a request namespace" do
      let(:namespace)   { :im }
      let(:action) { action }
      let(:args) do
        args["args"].reject {|k,_| k == "token"}.map do |k,v|
          args[k] = convert_arg_value(v)
        end
      end
    end
  end
end