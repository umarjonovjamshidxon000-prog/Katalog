# Malika Print katalogi — o'rnatish yo'riqnomasi

Fayllar:
- `index.html` — katalogning o'zi (mijozlar va admin panel)
- `supabase_setup.sql` — baza va rasm papkasini yaratadigan buyruqlar
- `bot_katalog_tugmasi.py` — botga "Katalog" tugmasini qo'shish

Hozir `index.html` **demo rejimda** ishlaydi: brauzerda ochsangiz namunaviy mahsulotlar chiqadi.
Admin panelni sinash uchun manzil oxiriga `?admin=1` qo'shing.

---

## 1-qadam. Supabase (bepul baza)
1. https://supabase.com saytida ro'yxatdan o'ting (GitHub bilan kirish qulay).
2. **New project** → nom: `malika-katalog`, parol o'ylab toping, region: **Frankfurt (eu-central)**.
3. Loyiha ochilgach: chap menyuda **SQL Editor** → **New query** → `supabase_setup.sql` ichidagi hamma matnni joylang → **Run**.

## 2-qadam. Admin akkaunt
1. **Authentication → Users → Add user → Create new user**.
2. Email va parol kiriting, **Auto Confirm User** belgisini yoqing.
3. **Authentication → Sign In / Providers** bo'limida **Allow new users to sign up** ni **o'chiring**
   (shunda boshqa hech kim admin bo'lib ro'yxatdan o'ta olmaydi).

## 3-qadam. Kalitlarni `index.html` ga yozish
Supabase'da **Project Settings → API** (yoki **Data API**) bo'limidan oling:
- **Project URL** → `SUPABASE_URL`
- **anon public** kalit → `SUPABASE_ANON_KEY`

`index.html` ichidagi `CONFIG` qismini to'ldiring:
```js
ADMIN_TELEGRAM_IDS: [123456789],
SUPABASE_URL: "https://xxxx.supabase.co",
SUPABASE_ANON_KEY: "eyJhbGciOi...",
```
> `anon` kalitni saytga yozish xavfsiz — u faqat o'qishga ruxsat beradi. Yozish uchun admin parol bilan kirishi shart.
> **service_role** kalitni hech qachon saytga yozmang!

**Telegram ID raqamingizni bilish:** Telegramda `@userinfobot` ga /start yozing — u `Id: 123456789` ni ko'rsatadi.

## 4-qadam. Saytni internetga joylash (GitHub Pages, bepul)
1. https://github.com da akkaunt oching → **New repository** → nom: `malika-katalog`, **Public**.
2. **Add file → Upload files** → `index.html` ni yuklang → **Commit**.
3. **Settings → Pages** → Source: **Deploy from a branch**, Branch: `main` / `(root)` → **Save**.
4. 1–2 daqiqadan keyin havola chiqadi: `https://LOGIN.github.io/malika-katalog/`

## 5-qadam. Botga ulash
**Kodsiz usul (eng tezi):** `@BotFather` → `/mybots` → botingiz → **Bot Settings → Menu Button** → havolani yuboring, tugma nomi: `Katalog`.

**Kod orqali:** `bot_katalog_tugmasi.py` dagi `CATALOG_URL` ga havolani yozing va router'ni botingizga ulang.

---

## Kundalik foydalanish
1. Botda **Katalog** ni oching — sizga **+** tugmasi va kartochkalarda ✏️ belgisi ko'rinadi (mijozlarga ko'rinmaydi).
2. Birinchi marta email/parol so'raydi — keyin eslab qoladi.
3. **+** → rasm tanlang, nom, bo'lim, narx, tavsif yozing → **Saqlash**. Mahsulot darhol hammaga ko'rinadi.
4. Bo'lim (kategoriya) uchun yangi nom yozsangiz — yangi bo'lim avtomatik paydo bo'ladi.

Rasmlar yuklashdan oldin avtomatik kichraytiriladi (1280 px), shuning uchun telefon kamerasidan to'g'ridan-to'g'ri yuklasangiz ham bo'ladi.
