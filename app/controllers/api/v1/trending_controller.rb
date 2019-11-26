module Api
  module V1
    class TrendingController < ApplicationController
      def index
        render json: Trending.last
      end
    end
  end
end
