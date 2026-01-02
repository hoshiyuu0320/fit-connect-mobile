-- クライアントが自分のトレーナーのプロフィールを取得できるようにする
CREATE POLICY "クライアントは自分のトレーナーのプロフィールを取得可"
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
);

-- 既存のSELECTポリシーを削除（新しいポリシーに統合）
DROP POLICY IF EXISTS "ユーザー自身のプロフィールのみ取得可" ON public.profiles;
