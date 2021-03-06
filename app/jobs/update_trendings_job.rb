class UpdateTrendingsJob < ApplicationJob
  queue_as :trendings

  def perform
    hashtags = {}
    DataStore.redis.scan_each(match: '#*').each do |hashtag|
      hashtags[hashtag] = DataStore.redis.get(hashtag)
    end

    @trending = Trending.new(hashtags: hashtags.sort_by do |h|
      h.last.to_i
    end.reverse[0..4])

    if @trending.save
      hashtags.each { |h| DataStore.redis.del(h.first) }
    else
      raise "Failed to update Trendings: #{@trending.errors.full_messages}"
    end
  end
end
