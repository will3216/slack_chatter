require 'spec_helper'
RSpec.shared_examples "a request namespace" do

  describe "a request namespace's actions and responses" do

    subject { SlackChatter::Client.new("fake-token").send(namespace).send(action, *args) }

    it "should make the correct call and handle the response" do
      stub_api_get("#{namespace}\.#{action.to_s.camelize(:lower)}").to_return(:body => fixture("#{namespace}","#{action}.json"))
      subject
      api_get_request("#{namespace}\.#{action.to_s.camelize(:lower)}").should have_been_made
    end
  end
end