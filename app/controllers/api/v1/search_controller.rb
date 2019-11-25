module Api
  module V1
    class SearchController < Api::V1::ApiController
      def index
        page = (params[:page] || 1)
        tweets = Tweet.search(params[:query], page: page)
        users = User.search(params[:query], page: page)

        tweets_json = serialize(tweets, Api::V1::TweetSerializer)
        users_json = serialize(users, Api::V1::UserSerializer)

        render json: { tweets: tweets_json, users: users_json }
      end

      def autocomplete; end

      private

      def serialize(resources, serializer)
        ActiveModelSerializers::SerializableResource.new(
          resources,
          each_serializer: serializer
        )
      end
    end
  end
end
