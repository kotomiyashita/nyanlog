require 'rails_helper'

RSpec.describe 'チャットルーム新規作成', type: :system do
  before do
    basic_pass root_path
    @user = FactoryBot.create(:user)
    sign_in(@user)
  end
  context 'チャットルーム新規作成ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # 遷移したトップページに「チャットを作成する」ボタンがある
      expect(page).to have_content('チャットを作成する')
      # 「チャットを作成する」ボタンをクリックするとチャットルーム新規作成ページに遷移する
      click_on('チャットを作成する')
      expect(current_path).to eq(new_room_path)
      # 正しい情報を入力する（ファクトリーを使用してチャットルーム名を生成）
      room_name = FactoryBot.build(:room).name
      fill_in 'room_name', with: room_name
      # 「新しいチャットルームを作成」ボタンをクリックするとルームモデルのカウントが1上がることを確認する
      expect do
        click_on('新しいチャットルームを作成')
        sleep 1
      end.to change { Room.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページにチャットルーム名が表示されることを確認する
      expect(page).to have_content(room_name)
    end
  end

  context 'チャットルーム新規作成ができないとき' do
    it '誤った情報を入力するとチャットルーム新規作成ができない' do
      # 遷移したトップページに「チャットを作成する」ボタンがあることを確認する
      expect(page).to have_content('チャットを作成する')
      # 「チャットを作成する」ボタンをクリックするとチャットルーム新規作成ページに遷移する
      click_on('チャットを作成する')
      expect(current_path).to eq(new_room_path)
      # 誤った情報を入力する（例: チャットルーム名を空にする）
      fill_in 'room_name', with: ''
      # 「新しいチャットルームを作成」ボタンをクリックしてもルームモデルのカウントは上がらないことを確認する
      expect do
        click_on('新しいチャットルームを作成')
        sleep 1
      end.not_to(change { Room.count })
      # チャットルーム新規作成ページへ戻されることを確認する
      expect(current_path).to eq(rooms_path)
    end
  end
end

RSpec.describe 'チャットルームの削除機能', type: :system do
  before do
    basic_pass root_path
    @room_user = FactoryBot.create(:room_user)
    sign_in(@room_user.user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されている' do
    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)
    # メッセージ情報を5つDBに追加する
    FactoryBot.create_list(:message, 5, room_id: @room_user.room.id, user_id: @room_user.user.id)
    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを確認する
    expect do
      find_link('チャットを終了する',  href: room_path(@room_user.room)).click
      sleep 1
    end.to change { @room_user.room.messages.count }.by(-5)
    # トップページに遷移していることを確認する
    expect(current_path).to eq(root_path)
  end
end
