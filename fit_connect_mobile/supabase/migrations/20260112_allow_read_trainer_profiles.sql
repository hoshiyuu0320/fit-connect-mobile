-- トレーナーのプロフィールは誰でも読めるようにする
-- QRコード招待フローで、登録前のユーザーがトレーナー情報を確認できるようにするため

-- 既存のポリシーを削除
DROP POLICY IF EXISTS "プロフィール読み取りポリシー" ON public.profiles;

-- 新しいポリシーを作成
CREATE POLICY "プロフィール読み取りポリシー"
ON public.profiles
FOR SELECT
USING (
  -- 自分自身のプロフィール
  id = auth.uid()
  OR
  -- 自分のトレーナーのプロフィール
  id IN (
    SELECT trainer_id FROM public.clients WHERE client_id = auth.uid()
  )
  OR
  -- トレーナーのプロフィールは誰でも読める（登録フロー用）
  role = 'trainer'
);
