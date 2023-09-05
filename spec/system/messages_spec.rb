require 'rails_helper'

RSpec.describe 'メッセージ投稿機能', type: :system do
  before do
    basic_pass root_path
    @room_user = FactoryBot.create(:room_user)
    sign_in(@room_user.user)
  end

  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # カテゴリーを選択し、値をテキストフォームに入力する
      select 'ごはん', from: 'message-category'
      post = 'テスト'
      fill_in 'message_content', with: post

      # 送信した値がDBに保存されていることを確認する
      expect do
        find('#form-btn').click
        sleep 1
      end.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
    end
    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # カテゴリーを選択し、画像選択フォームに画像を添付する
      select 'ごはん', from: 'message-category'
      image_path = Rails.root.join('public/images/test_image1.png')
      attach_file('message[images][]', image_path, make_visible: true)

      # 送信した値がDBに保存されていることを確認する
      expect do
        find('#form-btn').click
        sleep 1
      end.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img')
    end
    it '画像とテキストの投稿に成功すると、投稿一覧に遷移して、投稿した画像とテキストが表示されている' do
      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # カテゴリーを選択、画像選択フォームに画像を添付し、テキストを入力する
      select 'ごはん', from: 'message-category'
      image_path = Rails.root.join('public/images/test_image1.png')
      attach_file('message[images][]', image_path, make_visible: true)
      post = 'テスト'
      fill_in 'message_content', with: post

      # 送信した値がDBに保存されていることを確認する
      expect do
        find('#form-btn').click
        sleep 1
      end.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))

      # 送信した画像とテキストがブラウザに表示されていることを確認する
      expect(page).to have_selector('img')
      expect(page).to have_content(post)
    end
    it '添付する画像が8枚までなら投稿に成功し、投稿一覧に8枚の画像がすべて表示される' do
      click_on(@room_user.room.name)

      # カテゴリーを選択し、画像選択フォームに８枚の画像を添付する
      select 'ごはん', from: 'message-category'
      image_paths = (1..8).map { |i| Rails.root.join("public/images/test_image#{i}.png") }
      attach_file('message[images][]', image_paths, make_visible: true)

      # 送信した値がDBに保存されていることを確認する
      expect do
        find('#form-btn').click
        sleep 1
      end.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img', count: 8)
    end
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、メッセージの送信に失敗する' do
      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # カテゴリーを選択する
      select 'ごはん', from: 'message-category'

      # DBに保存されていないことを確認する
      expect do
        find('#form-btn').click
      end.not_to(change { Message.count })

      # 元のページに戻ってくることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))
    end
    it 'カテゴリーが未選択の為、メッセージの送信に失敗する' do
      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # カテゴリーを選択せず、値をテキストフォームに入力する
      post = 'テスト'
      fill_in 'message_content', with: post

      # DBに保存されていないことを確認する
      expect do
        find('#form-btn').click
      end.not_to(change { Message.count })

      # 元のページに戻ってくることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))
    end
    it '添付する画像が9枚以上だとメッセージの送信に失敗する' do
      click_on(@room_user.room.name)

      # カテゴリーを選択し、画像選択フォームに9枚の画像をまとめて添付する
      select 'ごはん', from: 'message-category'
      image_paths = (1..9).map { |i| Rails.root.join("public/images/test_image#{i}.png") }
      attach_file('message[images][]', image_paths, make_visible: true)

      # 送信ボタンをクリックしてもDBに保存されないことを確認する
      expect do
        find('#form-btn').click
        sleep 1
      end.not_to(change { Message.count })
    end
  end
end
