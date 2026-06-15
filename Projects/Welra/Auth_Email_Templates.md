---
title: Welra Auth Email Templates
project: Welra
type: reference
updated: 2026-06-12
tags: [welra, brand, email, supabase, auth]
---

# Supabase Auth Email Templates — Welra branded

Paste into Supabase Dashboard → Authentication → Emails → Templates (requires custom SMTP enabled).
Palette per [[Projects/Welra/Brand_Identity]]: ink `#0F1E33`, radar teal `#2FD6A6` (button fill, ink text), paper `#F7F9FB`.
Claude applies these via Chrome once SMTP is saved.

## Shared shell
Every template uses the same wrapper: paper background, white card, ink wordmark header, teal button with ink text, gray footer. 
**2026-06-12 link format change — do not revert to `{{ .ConfirmationURL }}`.** ConfirmationURL produces PKCE links that only work in the exact browser profile where the user typed the form (the code-verifier cookie lives there); opening the email on a phone, in another browser, or via a mail app breaks every link with "confirmation_failed". All action links now use `{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=...&next=...` — verified server-side by the web app's /auth/callback (verifyOtp), works from any device. Reauthentication (#6) still uses the `{{ .Token }}` code, unchanged.

## 1. Confirm sign up
**Subject:** `Confirm your email — Welra`
```html
<div style="background:#F7F9FB;padding:32px 20px;font-family:-apple-system,'Segoe UI',sans-serif;">
  <div style="max-width:480px;margin:0 auto;">
    <div style="text-align:center;margin-bottom:24px;">
      <span style="font-size:22px;font-weight:700;letter-spacing:-0.5px;color:#0F1E33;">Welra</span>
    </div>
    <div style="background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;padding:32px;">
      <h2 style="font-size:20px;font-weight:700;color:#0F1E33;margin:0 0 12px 0;">Confirm your email</h2>
      <p style="font-size:15px;line-height:1.6;color:#374151;margin:0 0 24px 0;">Welcome to Welra — one plain-English report on your business, every Monday. Confirm your email address to finish setting up your account.</p>
      <a href="{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=signup&next=/dashboard" style="display:inline-block;background:#2FD6A6;color:#0F1E33;font-weight:600;font-size:15px;padding:12px 24px;border-radius:8px;text-decoration:none;">Confirm email</a>
      <p style="font-size:13px;line-height:1.6;color:#9CA3AF;margin:24px 0 0 0;">Button not working? Paste this link into your browser:<br><a href="{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=signup&next=/dashboard" style="color:#0FA47C;word-break:break-all;">{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=signup&next=/dashboard</a></p>
    </div>
    <div style="text-align:center;font-size:12px;color:#9CA3AF;margin-top:20px;line-height:1.6;">
      Welra · GR3NB LLC · <a href="https://welra.io" style="color:#9CA3AF;">welra.io</a><br>
      If you didn't create a Welra account, you can safely ignore this email.
    </div>
  </div>
</div>
```

## 2. Invite user
**Subject:** `You've been invited to Welra`
```html
<div style="background:#F7F9FB;padding:32px 20px;font-family:-apple-system,'Segoe UI',sans-serif;">
  <div style="max-width:480px;margin:0 auto;">
    <div style="text-align:center;margin-bottom:24px;">
      <span style="font-size:22px;font-weight:700;letter-spacing:-0.5px;color:#0F1E33;">Welra</span>
    </div>
    <div style="background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;padding:32px;">
      <h2 style="font-size:20px;font-weight:700;color:#0F1E33;margin:0 0 12px 0;">You're invited</h2>
      <p style="font-size:15px;line-height:1.6;color:#374151;margin:0 0 24px 0;">You've been invited to Welra — one plain-English report on your business, every Monday. Accept the invite to create your account.</p>
      <a href="{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=invite&next=/dashboard" style="display:inline-block;background:#2FD6A6;color:#0F1E33;font-weight:600;font-size:15px;padding:12px 24px;border-radius:8px;text-decoration:none;">Accept invite</a>
      <p style="font-size:13px;line-height:1.6;color:#9CA3AF;margin:24px 0 0 0;">Button not working? Paste this link into your browser:<br><a href="{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=invite&next=/dashboard" style="color:#0FA47C;word-break:break-all;">{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=invite&next=/dashboard</a></p>
    </div>
    <div style="text-align:center;font-size:12px;color:#9CA3AF;margin-top:20px;line-height:1.6;">
      Welra · GR3NB LLC · <a href="https://welra.io" style="color:#9CA3AF;">welra.io</a><br>
      If you weren't expecting this invitation, you can safely ignore this email.
    </div>
  </div>
</div>
```

