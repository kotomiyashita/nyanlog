require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      basic_pass root_path
      # サインインページに移動し、サインインページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('Sign up')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_name', with: @user.name
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect  do
        find('input.btn').click
        sleep 1
      end.to change { User.count }.by(1)
      # トップページへ遷移することを確認する
      expect(page).to have_current_path(root_path)
      # トップページにユーザー名が表示されることを確認する
      expect(page).to have_content(@user.name)
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # サインインページに移動し、サインインページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('Sign up')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_name', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        find('input.btn').click
        sleep 1
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(page).to have_current_path(new_user_registration_path)
    end
  end
end

RSpec.describe 'ユーザーログイン機能', type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページに遷移する
    basic_pass root_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
  end

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)

    # サインインページへ移動する
    visit new_user_session_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)

    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password

    # ログインボタンをクリックする
    click_on('Log in')
    sleep 1

    # トップページに遷移していることを確認する
    expect(current_path).to eq(root_path)
  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)

    # トップページに遷移させる
    visit root_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)

    # 誤ったユーザー情報を入力する
    fill_in 'user_email', with: 'test'
    fill_in 'user_password', with: 'test'

    # ログインボタンをクリックする
    click_on('Log in')

    # サインインページに戻ってきていることを確認する
    expect(current_path).to eq(new_user_session_path)
  end
end

RSpec.describe 'ユーザー編集機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  it '正しい情報を入力すればユーザー情報を編集できる' do
    # サインインする
    sign_in(@user)
    # トップページにユーザー名が表示されることを確認する
    expect(page).to have_content(@user.name)
    # ユーザー名がリンクになっていることを確認する
    click_on(@user.name)
    # 編集ページに移動することを確認する
    expect(page).to have_current_path(edit_user_path(@user))
    # 変更したいユーザー情報を入力する
    fill_in 'user_name', with: '新しいユーザー名'
    fill_in 'user_email', with: 'new_email@example.com'
    # アップデートボタンをクリックする
    click_on('Update')
    # ユーザー情報がアップデートできていることを確認する
    updated_user = User.find(@user.id)
    expect(updated_user.name).to eq('新しいユーザー名')
    # トップページに戻ってきていることを確認する
    expect(page).to have_current_path(root_path)
  end
  it '誤った情報を入力してもユーザー情報を編集できない' do
    # サインインする
    sign_in(@user)
    # トップページにユーザー名が表示されることを確認する
    expect(page).to have_content(@user.name)
    # ユーザー名がリンクになっていることを確認する
    click_on(@user.name)
    # 編集ページに移動することを確認する
    expect(page).to have_current_path(edit_user_path(@user))
    # 誤ったユーザー情報を入力する
    fill_in 'user_name', with: ''
    fill_in 'user_email', with: 'invalid_email'
    # アップデートボタンをクリックする
    click_on('Update')
    # ユーザー情報がアップデートされていないことを確認する
    updated_user = User.find(@user.id)
    expect(updated_user.name).to eq(@user.name)
    # 編集ページに戻ってきていることを確認する
    expect(page).to have_current_path(edit_user_path(@user))
  end
end
