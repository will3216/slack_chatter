require 'spec_helper'

describe SlackChatter::Api::Oauth do
  METHOD_CONFIG["oauth"].each do |action, args|
    it_behaves_like "a request namespace" do
      let(:namespace)   { :oauth }
      let(:action) { action }
      let(:args) do
        args["args"].reject {|k,_| k == "token"}.map do |k,v|
          args[k] = convert_arg_value(v)
        end
      end
    end
  end
end