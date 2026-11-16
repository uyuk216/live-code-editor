# Live Code Editor

[デモを開く / Open demo](https://uyuk216.github.io/live-code-editor/)

- オフラインで使える軽量エディタ / Lightweight offline editor
- 日英 UI、ダーク・ライトテーマ / Japanese and English UI, dark and light themes
- HTML/CSS/JS プレビューと JSON 入出力 / Web preview and JSON import/export

自作エンジンで動く、軽量なブラウザ用コードエディタです。作者: うゆ。外部ライブラリや CDN は不要で、オフラインでも使えます。

## 起動

macOS では `起動.command` をダブルクリックします。その他の環境では、このフォルダで `python3 -m http.server 8000` を実行し、`http://localhost:8000` を開きます。データはブラウザの localStorage に保存されます。別のブラウザや端末には自動同期されません。

## 機能

ファイルとタブ、行番号、構文色付け、検索と置換、全ファイル検索、基本補完、簡易整形、コマンドパレット、HTML/CSS/JS のライブプレビュー、コンソール、日英切替、テーマ、JSON プロジェクト入出力、単一 HTML 書き出し。プレビューはサンドボックス内で実行します。保存は自動です。

対応言語: HTML、CSS、Python、JSON、JavaScript、TypeScript、JSX、TSX、Markdown、Java、Kotlin。未知の拡張子はプレーンテキストです。JSX/TSX は色付け対応であり、ビルドや実行はしません。

## 拡張

拡張機能パネルで言語パック JSON を追加できます。例:

```json
{"name":"Ruby","extensions":["rb"],"keywords":["def","end","class"],"lineComment":"#","strings":["\"","'"]}
```

宣言的な色付け設定だけを受け付け、任意コードを実行するプラグインは提供しません。今後は言語、テーマ、コマンドの宣言的な拡張が考えられます。

## 制限

マルチカーソルや高度な IntelliSense はありません。実行プレビューは Web 系のみです。Python/Java 系は編集・色付け・保存・ダウンロードに対応します。本物のターミナル、デバッガー、拡張機能マーケットはありません。大きなファイルでは色付けを省略します。localStorage の容量制限があります。

---

# English

Live Code Editor is a lightweight browser editor with an original engine. Author: うゆ. It has no external libraries or CDN dependencies and works offline.

## Start

Double-click `起動.command` on macOS. Elsewhere, run `python3 -m http.server 8000` in this folder and open `http://localhost:8000`. Projects are saved in this browser's localStorage; they do not sync across devices or browsers.

## Features

Files and tabs, line numbers, syntax highlighting, find and replace, search across files, basic completion, simple formatting, command palette, live HTML/CSS/JS preview, console, Japanese/English UI, themes, project JSON import/export and single HTML export. Preview runs in a sandbox. Saving is automatic.

Languages: HTML, CSS, Python, JSON, JavaScript, TypeScript, JSX, TSX, Markdown, Java and Kotlin. Unknown extensions are plain text. JSX/TSX are highlighted but not built or executed.

## Extensions

Add declarative language pack JSON in the Extensions panel using the example above. Executable plugins are excluded for safety. Future extension points include languages, themes and commands.

## Limits

No multicursor or advanced IntelliSense. Only web files run in preview. Python and Java-family files can be edited, highlighted, saved and downloaded. There is no real terminal, debugger or extension marketplace. Highlighting is skipped on very large files. Browser storage has a capacity limit.

## 更新履歴 / Changelog

- v2: 青を基調にした UI、検索とコマンド操作、入力補助、行操作、状態表示、プレビュー操作を改善。 / Refined blue UI, search, commands, editing aids, line actions, status and preview controls.

- 修正: プレビューが表示されない不具合（初期化時に要素が消えて処理が停止）を修正。 / Fixed a bug where the preview never rendered. 

- v3: Apple HIG のブランディング原則を参考に、ニュートラルな UI、控えめな青のアクセント、システム書体に刷新。 / Refreshed the neutral UI, restrained blue accents and system typography using Apple HIG branding principles.
