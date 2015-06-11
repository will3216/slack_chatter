require 'spec_helper'

describe SlackChatter::Client do

  let(:client) { SlackChatter::Client.new("sample_access_token") }

  describe '#new' do
    subject { client }
    it { should be_a SlackChatter::Client }
  end

  describe ".api_uri_root" do
    let(:port)       { nil }
    let(:host)       { nil }
    let(:uri_scheme) { nil }
    subject { SlackChatter::Client.new(:fake_id, username: "fake_user", uri_port: port, uri_host: host, uri_scheme: uri_scheme) }


    it { expect(subject.api_uri_root).to eq 'https://slack.com/api/' }

    context 'setting a port' do
      let(:port) { 3000 }
      it { expect(subject.api_uri_root).to eq 'https://slack.com:3000/api/' }
    end

    context 'setting a host and protocol' do
      let(:host)         { 'localhost' }
      let(:uri_scheme)   { 'http' }
      it { expect(subject.api_uri_root).to eq 'http://localhost/api/' }
    end
  end

  describe ".post" do
    it "processes a post" do
      path = "method_path"
      stub_post(path).to_return(:status => 200, :body => JSON.dump({"ok"=>true}), :headers => {})
      client.post(path)
      some_request(:post, path).should have_been_made
    end
  end

  describe ".get" do
    it "processes a get" do
      path = "method_path"
      stub_get(path).to_return(:status => 200, :body => JSON.dump({"ok"=>true}), :headers => {})
      client.get(path)
      some_request(:get, path).should have_been_made
    end
  end
end