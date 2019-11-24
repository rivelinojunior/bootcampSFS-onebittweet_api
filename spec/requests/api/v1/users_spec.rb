require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET /api/v1/users/:id' do
    context 'when user exists' do
      let(:user) { create(:user) }
      let(:following_number) { Random.rand(9) }
      let(:followers_number) { Random.rand(9) }
      let(:tweet_number) { Random.rand(9) }

      before do
        followers_number.times { create(:user).follow(user) }
        following_number.times { user.follow(create(:user)) }
        tweet_number.times { create(:tweet, user: user) }

        get "/api/v1/users/#{user.id}"
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns valid user in json' do
        expect(json).to eql(serialized(Api::V1::UserSerializer, user))
      end

      it 'right followers number' do
        expect(json['followers_count']).to eql(followers_number)
      end

      it 'right following number' do
        expect(json['following_count']).to eql(following_number)
      end

      it 'right tweets number' do
        expect(json['tweets_count']).to eql(tweet_number)
      end
    end

    context 'when user dont exist' do
      let(:user_id) { -1 }

      before { get "/api/v1/users/#{user_id}" }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'GET /api/v1/users/current' do
    context 'Unauthenticated' do
      it_behaves_like :deny_without_authorization, :get, '/api/v1/users/current'
    end

    context 'Authenticated' do
      let(:user) { create(:user) }
      let(:following_number) { Random.rand(9) }
      let(:followers_number) { Random.rand(9) }
      let(:tweet_number) { Random.rand(9) }

      before do
        followers_number.times { create(:user).follow(user) }
        following_number.times { user.follow(create(:user)) }
        tweet_number.times { create(:tweet, user: user) }

        get '/api/v1/users/current', headers: header_with_authentication(user)
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns valid user in json' do
        expect(json).to eql(serialized(Api::V1::UserSerializer, user))
      end

      it 'Right followers number' do
        expect(json['followers_count']).to eql(followers_number)
      end

      it 'Right following number' do
        expect(json['following_count']).to eql(following_number)
      end

      it 'Right tweets number' do
        expect(json['tweets_count']).to eql(tweet_number)
      end
    end
  end
end
