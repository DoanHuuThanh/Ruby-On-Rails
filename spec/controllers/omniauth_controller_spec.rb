require 'rails_helper'

    RSpec.describe Users::OmniauthCallbacksController, type: :controller do

    def set_omniauth(opts = {})
      default = {"provider"=>"facebook",
      "uid"=>"1070298204124160",
      "info"=>
       {"email"=>"thanh022302@gmail.com",
        "name"=>"Đoàn Hữu Thành",
        }}

      credentials = default.merge(opts)
      provider = credentials["provider"]
      user_hash = credentials["info"]

      OmniAuth.config.test_mode = true

      OmniAuth.config.mock_auth[provider] = {
        'uid' => credentials[:uid],
        "extra" => {
        "user_hash" => {
          "email" => user_hash[:email],
          "first_name" => user_hash[:first_name],
          "last_name" => user_hash[:last_name],
          "gender" => user_hash[:gender]
          }
        }
      }
    end

    def set_invalid_omniauth(opts = {})

      credentials = { :provider => :facebook,
                      :invalid  => :invalid_crendentials
                     }.merge(opts)

      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]

    end

    describe "GET '/users/auth/facebook'" do

      before(:each) do
        set_omniauth
        request.env["devise.mapping"] = Devise.mappings[:user]
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

        get :facebook
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      end

      it "should set user_id" do
        user = User.last
        expect(session[:user_id]).to eq(user.id) if user
      end
    end
    end
