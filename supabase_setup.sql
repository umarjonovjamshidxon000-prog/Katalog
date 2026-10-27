-- Malika Print katalogi uchun Supabase sozlamasi
-- Supabase → SQL Editor → New query → shu matnni joylab "Run" bosing.

-- 1) Mahsulotlar jadvali
create table if not exists public.products (
  id          bigint generated always as identity primary key,
  name        text not null,
  category    text not null default 'Boshqa',
  price       text,
  description text,
  image_url   text,
  created_at  timestamptz not null default now()
);

alter table public.products enable row level security;

-- Hamma (mijozlar) faqat o'qiy oladi
drop policy if exists "Hamma o'qiydi" on public.products;
create policy "Hamma o'qiydi" on public.products
  for select using (true);

-- Faqat tizimga kirgan admin qo'shadi / o'zgartiradi / o'chiradi
drop policy if exists "Admin yozadi" on public.products;
create policy "Admin yozadi" on public.products
  for all to authenticated using (true) with check (true);

-- 2) Rasmlar uchun ochiq papka (bucket)
insert into storage.buckets (id, name, public)
values ('products', 'products', true)
on conflict (id) do nothing;

drop policy if exists "Rasmlarni hamma ko'radi" on storage.objects;
create policy "Rasmlarni hamma ko'radi" on storage.objects
  for select using (bucket_id = 'products');

drop policy if exists "Admin rasm yuklaydi" on storage.objects;
create policy "Admin rasm yuklaydi" on storage.objects
  for insert to authenticated with check (bucket_id = 'products');

drop policy if exists "Admin rasm o'zgartiradi" on storage.objects;
create policy "Admin rasm o'zgartiradi" on storage.objects
  for update to authenticated using (bucket_id = 'products');

drop policy if exists "Admin rasm o'chiradi" on storage.objects;
create policy "Admin rasm o'chiradi" on storage.objects
  for delete to authenticated using (bucket_id = 'products');
