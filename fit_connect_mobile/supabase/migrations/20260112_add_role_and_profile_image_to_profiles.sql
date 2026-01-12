-- profilesテーブルにroleとprofile_image_urlカラムを追加
-- QRコード招待フロー対応のため

-- roleカラム追加（trainer/client）
ALTER TABLE "public"."profiles"
ADD COLUMN IF NOT EXISTS "role" TEXT;

COMMENT ON COLUMN "public"."profiles"."role" IS 'User role: trainer or client';

-- profile_image_urlカラム追加
ALTER TABLE "public"."profiles"
ADD COLUMN IF NOT EXISTS "profile_image_url" TEXT;

COMMENT ON COLUMN "public"."profiles"."profile_image_url" IS 'URL of the user profile image';

-- 既存のトレーナーのroleを更新（clientsテーブルに紐づくtrainer_idを持つユーザー）
UPDATE "public"."profiles" p
SET role = 'trainer'
WHERE EXISTS (
    SELECT 1 FROM "public"."clients" c
    WHERE c.trainer_id = p.id
)
AND p.role IS NULL;

-- 既存のクライアントのroleを更新（clientsテーブルにclient_idとして存在するユーザー）
UPDATE "public"."profiles" p
SET role = 'client'
WHERE EXISTS (
    SELECT 1 FROM "public"."clients" c
    WHERE c.client_id = p.id
)
AND p.role IS NULL;
