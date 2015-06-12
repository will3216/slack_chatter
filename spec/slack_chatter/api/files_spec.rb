require 'spec_helper'

describe SlackChatter::Api::Files do
  METHOD_CONFIG["files"].each do |action, args|
    it_behaves_like "a request namespace" do
      let(:namespace)   { :files }
      let(:action) { action }
      let(:args) do
        args["args"].reject {|k,_| k == "token"}.map do |k,v|
          args[k] = convert_arg_value(v)
        end
      end
    end
  end

  describe "#upload" do
    let(:client) { SlackChatter::Client.new("test-token") }
    let(:filename) { fixture_location("files", "upload.jpeg") }
    subject { client.files.upload({file: filename}) }

    before do
      allow(UploadIO).to receive(:new).and_return(UploadIO.new(File.open(filename), "multipart/form-data"))
    end

    it "should send the file" do
      expect(client).to receive(:post).with("files.upload", {}, query: {file: UploadIO.new(File.open(filename), "multipart/form-data")})
      subject
    end
  end
end