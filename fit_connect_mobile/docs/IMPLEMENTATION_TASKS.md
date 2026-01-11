# FIT-CONNECT Mobile - 実装タスク一覧

**作成日**: 2025年12月30日
**バージョン**: 2.1
**進捗状況**: 全体 94% 完了
**最終更新**: 2026年1月11日 - UI日本語対応、達成率ロジック修正、ログイン画面レスポンシブ対応

---

## 目次

1. [実装状況サマリー](#実装状況サマリー)
2. [フェーズ別タスク一覧](#フェーズ別タスク一覧)
3. [データ層](#データ層)
4. [認証機能](#認証機能)
5. [メッセージ機能](#メッセージ機能)
6. [記録機能](#記録機能)
7. [目標管理](#目標管理)
8. [UI/UX](#uiux)
9. [インフラ・設定](#インフラ設定)
10. [テスト](#テスト)

---

## 実装状況サマリー

### 完了率

| カテゴリ | 進捗 | 状態 |
|---------|------|------|
| **UI/画面レイアウト** | 100% | 🟢 完了 |
| **データモデル** | 100% | 🟢 完了 |
| **Repositoryレイヤー** | 100% | 🟢 完了 |
| **Riverpod Provider** | 100% | 🟢 完了 |
| **Supabase統合** | 100% | 🟢 完了 |
| **Supabase Storage** | 100% | 🟢 完了 |
| **リアルタイム機能** | 90% | 🟡 進行中 |
| **Edge Functions** | 80% | 🟡 進行中 |
| **UIプレビュー関数** | 90% | 🟡 進行中 |
| **日本語対応** | 100% | 🟢 完了 |
| **テスト** | 0% | 🔴 未着手 |

### 完了済み項目

- ✅ プロジェクト構造・アーキテクチャ設計
- ✅ Material 3 テーマシステム
- ✅ カラーパレット定義
- ✅ Supabase Service 初期化
- ✅ 基本的な画面レイアウト（ホーム、メッセージ、記録）
- ✅ ボトムナビゲーション
- ✅ ログイン画面UI（レスポンシブ対応済み）
- ✅ 認証ルーティング
- ✅ データベースマイグレーション（RLSポリシー追加）
- ✅ データモデル作成（8ファイル）
- ✅ Repositoryレイヤー実装（5ファイル）
- ✅ Riverpodプロバイダー作成（7ファイル）
- ✅ **フェーズ1: データ基盤構築 完了**
- ✅ 体重記録画面の実データ接続（Riverpod統合）
- ✅ 食事記録画面の実データ接続（Riverpod統合）
- ✅ 期間フィルタ機能（PeriodFilter enum）
- ✅ UIプレビュー関数作成（meal_card, meal_summary_card, meal_record_screen）
- ✅ 運動記録画面の実データ接続（Riverpod統合）
- ✅ UIプレビュー関数作成（exercise_record_screen）
- ✅ ホーム画面の実データ接続（Riverpod統合）
- ✅ GoalCard・DailySummaryCardの実データ対応
- ✅ UIプレビュー関数作成（home_screen, daily_summary_card）
- ✅ DailySummaryCardセクション別ナビゲーション（Meals→食事タブ, Activity→運動タブ, Weight→体重タブ）
- ✅ タップエフェクト実装（InkWell ripple）
- ✅ RecordsScreenの初期タブ指定対応（initialTabIndex）
- ✅ 食事記録の週カレンダー実装（MealWeekCalendar）
- ✅ 食事記録の月カレンダー実装（MealMonthCalendar - GitHub草スタイル）
- ✅ 運動記録の週カレンダー実装（ExerciseWeekCalendar - アイコン表示）
- ✅ UIプレビュー関数作成（meal_week_calendar, meal_month_calendar, exercise_week_calendar）
- ✅ 体重記録のグラフ実装（fl_chart - 折れ線グラフ、目標体重点線、ツールチップ）
- ✅ UIプレビュー関数作成（weight_record_screen）
- ✅ メッセージリアルタイム機能実装（Supabase Realtime Stream）
- ✅ メッセージ画面のRiverpod統合（messagesStreamProvider）
- ✅ メッセージ送信機能実装（タグ自動解析付き）
- ✅ メッセージ自動スクロール機能（画面遷移時・新規メッセージ受信時）
- ✅ UIプレビュー関数作成（message_screen）
- ✅ Edge Functions実装（parse-message-tags - タグ解析・記録自動作成）
- ✅ Database Webhookトリガー設定（messages INSERT時にEdge Function起動）
- ✅ タグ候補UI実装（#入力時の候補表示、選択後のヒント表示）
- ✅ タグ入力バリデーション（タグのみ送信防止）
- ✅ 認証プロバイダーの無限ループバグ修正（tokenRefreshed対応）
- ✅ トレーナー名表示（RLSポリシー追加 - クライアントが自分のトレーナーのプロフィール取得可能）
- ✅ メッセージ画面のキーボード制御（入力欄以外タップで閉じる、タグ選択後フォーカス維持）
- ✅ リモートEdge Function URL修正（本番環境対応）
- ✅ **画像添付機能実装**
  - ✅ Supabase Storage バケット作成（message-photos）
  - ✅ StorageService実装（画像ピック・圧縮・アップロード）
  - ✅ ChatInputカメラボタン機能実装
  - ✅ 画像プレビューUI（削除ボタン付き）
  - ✅ アップロード中ローディング表示
  - ✅ iOSカメラ・フォトライブラリ権限設定
  - ✅ iOSローカライゼーション設定（日本語UI）
- ✅ **目標達成機能実装**
  - ✅ GoalAchievementProvider作成（達成状態監視）
  - ✅ GoalAchievementOverlay作成（Confettiアニメーション付きお祝いモーダル）
  - ✅ MainScreenに達成検知・お祝い表示ロジック追加
  - ✅ GoalCard達成時の特別表示（ゴールド背景、トロフィーアイコン）
  - ✅ UIプレビュー関数作成（GoalCard - In Progress / Achieved）
- ✅ **UI日本語対応（ローカライゼーション）**
  - ✅ GoalCard: 全ラベル日本語化（目標進捗、現在、目標、残り/達成/超過、達成率、期限）
  - ✅ WeightRecordScreen: 日本語化（現在、目標、残り/達成/超過、達成率、開始時比、体重推移、最近の記録）
  - ✅ DailySummaryCard: 日本語化（今日のまとめ、体重、食事、運動、今週、/7日、データなし）
  - ✅ 動的ラベル対応（残り/達成/超過 - 減量・増量両対応）
- ✅ **達成率ロジック修正**
  - ✅ GoalCard: 増量目標で逆方向（体重減少）の場合に正しく0%表示されるよう修正
  - ✅ 方向を考慮した進捗計算（減量: initial→target減少、増量: initial→target増加）
- ✅ **ログイン画面レスポンシブ対応**
  - ✅ iPhone 12 miniなど小さい端末でキーボード表示時のオーバーフロー修正
  - ✅ SingleChildScrollView + LayoutBuilder + ConstrainedBox対応

---

## フェーズ別タスク一覧

### 📌 フェーズ1: データ基盤構築（最優先）

**目的**: モックデータから実データへの移行基盤を整備

#### タスク

- [x] **1.1 データベースマイグレーション実行** ✅
  - [x] `clients` テーブルへのカラム追加（initial_weight, goal_deadline, goal_set_at, goal_achieved_at）
  - [x] `messages` テーブルのカラム名変更と追加（content, created_at, image_urls, tags, reply_to_message_id, edited_at）
  - [x] `meal_records` テーブルの更新（notes, source, message_id, created_at, updated_at）
  - [x] `weight_records` テーブルの更新（notes, source, message_id, created_at, updated_at）
  - [x] `exercise_records` テーブルの更新（source, message_id, images, created_at, updated_at）
  - [x] インデックス作成（パフォーマンス最適化）
  - [x] RLSポリシーの見直しと追加
  - ファイル: `supabase/migrations/20251230172037_add_client_policies.sql`

- [x] **1.2 データモデル作成（JSON Serializable）** ✅
  - [x] `lib/features/auth/models/user_model.dart` - ユーザー/プロフィールモデル
  - [x] `lib/features/auth/models/client_model.dart` - クライアント情報モデル
  - [x] `lib/features/weight_records/models/weight_record_model.dart`
  - [x] `lib/features/meal_records/models/meal_record_model.dart`
  - [x] `lib/features/exercise_records/models/exercise_record_model.dart`
  - [x] `lib/features/messages/models/message_model.dart`
  - [x] `lib/features/messages/models/tag_model.dart`
  - [x] `lib/shared/models/period_filter.dart` - 期間フィルタ用Enum
  - [x] `dart run build_runner build --delete-conflicting-outputs` 実行

- [x] **1.3 Repositoryレイヤー実装** ✅
  - [x] `lib/features/weight_records/data/weight_repository.dart`
  - [x] `lib/features/meal_records/data/meal_repository.dart`
  - [x] `lib/features/exercise_records/data/exercise_repository.dart`
  - [x] `lib/features/messages/data/message_repository.dart`
  - [x] `lib/features/goals/data/goal_repository.dart`
  - [x] Supabaseクエリロジックの実装

- [x] **1.4 Riverpodプロバイダー作成** ✅
  - [x] `lib/features/auth/providers/auth_provider.dart` - 認証状態管理
  - [x] `lib/features/auth/providers/current_user_provider.dart` - 現在のユーザー情報
  - [x] `lib/features/weight_records/providers/weight_records_provider.dart`
  - [x] `lib/features/meal_records/providers/meal_records_provider.dart`
  - [x] `lib/features/exercise_records/providers/exercise_records_provider.dart`
  - [x] `lib/features/messages/providers/messages_provider.dart`
  - [x] `lib/features/goals/providers/goal_provider.dart`
  - [x] `dart run build_runner build --delete-conflicting-outputs` 実行

**期待される成果**: 全画面が実際のSupabaseデータを表示できる状態 ✅ **フェーズ1完了！**

---

### 📌 フェーズ2: メッセージ機能（コア機能）

**目的**: アプリの最重要機能である「メッセージベースの記録作成」を実現

#### タスク

- [x] **2.1 基本メッセージ機能** ✅ 完了
  - [x] メッセージ送信処理の実装（lib/features/messages/presentation/screens/message_screen.dart）
  - [x] メッセージ受信のリアルタイム同期（Supabase Realtime Stream）
  - [x] メッセージ一覧の取得（messagesStreamProvider）
  - [x] 送信エラーハンドリング（SnackBar表示）
  - [x] 日付別グループ表示（今日/昨日/M月d日）
  - [x] 自動スクロール機能
    - [x] 画面遷移時に最新メッセージまでスムーズスクロール
    - [x] 新規メッセージ受信時に自動スクロール
    - [x] アニメーション付き（easeInOutCubic, 600ms）
  - [x] 画像添付機能（最大3枚）✅
    - [x] image_picker統合
    - [x] Supabase Storage へのアップロード
    - [x] 画像圧縮・リサイズ処理（最大1920x1080, 80%品質）
  - [ ] ページネーション（大量メッセージ対応）

- [x] **2.2 タグ機能実装** ✅ 完了
  - [x] タグ入力補助UI改善
    - [x] `#` 入力時の候補表示ロジック
    - [x] リアルタイムフィルタリング（#食 → 食事関連タグのみ）
    - [x] 1メッセージ1タグ制限のバリデーション
    - [x] タグ選択後のヒント表示（入力例）
  - [x] タグデータモデル定義
    - [x] カテゴリタグ: `#食事`, `#運動`, `#体重`
    - [x] 詳細タグ: `#食事:朝食`, `#運動:筋トレ` など
  - [x] メッセージ送信時のタグ保存

- [x] **2.3 Edge Functions作成** ✅ 基本実装完了
  - [x] `supabase/functions/parse-message-tags/index.ts`
    - [x] タグ解析ロジック（正規表現: `/#(食事|運動|体重)(?::(.+?))?(?:\s|$)/`）
    - [x] タグからメモ部分の抽出
    - [x] Database Webhook設定（messages INSERT時）
    - [x] 食事記録の自動作成（meal_records）
    - [x] 体重記録の自動作成（weight_records）+ 目標達成判定
    - [x] 運動記録の自動作成（exercise_records）+ カロリー抽出
  - [x] Edge Functionsのローカルテスト完了
  - [x] Edge Functionsのリモートデプロイ完了

- [ ] **2.4 リプライ機能**
  - [ ] メッセージ長押し → 返信メニュー表示
  - [ ] 引用表示付き入力欄
  - [ ] `reply_to_message_id` の保存
  - [ ] リプライ表示UI（ネストされた吹き出し）

- [ ] **2.5 メッセージ編集**
  - [ ] 5分以内の編集可能判定（Database Function: `can_edit_message`）
  - [ ] 編集UI（メッセージ長押し → 編集）
  - [ ] `edited_at` タイムスタンプ記録
  - [ ] タグ変更時の記録更新ロジック

- [ ] **2.6 既読機能（将来実装）**
  - [ ] `read_at` タイムスタンプ更新
  - [ ] 既読表示UI

**期待される成果**: メッセージ送信 → 自動的に体重/食事/運動記録が作成される

---

### 📌 フェーズ3: 記録機能の強化

**目的**: 各記録画面を実データと連携し、グラフ・統計表示を実装

#### タスク

- [x] **3.1 体重記録機能** ✅ 実装完了
  - [x] 実データ取得と表示（lib/features/weight_records/presentation/screens/weight_record_screen.dart）
  - [x] 期間フィルタ対応（今日/今週/今月/3ヶ月/全期間）
  - [x] 統計カード表示（基本）
  - [x] 記録一覧の時系列表示
  - [x] 折れ線グラフ実装（fl_chart使用）
    - [x] 体重推移を青い曲線で表示
    - [x] 目標体重を緑の点線で表示
    - [x] データポイントタップでツールチップ表示
    - [x] 縦軸の自動調整（最小・最大値±2kg）
  - [x] UIプレビュー関数作成
  - [ ] 統計カード拡張
    - [x] 開始時比（vs Start）
    - [ ] 前回比
    - [ ] 期間平均/最高/最低/変動幅
  - [ ] 体重記録詳細画面（オプション）

- [x] **3.2 食事記録機能** ✅ 実装完了
  - [x] 実データ取得と表示（lib/features/meal_records/presentation/screens/meal_record_screen.dart）
  - [x] 期間フィルタ（今日/今週/今月/3ヶ月/全期間）
  - [x] サマリーカード（食事数/写真数/カロリー）
  - [x] 記録一覧の日付グループ表示
  - [x] UIプレビュー関数作成
  - [x] 週カレンダー実装（MealWeekCalendar）
    - [x] 期間フィルタ「週」で表示
    - [x] 横一列7日表示（月曜日始まり）
    - [x] 食事数カウント表示
  - [x] 月カレンダー実装（MealMonthCalendar - GitHub草スタイル）
    - [x] 期間フィルタ「月」で表示
    - [x] 7列×複数行グリッド表示
    - [x] 記録数に応じた緑の濃淡（AppColors.grassLevel0-3使用）
    - [x] 3食: 濃い緑 #26A641
    - [x] 2食: 中くらいの緑 #39D353
    - [x] 1食: 薄い緑 #9BE9A8
    - [x] なし: グレー #EBEDF0
    - [x] 凡例表示
  - [ ] 食事タイプ別フィルタ
  - [ ] 画像表示とギャラリー

- [x] **3.3 運動記録機能** ✅ 実装完了
  - [x] 実データ取得と表示（lib/features/exercise_records/presentation/screens/exercise_record_screen.dart）
  - [x] 期間フィルタ対応（今日/今週/今月/3ヶ月/全期間）
  - [x] タイプフィルタ（すべて/筋トレ/有酸素）
  - [x] 統計サマリー（総回数/タイプ別回数）
  - [x] 記録一覧の日付グループ表示
  - [x] UIプレビュー関数作成
  - [x] 週間カレンダー実装（ExerciseWeekCalendar）
    - [x] 期間フィルタ「週」で表示
    - [x] 横一列7日表示（月曜日始まり）
    - [x] 💪 筋トレアイコン表示（strength_training）
    - [x] 🏃 有酸素アイコン表示（cardio/running/walking/cycling）
    - [x] AspectRatio使用で正方形セル
  - [ ] 画像表示

- [ ] **3.4 共通コンポーネント整理**
  - [ ] `lib/shared/widgets/period_filter_buttons.dart` - 期間フィルタボタン
  - [ ] `lib/shared/widgets/record_card.dart` - 記録カード共通ベース
  - [ ] `lib/shared/widgets/stat_card.dart` - 統計カード
  - [ ] `lib/shared/widgets/activity_calendar.dart` - アクティビティカレンダー

**期待される成果**: 全記録画面がグラフと統計を表示し、メッセージからの記録が反映される

---

### 📌 フェーズ4: 目標管理機能

**目的**: トレーナーが設定した目標の表示と達成判定を実装

#### タスク

- [x] **4.1 目標表示** ✅
  - [x] ホーム画面の目標カード実データ化（lib/features/home/presentation/widgets/goal_card.dart）
  - [x] 達成率計算ロジック実装
    - [x] Database Function: `calculate_achievement_rate(client_id, weight)` ✅ 既存
    - [x] 減量目標/増量目標の判定
    - [x] 達成率 = (開始時体重 - 現在の体重) / (開始時体重 - 目標体重) × 100
  - [x] 目標期日の表示（任意）
  - [ ] 目標詳細説明の表示（任意）

- [x] **4.2 目標達成判定** ✅
  - [x] Database Function: `check_goal_achievement(client_id, weight)` ✅ 既存
    - [x] 減量目標: currentWeight <= targetWeight
    - [x] 増量目標: currentWeight >= targetWeight
    - [x] 達成時に `clients.goal_achieved_at` を更新
  - [x] 体重記録作成トリガーでの自動判定（Edge Function内で実装済み）

- [x] **4.3 目標達成演出** ✅
  - [x] 目標達成オーバーレイ作成（lib/features/goals/presentation/widgets/goal_achievement_overlay.dart）
    - [x] トロフィーアイコン表示
    - [x] 「目標達成！」メッセージ
    - [x] 目標体重表示
    - [x] 「閉じる」ボタン
  - [x] 紙吹雪アニメーション実装（confettiパッケージ使用）
    - [x] 5秒間の演出
    - [x] スケールアニメーション付きカード表示
  - [x] GoalCard達成時の特別表示
    - [x] ゴールド背景のグラデーション
    - [x] トロフィーアイコン表示
    - [x] 100%バッジ表示
  - [ ] プッシュ通知送信（将来実装）
    - [ ] クライアントへの通知
    - [ ] トレーナーへの通知（Web側）

- [x] **4.4 ホーム画面「本日のサマリー」実データ化** ✅
  - [x] 食事記録数の取得（本日の記録数 / 3食）
  - [x] 運動記録数の取得（今週の運動回数 / 7日）
  - [x] 体重の最新データ取得
    - [x] 最新体重 + 週間変動表示
  - [x] セクション別ナビゲーション（各セクションタップで対応タブへ遷移）
  - [x] タップエフェクト（InkWell ripple）

**期待される成果**: 目標達成時に自動的に演出が表示され、モチベーション維持をサポート

---

### 📌 フェーズ5: 認証フロー強化

**目的**: QRコード招待とマジックリンクによる初回登録フローを完成

#### タスク

- [ ] **5.1 QRコード招待フロー**
  - [ ] オンボーディング画面作成（lib/features/auth/presentation/screens/onboarding_screen.dart）
    - [ ] アプリ概要スライド
    - [ ] 機能紹介
    - [ ] QRコードスキャンへの誘導
  - [ ] QRコードスキャン画面作成（lib/features/auth/presentation/screens/qr_scan_screen.dart）
    - [ ] カメラパーミッション処理
    - [ ] QRコード読み取り（qr_code_scannerパッケージ）
    - [ ] QRコードから`trainer_id`抽出
  - [ ] メールアドレス入力画面改善
    - [ ] トレーナー情報（名前・アイコン）表示
    - [ ] trainer_idを保持してメール認証へ

- [ ] **5.2 マジックリンク認証強化**
  - [ ] ディープリンク設定
    - [ ] iOS: Universal Links設定（ios/Runner/Info.plist）
    - [ ] Android: App Links設定（android/app/src/main/AndroidManifest.xml）
    - [ ] URLスキーム: `fitconnect://auth/callback`
  - [ ] 認証メール送信完了画面（lib/features/auth/presentation/screens/auth_email_sent_screen.dart）
    - [ ] 「メールを確認してください」メッセージ
    - [ ] メールアプリへのディープリンク
  - [ ] ディープリンクハンドリング（lib/app.dart）
    - [ ] リンクタップでアプリ起動
    - [ ] 認証トークン処理
    - [ ] プロフィール作成フロー

- [ ] **5.3 初回登録時のデータ作成**
  - [ ] `profiles` テーブルに role='client' でレコード作成
  - [ ] `clients` テーブルに trainer_id と紐付けてレコード作成
  - [ ] 登録完了画面作成（lib/features/auth/presentation/screens/registration_complete_screen.dart）
    - [ ] 紙吹雪アニメーション
    - [ ] トレーナー情報表示
    - [ ] 「トレーナーに報告」ボタン → メッセージ画面へ

- [ ] **5.4 セッション管理**
  - [ ] セッション保持期間: 6ヶ月設定確認
  - [ ] 自動トークンリフレッシュ確認
  - [ ] ログアウト機能実装

**期待される成果**: トレーナーがQRコードを表示 → クライアントがスキャン → メール認証 → 登録完了の全フローが動作

---

### 📌 フェーズ6: プッシュ通知

**目的**: メッセージ受信時や目標達成時にリアルタイム通知

#### タスク

- [ ] **6.1 Firebase設定確認**
  - [ ] iOS: `ios/Runner/GoogleService-Info.plist` 確認
  - [ ] Android: `android/app/google-services.json` 確認
  - [ ] Firebase Console でプロジェクト設定確認

- [ ] **6.2 NotificationService 有効化**
  - [ ] `lib/main.dart:15` のコメント解除
  - [ ] `lib/services/notification_service.dart` の実装確認
  - [ ] パーミッション処理
    - [ ] iOS: 通知許可ダイアログ
    - [ ] Android: 通知チャンネル設定
  - [ ] FCMトークン取得とSupabaseへの保存

- [ ] **6.3 通知ハンドリング**
  - [ ] フォアグラウンド通知表示
  - [ ] バックグラウンド通知ハンドリング
  - [ ] 通知タップ時のナビゲーション
    - [ ] メッセージ通知 → メッセージ画面
    - [ ] 目標達成通知 → 目標達成画面

- [ ] **6.4 Supabase Edge Function連携**
  - [ ] メッセージ送信時の通知送信（Edge Function）
  - [ ] 目標達成時の通知送信（Edge Function）

**期待される成果**: トレーナーからのメッセージや目標達成時にプッシュ通知が届く

---

## データ層

### データモデル（0% 完了）

#### 必須モデル

- [ ] **lib/features/auth/models/user_model.dart**
  ```dart
  @JsonSerializable()
  class User {
    final String id;
    final String? name;
    final String? email;
    final String role; // 'client' | 'trainer'
    final String? profileImageUrl;
    final DateTime createdAt;
  }
  ```

- [ ] **lib/features/auth/models/client_model.dart**
  ```dart
  @JsonSerializable()
  class Client {
    final String clientId;
    final String name;
    final String trainerId;
    final String? gender;
    final int? age;
    final double? height;
    final double? initialWeight;
    final double? targetWeight;
    final DateTime? goalDeadline;
    final String? goalDescription;
    final DateTime? goalSetAt;
    final DateTime? goalAchievedAt;
    final String? profileImageUrl;
    final DateTime createdAt;
  }
  ```

- [ ] **lib/features/weight_records/models/weight_record_model.dart**
  ```dart
  @JsonSerializable()
  class WeightRecord {
    final String id;
    final String clientId;
    final double weight;
    final String? notes;
    final DateTime recordedAt;
    final String source; // 'message' | 'manual'
    final String? messageId;
    final DateTime createdAt;
    final DateTime updatedAt;
  }
  ```

- [ ] **lib/features/meal_records/models/meal_record_model.dart**
  ```dart
  @JsonSerializable()
  class MealRecord {
    final String id;
    final String clientId;
    final String mealType; // 'breakfast' | 'lunch' | 'dinner' | 'snack'
    final String? notes;
    final List<String>? images;
    final double? calories;
    final DateTime recordedAt;
    final String source;
    final String? messageId;
    final DateTime createdAt;
    final DateTime updatedAt;
  }
  ```

- [ ] **lib/features/exercise_records/models/exercise_record_model.dart**
  ```dart
  @JsonSerializable()
  class ExerciseRecord {
    final String id;
    final String clientId;
    final String exerciseType; // 'strength_training' | 'cardio' | ...
    final String? memo;
    final List<String>? images;
    final int? duration;
    final double? calories;
    final DateTime recordedAt;
    final String source;
    final String? messageId;
    final DateTime createdAt;
    final DateTime updatedAt;
  }
  ```

- [ ] **lib/features/messages/models/message_model.dart**
  ```dart
  @JsonSerializable()
  class Message {
    final String id;
    final String senderId;
    final String receiverId;
    final String content;
    final List<String>? imageUrls;
    final List<String>? tags;
    final String? replyToMessageId;
    final DateTime createdAt;
    final DateTime? readAt;
    final DateTime? editedAt;
    final bool isEdited;
    final DateTime updatedAt;
  }
  ```

- [ ] **lib/features/messages/models/tag_model.dart**
  ```dart
  class TagData {
    final String category; // '食事' | '運動' | '体重'
    final String? detail; // '朝食' | '筋トレ' など
    final String fullTag; // '#食事:朝食'
  }
  ```

#### 共有モデル

- [ ] **lib/shared/models/period_filter.dart**
  ```dart
  enum PeriodFilter {
    today,
    week,
    month,
    threeMonths,
    all,
  }
  ```

### Riverpodプロバイダー（0% 完了）

#### 認証プロバイダー

- [ ] **lib/features/auth/providers/auth_provider.dart**
  ```dart
  @riverpod
  class AuthNotifier extends _$AuthNotifier {
    @override
    Future<User?> build() async {
      // 認証状態の初期化
    }

    Future<void> signInWithEmail(String email) async { }
    Future<void> signOut() async { }
  }
  ```

- [ ] **lib/features/auth/providers/current_user_provider.dart**
  ```dart
  @riverpod
  Future<Client?> currentClient(CurrentClientRef ref) async {
    // 現在のクライアント情報取得
  }
  ```

#### 記録プロバイダー

- [ ] **lib/features/weight_records/providers/weight_records_provider.dart**
  ```dart
  @riverpod
  class WeightRecords extends _$WeightRecords {
    @override
    Future<List<WeightRecord>> build(PeriodFilter period) async {
      // 体重記録取得
    }
  }

  @riverpod
  Future<WeightRecord?> latestWeightRecord(LatestWeightRecordRef ref) async {
    // 最新の体重記録
  }
  ```

- [ ] **lib/features/meal_records/providers/meal_records_provider.dart**

- [ ] **lib/features/exercise_records/providers/exercise_records_provider.dart**

#### メッセージプロバイダー

- [ ] **lib/features/messages/providers/messages_provider.dart**
  ```dart
  @riverpod
  class Messages extends _$Messages {
    @override
    Stream<List<Message>> build(String trainerId) {
      // Supabase Realtimeストリーム
    }

    Future<void> sendMessage(String content, List<String>? imageUrls, List<String>? tags) async { }
    Future<void> editMessage(String messageId, String newContent) async { }
  }
  ```

#### 目標プロバイダー

- [ ] **lib/features/goals/providers/goal_provider.dart**
  ```dart
  @riverpod
  Future<Client?> currentGoal(CurrentGoalRef ref) async {
    // 現在の目標取得（clientsテーブルから）
  }

  @riverpod
  Future<double> achievementRate(AchievementRateRef ref) async {
    // 達成率計算
  }
  ```

---

## 認証機能

### 未実装タスク

- [ ] **QRコードスキャン機能**
  - パッケージ: `qr_code_scanner` or `mobile_scanner`
  - 画面: `lib/features/auth/presentation/screens/qr_scan_screen.dart`
  - カメラパーミッション処理

- [ ] **オンボーディング画面**
  - 初回起動時のみ表示
  - アプリの使い方説明
  - QRスキャンへの誘導

- [ ] **トレーナー情報表示**
  - QRコード読み取り後、メールアドレス入力画面でトレーナー情報を表示
  - トレーナー名とアイコン取得（Supabase）

- [ ] **ディープリンク設定**
  - iOS: Universal Links（Info.plist設定）
  - Android: App Links（AndroidManifest.xml設定）
  - URLスキーム: `fitconnect://auth/callback`

- [ ] **プロフィール自動作成**
  - 認証完了後、`profiles` テーブルに自動挿入
  - `clients` テーブルに trainer_id 紐付け
  - Database Trigger or Edge Function

- [ ] **登録完了演出**
  - 紙吹雪アニメーション（confettiパッケージ）
  - 画面: `lib/features/auth/presentation/screens/registration_complete_screen.dart`

- [ ] **セッション管理強化**
  - 6ヶ月保持の確認
  - リフレッシュトークンハンドリング
  - ログアウト機能

- [ ] **LINE連携（将来実装）**
  - LINE Login SDK統合
  - Supabase Auth with OAuth

---

## メッセージ機能

### 未実装タスク

#### 基本機能

- [ ] **メッセージ送信処理**
  - 現在の実装: lib/features/messages/presentation/screens/message_screen.dart:204
  - Supabase insertクエリ実装
  - エラーハンドリング

- [ ] **リアルタイム同期**
  - Supabase Realtime ストリーム購読
  - メッセージ受信時の自動更新
  - スクロール位置の自動調整

- [ ] **画像添付**
  - image_pickerでギャラリー/カメラ選択
  - 最大3枚の制限
  - 画像圧縮・リサイズ（1920x1080, 80%品質）
  - Supabase Storage アップロード
  - アップロード進捗表示

- [ ] **既読機能（後回し）**
  - `read_at` タイムスタンプ更新
  - 既読表示UI

#### タグ機能

- [ ] **タグ入力補助改善**
  - 現在: lib/features/messages/presentation/widgets/chat_input.dart:173
  - `#` 入力時の動的候補表示
  - フィルタリングロジック強化
  - キーボードショートカット

- [ ] **タグバリデーション**
  - 1メッセージ1タグ制限
  - 複数タグ検出時のエラー表示
  - タグフォーマットチェック

- [ ] **タグ候補の完全実装**
  ```dart
  final tagSuggestions = {
    '#食事:朝食', '#食事:昼食', '#食事:夕食', '#食事:間食',
    '#運動:筋トレ', '#運動:有酸素',
    '#体重',
  };
  ```

#### Edge Functions（タグ解析と記録作成）

- [ ] **supabase/functions/parse-message-tags/index.ts**
  - Database Webhook設定（messages INSERT時）
  - タグ解析ロジック
  - 対応するEdge Functionへのルーティング

- [ ] **supabase/functions/create-meal-record/index.ts**
  - 食事タイプマッピング: 朝食→breakfast, 昼食→lunch, 夕食→dinner, 間食→snack
  - meal_recordsテーブルへINSERT
  - message_id, source='message'設定

- [ ] **supabase/functions/create-weight-record/index.ts**
  - 体重値抽出（正規表現: `/(\d+\.?\d*)\s*kg?/`）
  - weight_recordsテーブルへINSERT
  - 目標達成判定（check_goal_achievement関数呼び出し）

- [ ] **supabase/functions/create-exercise-record/index.ts**
  - 運動タイプマッピング: 筋トレ→strength_training, 有酸素→cardio
  - exercise_recordsテーブルへINSERT

#### リプライ機能

- [ ] **リプライUI実装**
  - メッセージ長押し → コンテキストメニュー表示
  - 「返信」メニュー項目
  - 引用表示付き入力欄

- [ ] **リプライデータ保存**
  - `reply_to_message_id` フィールドへの保存
  - ネストされた表示ロジック

#### メッセージ編集

- [ ] **編集可能期間判定**
  - Database Function: `can_edit_message(message_id UUID) RETURNS boolean`
  - 送信後5分以内のチェック

- [ ] **編集UI**
  - メッセージ長押し → 編集メニュー
  - インライン編集フォーム
  - 「編集済み」バッジ表示

- [ ] **タグ変更時の記録更新**
  - 編集前後のタグ比較
  - タグ削除 → 記録削除
  - タグ追加 → 新規記録作成
  - タグ変更 → 記録更新

---

## 記録機能

### 体重記録（95% 完了）

- [x] **実データ接続**
  - Riverpod Provider統合完了
  - 期間フィルタ対応（今日/今週/今月/3ヶ月/全期間）
  - 記録一覧の時系列表示

- [x] **グラフ実装（fl_chart）**
  - [x] LineChart ウィジェット実装（lib/features/weight_records/presentation/screens/weight_record_screen.dart:252-377）
  - [x] 体重推移を青い曲線で表示（isCurved: true）
  - [x] 目標体重の緑の点線表示（dashArray: [5, 5]）
  - [x] データポイントのタップ処理（ツールチップ表示）
  - [x] 縦軸の自動調整（最小・最大値±2kg）
  - [x] グラデーション表示（belowBarData）
  - [x] UIプレビュー関数作成

- [x] **統計カード基本実装**
  - [x] 開始時比（vs Start）

- [ ] **統計カード拡張**
  - [ ] 前回比: 計算ロジック実装
  - [ ] 期間平均/最高/最低/変動幅

### 食事記録（90% 完了）

- [x] **実データ接続**
  - Riverpod Provider統合完了
  - 期間フィルタ対応
  - サマリーカード（食事数/写真数/カロリー）
  - 記録一覧の日付グループ表示
  - UIプレビュー関数作成

- [x] **カレンダー実装**
  - [x] 週カレンダー（MealWeekCalendar）作成
    - 横一列7日表示、食事数カウント
  - [x] 月カレンダー（MealMonthCalendar - GitHub草スタイル）作成
    - 7列グリッド、記録数に応じた色分け（grassLevel0-3）
    - 凡例表示
  - [x] 期間フィルタに応じた表示切り替え
  - [x] 日付タップで詳細表示（onDayTapコールバック）

- [ ] **カロリー表示（将来実装）**
  - AI算出機能との連携
  - 栄養素情報表示

- [ ] **画像ギャラリー**
  - 食事画像のグリッド表示
  - フルスクリーン表示

### 運動記録（90% 完了）

- [x] **実データ接続**
  - Riverpod Provider統合完了
  - 期間フィルタ対応（今日/今週/今月/3ヶ月/全期間）
  - タイプフィルタ（すべて/筋トレ/有酸素）
  - 統計サマリー（総回数/タイプ別回数）
  - 記録一覧の日付グループ表示
  - UIプレビュー関数作成

- [x] **週間カレンダー実装（ExerciseWeekCalendar）**
  - [x] アイコン表示（💪筋トレ, 🏃有酸素）
  - [x] 期間フィルタ「週」で表示切り替え
  - [x] 優先度ロジック（筋トレ優先→有酸素）
  - [x] 正方形セル（AspectRatio使用）
  - [x] 今日のハイライト表示

- [ ] **運動時間・カロリー（将来実装）**
  - duration, caloriesフィールド活用

---

## 目標管理

### 実装状況（80% 完了）

- [x] **Database Functions作成** ✅ 既存
  ```sql
  -- 目標達成判定
  CREATE OR REPLACE FUNCTION check_goal_achievement(
    p_client_id UUID,
    p_weight NUMERIC
  ) RETURNS BOOLEAN AS $$
  DECLARE
    v_initial_weight NUMERIC;
    v_target_weight NUMERIC;
    v_is_achieved BOOLEAN;
  BEGIN
    SELECT initial_weight, target_weight
    INTO v_initial_weight, v_target_weight
    FROM clients
    WHERE client_id = p_client_id;

    IF v_initial_weight > v_target_weight THEN
      v_is_achieved := p_weight <= v_target_weight;
    ELSE
      v_is_achieved := p_weight >= v_target_weight;
    END IF;

    IF v_is_achieved THEN
      UPDATE clients
      SET goal_achieved_at = NOW()
      WHERE client_id = p_client_id;
    END IF;

    RETURN v_is_achieved;
  END;
  $$ LANGUAGE plpgsql;

  -- 達成率計算
  CREATE OR REPLACE FUNCTION calculate_achievement_rate(
    p_client_id UUID,
    p_current_weight NUMERIC
  ) RETURNS NUMERIC AS $$
  DECLARE
    v_initial_weight NUMERIC;
    v_target_weight NUMERIC;
    v_rate NUMERIC;
  BEGIN
    SELECT initial_weight, target_weight
    INTO v_initial_weight, v_target_weight
    FROM clients
    WHERE client_id = p_client_id;

    IF v_initial_weight = v_target_weight THEN
      RETURN 100;
    END IF;

    v_rate := (v_initial_weight - p_current_weight) /
              (v_initial_weight - v_target_weight) * 100;

    RETURN GREATEST(0, LEAST(100, v_rate));
  END;
  $$ LANGUAGE plpgsql;
  ```

- [x] **目標達成オーバーレイ** ✅
  - ファイル: lib/features/goals/presentation/widgets/goal_achievement_overlay.dart
  - トロフィーアイコン（Lucide Icons: `trophy`）
  - 目標体重表示
  - 「閉じる」ボタン

- [x] **紙吹雪アニメーション** ✅
  - confettiパッケージ統合済み
  - 5秒間の演出
  - スケールアニメーション付きカード表示

- [x] **GoalCard達成時の特別表示** ✅
  - ゴールド背景のグラデーション
  - トロフィーアイコン表示
  - 100%バッジ表示

- [ ] **プッシュ通知送信**（将来実装）
  - Edge Function: `supabase/functions/notify-goal-achievement/index.ts`
  - FCM経由でクライアントへ通知
  - Web側（トレーナー）への通知

- [ ] **目標更新機能（トレーナー側）**
  - Web管理画面での実装（本アプリの範囲外）
  - 上書き更新（履歴なし）
  - 達成フラグのクリア

---

## UI/UX

### 未実装タスク

- [ ] **ダークモード対応（後回し）**
  - テーマ切り替え機能
  - ダークカラーパレット定義

- [ ] **ローディング状態表示**
  - AsyncValueのloadingハンドリング
  - スケルトンローダー
  - プログレスインジケーター

- [ ] **エラーハンドリングUI**
  - AsyncValueのerrorハンドリング
  - エラーメッセージ表示（SnackBar）
  - リトライボタン

- [ ] **オフライン対応（将来実装）**
  - ローカルキャッシュ
  - オフライン時のUI表示
  - 同期機能

- [ ] **画像表示の最適化**
  - キャッシュ処理（cached_network_imageパッケージ）
  - プレースホルダー表示
  - 遅延ロード

- [ ] **アニメーション強化**
  - ページ遷移アニメーション
  - リスト項目のフェードイン
  - 目標達成時の演出

- [ ] **アクセシビリティ対応**
  - スクリーンリーダー対応
  - フォントサイズ調整
  - ハイコントラストモード

---

## インフラ・設定

### データベース

- [ ] **マイグレーション実行**
  - 要件定義書「6.2 追加・変更が必要なカラム」を参照
  - ファイル: `supabase/migrations/YYYYMMDDHHMMSS_update_tables_for_client_app.sql`
  - ローカル実行: `cd supabase && supabase migration up`
  - 本番適用: Supabase Dashboard

- [ ] **インデックス作成**
  ```sql
  -- messagesテーブル
  CREATE INDEX idx_messages_sender_created ON messages(sender_id, created_at DESC);
  CREATE INDEX idx_messages_receiver_created ON messages(receiver_id, created_at DESC);
  CREATE INDEX idx_messages_reply_to ON messages(reply_to_message_id);
  CREATE INDEX idx_messages_tags ON messages USING GIN(tags);

  -- recordsテーブル
  CREATE INDEX idx_meal_records_message ON meal_records(message_id);
  CREATE INDEX idx_meal_records_client_date ON meal_records(client_id, recorded_at DESC);
  CREATE INDEX idx_weight_records_message ON weight_records(message_id);
  CREATE INDEX idx_weight_records_client_date ON weight_records(client_id, recorded_at DESC);
  CREATE INDEX idx_exercise_records_message ON exercise_records(message_id);
  CREATE INDEX idx_exercise_records_client_date ON exercise_records(client_id, recorded_at DESC);
  ```

- [ ] **RLSポリシー追加・更新**
  - messagesテーブルのポリシー（編集は5分以内）
  - 各recordsテーブルのポリシー（クライアントは自分のデータのみ）

- [ ] **Database Triggers設定**
  - messages INSERT時のWebhook（Edge Function起動）
  - weight_records INSERT時の目標達成判定

### Supabase Storage

- [ ] **バケット作成**
  - `meal-photos`: 食事写真用（public）
  - `exercise-photos`: 運動写真用（public）
  - `profile-images`: プロフィール画像用（public）

- [ ] **ストレージポリシー設定**
  - クライアントは自分のファイルのみアップロード可能
  - 全ユーザーが読み取り可能（public）

### Edge Functions

- [ ] **Edge Functionsデプロイ**
  ```bash
  supabase functions deploy parse-message-tags
  supabase functions deploy create-meal-record
  supabase functions deploy create-weight-record
  supabase functions deploy create-exercise-record
  supabase functions deploy notify-goal-achievement
  ```

- [ ] **環境変数設定**
  - Supabase Service Role Key（Edge Functions用）
  - FCM Server Key（通知用）

### Firebase

- [ ] **Firebase設定ファイル確認**
  - iOS: `ios/Runner/GoogleService-Info.plist`
  - Android: `android/app/google-services.json`

- [ ] **Firebase Consoleでの設定**
  - プロジェクト作成（既存の場合は確認）
  - iOS アプリ追加（Bundle ID: com.fitconnect.mobile）
  - Android アプリ追加（Package name: com.fitconnect.mobile）
  - Cloud Messaging 有効化

### ディープリンク

- [ ] **iOS設定**
  ```xml
  <!-- ios/Runner/Info.plist -->
  <key>CFBundleURLTypes</key>
  <array>
    <dict>
      <key>CFBundleURLSchemes</key>
      <array>
        <string>fitconnect</string>
      </array>
    </dict>
  </array>
  ```

- [ ] **Android設定**
  ```xml
  <!-- android/app/src/main/AndroidManifest.xml -->
  <intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="fitconnect" android:host="auth" />
  </intent-filter>
  ```

---

## テスト

### 未実装タスク（0% 完了）

- [ ] **ユニットテスト**
  - [ ] モデルのシリアライゼーションテスト
  - [ ] Repositoryのテスト（モック使用）
  - [ ] プロバイダーロジックのテスト
  - [ ] タグ解析ロジックのテスト
  - [ ] 達成率計算のテスト

- [ ] **ウィジェットテスト**
  - [ ] 各画面のレンダリングテスト
  - [ ] ボタンタップ動作テスト
  - [ ] フォームバリデーションテスト

- [ ] **統合テスト**
  - [ ] ログインフローのE2Eテスト
  - [ ] メッセージ送信フローのテスト
  - [ ] 記録作成フローのテスト

- [ ] **Edge Functionsのテスト**
  - [ ] タグ解析の各パターンテスト
  - [ ] 記録作成の正常系・異常系テスト

---

## 優先順位マトリクス

### 🔴 最優先（MVP必須）

1. データモデル作成（@JsonSerializable）
2. Riverpodプロバイダー実装
3. DBマイグレーション実行
4. メッセージのリアルタイム同期
5. Edge Functions（タグ解析・記録作成）
6. 体重記録のグラフ表示
7. 目標達成判定ロジック

### 🟡 高優先（MVP含める）

8. QRコード招待フロー
9. 食事記録のカレンダー表示
10. 運動記録の週間カレンダー
11. プッシュ通知（基本機能）
12. リプライ機能
13. メッセージ編集（5分制限）
14. 目標達成演出（紙吹雪）

### 🟢 中優先（MVP後のアップデート）

15. 既読機能
16. LINE連携
17. ダークモード
18. 画像最適化・キャッシュ
19. エラーハンドリング強化
20. ローディング状態の改善

### ⚪ 低優先（将来実装）

21. カロリー自動算出（AI）
22. 栄養素情報表示
23. オフライン対応
24. データエクスポート
25. 複数目標対応
26. 運動時間・カロリー追跡
27. メッセージ検索

---

## 次のアクション

### 推奨開始順序

~~1. **DBマイグレーション実行** → `supabase/migrations/` 確認・作成~~ ✅ 完了
~~2. **データモデル一括作成** → 全モデルファイル作成 → build_runner実行~~ ✅ 完了
~~3. **Riverpodプロバイダー作成** → 体重記録から開始（最もシンプル）~~ ✅ 完了
~~4. **体重記録画面の実データ化** → モックデータ削除 → Supabase統合~~ ✅ 完了
~~5. **食事記録画面の実データ化** → Riverpod統合~~ ✅ 完了

### 次に取り組むべきタスク

~~6. **運動記録画面の実データ化** → 体重・食事と同様にRiverpod統合~~ ✅ 完了
~~6.5. **ホーム画面完成** → DailySummaryCardセクション別ナビゲーション + タップエフェクト~~ ✅ 完了
~~6.6. **カレンダー実装** → 食事記録（週・月）、運動記録（週）のカレンダー表示~~ ✅ 完了
~~7. **グラフ実装** → fl_chartで体重折れ線グラフ~~ ✅ 完了
~~8. **メッセージリアルタイム機能** → Supabase Realtime統合~~ ✅ 完了

### 次に取り組むべきタスク

~~9. **Edge Functions作成** → タグ解析と記録作成の自動化~~ ✅ 完了
~~12. **画像添付機能** → image_picker + Supabase Storage~~ ✅ 完了
~~10. **目標達成機能** → Database Function + 達成画面 + 演出~~ ✅ 完了
11. **統計カード拡張** → 前回比、期間平均/最高/最低/変動幅
13. **リプライ機能** → メッセージ長押しで返信、引用表示
14. **メッセージ編集** → 5分以内の編集可能判定
15. **ページネーション** → 大量メッセージ対応

---

## 参考リンク

- [Supabase公式ドキュメント](https://supabase.com/docs)
- [Flutter公式ドキュメント](https://flutter.dev/docs)
- [Riverpod公式ドキュメント](https://riverpod.dev/)
- [fl_chart公式ドキュメント](https://pub.dev/packages/fl_chart)
- [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging)

---

**最終更新**: 2026年1月11日 - UI日本語対応、達成率ロジック修正、ログイン画面レスポンシブ対応（v2.1）
