# flutter_infinite_scroll_list

GitHubのリポジトリを検索してリスト表示するアプリです。リスト表示には以下の機能があります。

- 無限スクロール
  - 固定のページサイズごとにデータを取得＆表示
  - リスト下端までスクロールすると次のページを読み込み
- Pull-to-Refresh
- 検索キーワードの更新でリフレッシュ
- エラー画面・0件画面の表示

[Qiita に詳細な説明記事があります](https://qiita.com/Seo-4d696b75/items/6c7e5c01175c07e168f6)

![infinite_scroll](https://github.com/Seo-4d696b75/flutter_infinite_scroll_list/assets/25225028/edd9c62e-f8ca-4496-804a-afcb649f10a1)


## Getting Started

### 1. Install Flutter via fvm

```bash
fvm install
```

### 2. Get dependencies & Generate code

```bash
fvm flutter pub get
fvm flutter pub run build_runner build
fvm flutter gen-l10n
```

### 3. Get access token

This app uses [GitHub repository search API](https://docs.github.com/ja/rest/search/search?apiVersion=2022-11-28#search-repositories),
so an access token is required.

### 4. Run

```bash
fvm flutter run --dart-define=ACCESS_TOKEN=${your_token}
```

