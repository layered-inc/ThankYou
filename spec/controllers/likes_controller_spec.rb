require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:sender) { create(:user) }
  let(:recipient) { create(:user) }
  let(:valid_attributes) { attributes_for(:message).merge(sender_id: sender.to_param, recipient_id: recipient.to_param) }

  describe "Post #create" do
    before do
      sign_in(sender)
    end

    it "like the message" do
      message = Message.create! valid_attributes

      expect {
        post :create, params: { message_id: message.id }
      }.to change(message.likes, :count).by(+1)
    end

    it "unlike the message" do
      message = Message.create! valid_attributes

      expect {
        post :create, params: { message_id: message.id }
      }.to change(message.likes, :count).by(+1)

      expect {
        delete :destroy, params: { id: message.id }
      }.to change(message.likes, :count).by(-1)
    end
  end
end
