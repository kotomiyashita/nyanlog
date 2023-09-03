import $ from 'jquery';

export function someFunction() {
  $(document).on("turbolinks:load", function () {
  // ユーザー名での検索機能
    $("#user-search-input").on("input", function () {
      const searchTerm = $(this).val();
      // Ajaxリクエストを送信して検索結果をリアルタイム表示
      // 検索結果は #user-search-results に追加
    });

    // ユーザー追加ボタンのクリックイベント
    $("#add-user-button").click(function () {
      const selectedUserId = $("#user-select").val();
      const selectedUserName = $("#user-select option:selected").text();
      // 選択したユーザーを表示するための要素を作成し、選択したユーザーリストに追加
    });

    // 選択したユーザーの削除ボタンのクリックイベント
    $("#selected-users-list").on("click", ".remove-user-button", function () {
      // 選択したユーザーを選択したユーザーリストから削除
    });
  });
};