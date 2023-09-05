require 'rails_helper'

RSpec.describe 'チャットルーム新規作成', type: :system do
  before do
    basic_pass(root_path)
    sign_in(@user)
  end
  context 'チャットルーム新規作成ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # 遷移したトップページに「チャットを作成する」ボタンがある
      expect(page).to have_content('チャットを作成する')
      # 「チャットを作成する」ボタンをクリックするとチャットルーム新規作成ページに遷移する
      click_on('チャットを作成する')
      expect(current_path).to eq(new_chat_room_path)
      # 正しい情報を入力する（ファクトリーを使用してチャットルーム名を生成）
      room_name = FactoryBot.build(:room).name
      fill_in 'room_name', with: chat_room_name
      # 「新しいチャットルームを作成」ボタンをクリックするとユーザーモデルのカウントが1上がることを確認する
      expect {
        click_on('新しいチャットルームを作成')
        sleep 1
      }.to change { Room.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページにチャットルーム名が表示されることを確認する
      expect(page).to have_content(chat_room_name)
    end
  end

  context 'チャットルーム新規作成ができないとき' do
    it '誤った情報を入力するとチャットルーム新規作成ができない' do
      # 遷移したトップページに「チャットを作成する」ボタンがあることを確認する
      expect(page).to have_content('チャットを作成する')
      # 「チャットを作成する」ボタンをクリックするとチャットルーム新規作成ページに遷移する
      click_on('チャットを作成する')
      expect(current_path).to eq(new_chat_room_path)
      # 誤った情報を入力する（例: チャットルーム名を空にする）
      fill_in 'room_name', with: ''
      # 「新しいチャットルームを作成」ボタンをクリックしてもユーザーモデルのカウントは上がらないことを確認する
      expect {
        click_on('新しいチャットルームを作成')
        sleep 1
      }.not_to change { Room.count }
      # チャットルーム新規作成ページへ戻されることを確認する
      expect(current_path).to eq(new_chat_room_path)
    end
  end
end
