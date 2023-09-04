require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message, :with_images)
  end

  describe 'メッセージ投稿' do
    context 'メッセージが投稿できる場合' do
      it 'contentとimageが存在していれば保存できる' do
        expect(@message).to be_valid
      end
      it 'contentが空でも保存できる' do
        @message.content = ''
        expect(@message).to be_valid
      end
      it 'imageが空でも保存できる' do
        @message = FactoryBot.build(:message)
        expect(@message).to be_valid
      end
      it 'imageが1枚でも保存できる' do
        @message = FactoryBot.build(:message)
        @message.images.attach(
          io: File.open('public/images/test_image.png'),
          filename: 'test_image.png'
        )
        expect(@message.images.count).to eq(1)
        expect(@message).to be_valid
      end
    end
    context 'メッセージが投稿できない場合' do
      it 'contentとimageが空では保存できない' do
        @message = FactoryBot.build(:message)
        @message.content = ''
        @message.valid?
        expect(@message.errors.full_messages).to include("Content can't be blank")
      end
      it 'roomが紐付いていないと保存できない' do
        @message.room = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('Room must exist')
      end
      it 'userが紐付いていないと保存できない' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('User must exist')
      end
    end
  end
end
