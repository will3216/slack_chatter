$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'slack_chatter'
require 'uri'
require 'json'
require 'rspec'
require 'rspec_encoding_matchers'
require 'webmock/rspec'
require_relative "./shared_examples/request_namespace_examples.rb"

config_path = File.join(File.expand_path("../../config", __FILE__), "method_config.yml")
METHOD_CONFIG = YAML.load_file(config_path)

class MockResponse
  attr_accessor :body
  def initialize(file)
    @body = fixture(file)
  end
end

def convert_arg_value arg
  case arg
  when "token"
    nil
  when "string"
    "test string"
  when "integer"
    rand(100)
  when "id"
    "F0439RHU9"
  when "url"
    "https://www.slack.com/foo/bar.php"
  when "epoch"
    Time.now().to_i
  when "bool"
    true
  when "json_array"
    raise NotImplementedError
  when Hash
    if arg.key?("choice")
      arg["choice"][rand(arg["choice"].length)]
    elsif arg.key?("multi_choice")
      rand(arg["multi_choice"].length).times.map do |v|
        arg["multi_choice"][rand(arg["multi_choice"].length)]
      end.uniq
    end
  when "formatting"
    raise NotImplementedError
  end
end
def stub_delete(uri)
  request_stub(:delete, uri)
end

def stub_post(uri)
  request_stub(:post, uri)
end

def stub_get(uri)
  request_stub(:get, uri)
end

def stub_api_get(path, base_uri = "https://slack.com/api/")
  stub_get(URI.join(base_uri, path).to_s)
    .with(:query => hash_including({"token" => "fake-token"}))
end

def api_get_request(path, base_uri = "https://slack.com/api/")
  some_request :get, URI.join(base_uri, path).to_s
end

def stub_put(uri)
  request_stub(:put, uri)
end

def request_stub(method, uri)
  stub_request(method, /.*?#{uri}.*?/)
end

def some_request(method, uri)
  a_request(method, /.*?#{uri}.*?/)
end

def fixture_location(namespace, file)
  File.join(File.expand_path('../fixtures/', __FILE__), namespace, file)
end

def fixture(namespace, file)
  File.read(fixture_location(namespace, file))
end

def json_fixture(namespace, file)
  JSON.parse(fixture(namespace, file))
end

def response_fixture(file)
  MockResponse.new(file)
end
