require 'ostruct'

module SlackChatter
  class Response < OpenStruct
    attr_reader :response

    def initialize response
      parsed_res = JSON.parse(response.body)
      super(parsed_res)
      self.code = response.code
      self.send("success?=", (parsed_res["ok"] == true))
    end

    def to_h
      marshal_dump.with_indifferent_access
    end

    def to_json
      JSON.dump(to_h)
    end

  end
end