require 'sidekiq/worker'

module DelayedPaperclip
  module Jobs
    class Sidekiq
      include ::Sidekiq::Worker
      sidekiq_options :queue => :paperclip

      def self.enqueue_delayed_paperclip(instance_klass, instance_id, attachment_name, shard)
        perform_async(instance_klass, instance_id, attachment_name, shard)
      end

      def perform(instance_klass, instance_id, attachment_name, shard)
        DelayedPaperclip.process_job(instance_klass, instance_id, attachment_name, shard)
      end
    end
  end
end