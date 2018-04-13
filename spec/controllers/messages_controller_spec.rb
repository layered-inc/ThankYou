require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:sender) { create(:user) }
  let(:recipient) { create(:user) }
  let(:valid_attributes) { attributes_for(:message).merge(sender_id: sender.to_param, recipient_id: recipient.to_param) }

  describe "GET #index" do
    before do
      sign_in(sender)
    end

    it "returns a success response" do
      message = Message.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #earch" do
    before do
      sign_in(sender)
    end

    it "returns a success response" do
      message = Message.create! valid_attributes

      get :search, params: { button: 'sender', searching_user_id: sender.id }
      expect(response).to be_successful
    end
  end
end
