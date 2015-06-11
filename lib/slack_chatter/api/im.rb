require_relative "./base"
module SlackChatter
  module Api
    class Im < SlackChatter::Api::Base


      def close channel_id
        call_method("im", "close", {"channel" => channel_id})
      end

      def history channel_id, opts={}
        # latest          - End of time range of messages to include in results
        # oldest          - Start of time range of messages to include in results
        # inclusive       - Include messages with latest or oldest timestamp in results (send 0/1)
        # count           - Number of messages to return, between 1 and 1000
        call_method("im", "history", {"channel" => channel_id}.merge(opts))
      end

      def list
        # exclude_archives - Don't return archived im (send 0/1)
        call_method("im", "list", {})
      end

      def mark channel_id, epoch_time_stamp
        # ts               - Timestamp of the most recently seen message
        call_method("im", "mark", {"channel" => channel_id, "ts" => epoch_time_stamp})
      end

      def open channel_id
        call_method("im", "open", {"channel" => channel_id})
      end
    end
  end
end