## 3. Magic link or OTP
**Subject:** `Your Welra sign-in link`
```html
<div style="background:#F7F9FB;padding:32px 20px;font-family:-apple-system,'Segoe UI',sans-serif;">
  <div style="max-width:480px;margin:0 auto;">
    <div style="text-align:center;margin-bottom:24px;">
      <span style="font-size:22px;font-weight:700;letter-spacing:-0.5px;color:#0F1E33;">Welra</span>
    </div>
    <div style="background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;padding:32px;">
      <h2 style="font-size:20px;font-weight:700;color:#0F1E33;margin:0 0 12px 0;">Sign in to Welra</h2>
      <p style="font-size:15px;line-height:1.6;color:#374151;margin:0 0 24px 0;">Click the button below to sign in. This link expires shortly and can only be used once.</p>
      <a href="{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=magiclink&next=/dashboard" style="display:inline-block;background:#2FD6A6;color:#0F1E33;font-weight:600;font-size:15px;padding:12px 24px;border-radius:8px;text-decoration:none;">Sign in</a>
      <p style="font-size:13px;line-height:1.6;color:#9CA3AF;margin:24px 0 0 0;">Button not working? Paste this link into your browser:<br><a href="{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=magiclink&next=/dashboard" style="color:#0FA47C;word-break:break-all;">{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=magiclink&next=/dashboard</a></p>
    </div>
    <div style="text-align:center;font-size:12px;color:#9CA3AF;margin-top:20px;line-height:1.6;">
      Welra · GR3NB LLC · <a href="https://welra.io" style="color:#9CA3AF;">welra.io</a><br>
      If you didn't request this link, you can safely ignore this email.
    </div>
  </div>
</div>
```

## 4. Change email address
**Subject:** `Confirm your new email — Welra`
```html
<div style="background:#F7F9FB;padding:32px 20px;font-family:-apple-system,'Segoe UI',sans-serif;">
  <div style="max-width:480px;margin:0 auto;">
    <div style="text-align:center;margin-bottom:24px;">
      <span style="font-size:22px;font-weight:700;letter-spacing:-0.5px;color:#0F1E33;">Welra</span>
    </div>
    <div style="background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;padding:32px;">
      <h2 style="font-size:20px;font-weight:700;color:#0F1E33;margin:0 0 12px 0;">Confirm your new email</h2>
      <p style="font-size:15px;line-height:1.6;color:#374151;margin:0 0 24px 0;">You asked to change the email on your Welra account from {{ .Email }} to {{ .NewEmail }}. Confirm the change below.</p>
      <a href="{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=email_change&next=/dashboard/settings" style="display:inline-block;background:#2FD6A6;color:#0F1E33;font-weight:600;font-size:15px;padding:12px 24px;border-radius:8px;text-decoration:none;">Confirm change</a>
      <p style="font-size:13px;line-height:1.6;color:#9CA3AF;margin:24px 0 0 0;">Button not working? Paste this link into your browser:<br><a href="{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=email_change&next=/dashboard/settings" style="color:#0FA47C;word-break:break-all;">{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=email_change&next=/dashboard/settings</a></p>
    </div>
    <div style="text-align:center;font-size:12px;color:#9CA3AF;margin-top:20px;line-height:1.6;">
      Welra · GR3NB LLC · <a href="https://welra.io" style="color:#9CA3AF;">welra.io</a><br>
      If you didn't request this change, contact ryan@welra.io right away.
    </div>
  </div>
</div>
```

