require 'spec_helper'

describe SlackChatter::Api::Api do
  METHOD_CONFIG["api"].each do |action, args|
    it_behaves_like "a request namespace" do
      let(:namespace)   { :api }
      let(:action) { action }
      let(:args) do
        args["args"].reject {|k,_| k == "token"}.map do |k,v|
          args[k] = convert_arg_value(v)
        end if args["args"]
      end
    end
  end
end