## 5. Reset password
**Subject:** `Reset your Welra password`
```html
<div style="background:#F7F9FB;padding:32px 20px;font-family:-apple-system,'Segoe UI',sans-serif;">
  <div style="max-width:480px;margin:0 auto;">
    <div style="text-align:center;margin-bottom:24px;">
      <span style="font-size:22px;font-weight:700;letter-spacing:-0.5px;color:#0F1E33;">Welra</span>
    </div>
    <div style="background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;padding:32px;">
      <h2 style="font-size:20px;font-weight:700;color:#0F1E33;margin:0 0 12px 0;">Reset your password</h2>
      <p style="font-size:15px;line-height:1.6;color:#374151;margin:0 0 24px 0;">Click the button below to choose a new password for your Welra account. This link expires shortly.</p>
      <a href="{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=recovery&next=/reset-password" style="display:inline-block;background:#2FD6A6;color:#0F1E33;font-weight:600;font-size:15px;padding:12px 24px;border-radius:8px;text-decoration:none;">Reset password</a>
      <p style="font-size:13px;line-height:1.6;color:#9CA3AF;margin:24px 0 0 0;">Button not working? Paste this link into your browser:<br><a href="{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=recovery&next=/reset-password" style="color:#0FA47C;word-break:break-all;">{{ .SiteURL }}/auth/callback?token_hash={{ .TokenHash }}&type=recovery&next=/reset-password</a></p>
    </div>
    <div style="text-align:center;font-size:12px;color:#9CA3AF;margin-top:20px;line-height:1.6;">
      Welra · GR3NB LLC · <a href="https://welra.io" style="color:#9CA3AF;">welra.io</a><br>
      If you didn't request a password reset, you can safely ignore this email — your password is unchanged.
    </div>
  </div>
</div>
```

## 6. Reauthentication
**Subject:** `Your Welra verification code`
```html
<div style="background:#F7F9FB;padding:32px 20px;font-family:-apple-system,'Segoe UI',sans-serif;">
  <div style="max-width:480px;margin:0 auto;">
    <div style="text-align:center;margin-bottom:24px;">
      <span style="font-size:22px;font-weight:700;letter-spacing:-0.5px;color:#0F1E33;">Welra</span>
    </div>
    <div style="background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;padding:32px;text-align:center;">
      <h2 style="font-size:20px;font-weight:700;color:#0F1E33;margin:0 0 12px 0;">Your verification code</h2>
      <p style="font-size:15px;line-height:1.6;color:#374151;margin:0 0 24px 0;">Enter this code to confirm it's you:</p>
      <div style="font-size:32px;font-weight:700;letter-spacing:6px;color:#0F1E33;background:#F7F9FB;border:1px solid #e5e7eb;border-radius:8px;padding:16px;display:inline-block;">{{ .Token }}</div>
    </div>
    <div style="text-align:center;font-size:12px;color:#9CA3AF;margin-top:20px;line-height:1.6;">
      Welra · GR3NB LLC · <a href="https://welra.io" style="color:#9CA3AF;">welra.io</a><br>
      If you didn't request this code, you can safely ignore this email.
    </div>
  </div>
</div>
```

## SMTP status (2026-06-10)
- Form pre-filled by Claude: sender `Welra <auth@welra.io>`, host `smtp.resend.com`, port `465`, username `resend`, min interval 60s.
- **Password = Resend API key — Ryan must paste it** (Claude is prohibited from entering API keys into forms). Key: `RESEND_API_KEY` in `apps/api/.env` or resend.com → API Keys.
- After save: rate limit rises to 30 emails/hour (adjustable); sender becomes Welra-branded; Claude applies the 6 templates above.

Related: [[Projects/Welra/Brand_Identity]] · [[Projects/Welra/State]]
