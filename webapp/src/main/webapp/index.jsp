<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Create your account | DevOps Learning</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:wght@600;700&family=Figtree:wght@400;500;600&display=swap" rel="stylesheet">

  <style>
    :root {
      --ink: #0e1b2c;
      --ink-soft: #1a2c44;
      --paper: #f6f8fb;
      --card: #ffffff;
      --line: #d9e0ea;
      --text: #17202e;
      --muted: #5d6b7e;
      --accent: #1f6feb;
      --accent-dark: #1858bd;
      --ok: #12805c;
      --bad: #c2362b;
      --radius: 10px;
    }

    * { box-sizing: border-box; margin: 0; }

    body {
      font-family: "Figtree", system-ui, -apple-system, "Segoe UI", sans-serif;
      color: var(--text);
      background: var(--paper);
      min-height: 100vh;
      display: grid;
      grid-template-columns: minmax(320px, 5fr) 7fr;
    }

    /* ---------- Left: brand panel ---------- */
    .brand {
      background: var(--ink);
      color: #e8eef7;
      padding: 56px 56px 40px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      gap: 40px;
    }
    .brand h2 {
      font-family: "Bricolage Grotesque", "Figtree", sans-serif;
      font-size: clamp(1.9rem, 3vw, 2.6rem);
      line-height: 1.1;
      letter-spacing: -0.02em;
      max-width: 14ch;
    }
    .brand p.lead {
      margin-top: 16px;
      color: #9db0c8;
      line-height: 1.6;
      max-width: 38ch;
    }

    /* Pipeline: the one memorable element */
    .pipeline {
      list-style: none;
      padding: 0;
      margin: 0;
      position: relative;
    }
    .pipeline::before {
      content: "";
      position: absolute;
      left: 11px; top: 14px; bottom: 14px;
      width: 2px;
      background: var(--ink-soft);
    }
    .pipeline li {
      position: relative;
      display: flex;
      align-items: center;
      gap: 18px;
      padding: 12px 0;
      font-weight: 500;
    }
    .pipeline .dot {
      width: 24px; height: 24px;
      border-radius: 50%;
      background: var(--ink);
      border: 2px solid #3b5679;
      display: grid; place-items: center;
      z-index: 1;
      flex: none;
    }
    .pipeline li.done .dot { background: var(--accent); border-color: var(--accent); }
    .pipeline li.done .dot::after {
      content: "";
      width: 6px; height: 11px;
      border: solid #fff;
      border-width: 0 2px 2px 0;
      transform: translateY(-1px) rotate(45deg);
    }
    .pipeline li.now .dot { border-color: var(--accent); box-shadow: 0 0 0 4px rgba(31,111,235,.25); }
    .pipeline small { display: block; color: #8499b5; font-weight: 400; margin-top: 2px; }

    .brand footer { color: #8499b5; font-size: .95rem; }

    /* ---------- Right: form ---------- */
    .panel {
      display: grid;
      place-items: center;
      padding: 48px 24px;
    }
    .form-wrap { width: 100%; max-width: 460px; }

    .form-wrap h1 {
      font-family: "Bricolage Grotesque", "Figtree", sans-serif;
      font-size: 2rem;
      letter-spacing: -0.02em;
      line-height: 1.15;
    }
    .form-wrap .sub { color: var(--muted); margin: 10px 0 30px; line-height: 1.5; }

    .field { margin-bottom: 18px; }
    .field label {
      display: block;
      font-weight: 600;
      font-size: .92rem;
      margin-bottom: 6px;
    }
    .control { position: relative; }
    .control input {
      width: 100%;
      font: inherit;
      padding: 12px 14px;
      background: var(--card);
      border: 1.5px solid var(--line);
      border-radius: var(--radius);
      color: var(--text);
      transition: border-color .15s, box-shadow .15s;
    }
    .control input::placeholder { color: #98a4b5; }
    .control input:hover { border-color: #b9c4d3; }
    .control input:focus {
      outline: none;
      border-color: var(--accent);
      box-shadow: 0 0 0 4px rgba(31,111,235,.15);
    }
    .control input.invalid { border-color: var(--bad); }
    .control input.invalid:focus { box-shadow: 0 0 0 4px rgba(194,54,43,.15); }
    .control input.has-toggle { padding-right: 64px; }

    .toggle {
      position: absolute; right: 8px; top: 50%;
      transform: translateY(-50%);
      background: none; border: 0;
      color: var(--accent);
      font: inherit; font-size: .88rem; font-weight: 600;
      padding: 6px 8px; border-radius: 6px;
      cursor: pointer;
    }
    .toggle:hover { background: rgba(31,111,235,.08); }

    .row { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }

    .hint { font-size: .85rem; color: var(--muted); margin-top: 6px; min-height: 1.2em; }
    .hint.error { color: var(--bad); }
    .hint.good { color: var(--ok); }

    .meter { display: flex; gap: 4px; margin-top: 8px; }
    .meter span { flex: 1; height: 4px; border-radius: 2px; background: var(--line); transition: background .2s; }
    .meter[data-level="1"] span:nth-child(-n+1) { background: var(--bad); }
    .meter[data-level="2"] span:nth-child(-n+2) { background: #d98a1a; }
    .meter[data-level="3"] span:nth-child(-n+3) { background: #3d9b5f; }
    .meter[data-level="4"] span:nth-child(-n+4) { background: var(--ok); }

    .terms { font-size: .9rem; color: var(--muted); margin: 22px 0 18px; line-height: 1.5; }
    .terms a, .signin a { color: var(--accent); font-weight: 600; text-decoration: none; }
    .terms a:hover, .signin a:hover { text-decoration: underline; }

    .registerbtn {
      width: 100%;
      font: inherit; font-weight: 600; font-size: 1rem;
      padding: 14px;
      background: var(--accent);
      color: #fff;
      border: 0;
      border-radius: var(--radius);
      cursor: pointer;
      transition: background .15s, transform .05s;
    }
    .registerbtn:hover { background: var(--accent-dark); }
    .registerbtn:active { transform: translateY(1px); }
    .registerbtn:focus-visible, .toggle:focus-visible, a:focus-visible {
      outline: 3px solid rgba(31,111,235,.45);
      outline-offset: 2px;
    }

    .signin {
      text-align: center;
      margin-top: 24px;
      padding-top: 22px;
      border-top: 1px solid var(--line);
      color: var(--muted);
    }

    /* ---------- Responsive ---------- */
    @media (max-width: 860px) {
      body { grid-template-columns: 1fr; }
      .brand { padding: 32px 24px; gap: 24px; }
      .brand h2 { max-width: none; }
      .pipeline, .brand footer { display: none; }
    }
    @media (max-width: 480px) {
      .row { grid-template-columns: 1fr; }
    }
    @media (prefers-reduced-motion: reduce) {
      * { transition: none !important; }
    }
  </style>
</head>
<body>

  <aside class="brand">
    <div>
      <h2>Learn DevOps by doing it.</h2>
      <p class="lead">Create your free account and start working through the pipeline, from source control to production.</p>
    </div>

    <ul class="pipeline" aria-hidden="true">
      <li class="done"><span class="dot"></span><span>Create your account<small>You are here</small></span></li>
      <li class="now"><span class="dot"></span><span>Build your first pipeline</span></li>
      <li><span class="dot"></span><span>Test and containerize</span></li>
      <li><span class="dot"></span><span>Deploy to production</span></li>
    </ul>

    <footer>Designed by Blaise Chidera.</footer>
  </aside>

  <main class="panel">
    <div class="form-wrap">
      <h1>Create your account</h1>
      <p class="sub">Register for DevOps Learning. It only takes a minute.</p>

      <form action="action_page.php" method="post" id="registerForm" novalidate>

        <div class="field">
          <label for="Name">Full name</label>
          <div class="control">
            <input type="text" name="Name" id="Name" placeholder="Jane Doe" autocomplete="name" required>
          </div>
        </div>

        <div class="row">
          <div class="field">
            <label for="mobile">Mobile number</label>
            <div class="control">
              <input type="tel" name="mobile" id="mobile" placeholder="+1 416 555 0123" autocomplete="tel" inputmode="tel" required>
            </div>
          </div>
          <div class="field">
            <label for="email">Email</label>
            <div class="control">
              <input type="email" name="email" id="email" placeholder="jane@example.com" autocomplete="email" required>
            </div>
          </div>
        </div>

        <div class="field">
          <label for="psw">Password</label>
          <div class="control">
            <input type="password" name="psw" id="psw" class="has-toggle" placeholder="At least 8 characters" autocomplete="new-password" minlength="8" required>
            <button type="button" class="toggle" data-target="psw" aria-label="Show password">Show</button>
          </div>
          <div class="meter" id="meter" data-level="0" aria-hidden="true"><span></span><span></span><span></span><span></span></div>
          <p class="hint" id="pswHint">Use 8+ characters with a mix of letters, numbers and symbols.</p>
        </div>

        <div class="field">
          <label for="psw-repeat">Repeat password</label>
          <div class="control">
            <input type="password" name="psw-repeat" id="psw-repeat" class="has-toggle" placeholder="Re-enter your password" autocomplete="new-password" required>
            <button type="button" class="toggle" data-target="psw-repeat" aria-label="Show password">Show</button>
          </div>
          <p class="hint" id="matchHint" aria-live="polite"></p>
        </div>

        <p class="terms">By creating an account you agree to our <a href="#">Terms &amp; Privacy</a>.</p>

        <button type="submit" class="registerbtn">Create account</button>
      </form>

      <p class="signin">Already have an account? <a href="#">Sign in</a></p>
    </div>
  </main>

  <script>
    (function () {
      var form = document.getElementById('registerForm');
      var psw = document.getElementById('psw');
      var repeat = document.getElementById('psw-repeat');
      var meter = document.getElementById('meter');
      var pswHint = document.getElementById('pswHint');
      var matchHint = document.getElementById('matchHint');
      var labels = ['', 'Weak', 'Fair', 'Good', 'Strong'];

      // Show / hide password
      document.querySelectorAll('.toggle').forEach(function (btn) {
        btn.addEventListener('click', function () {
          var input = document.getElementById(btn.dataset.target);
          var show = input.type === 'password';
          input.type = show ? 'text' : 'password';
          btn.textContent = show ? 'Hide' : 'Show';
          btn.setAttribute('aria-label', show ? 'Hide password' : 'Show password');
        });
      });

      // Password strength
      function score(v) {
        var s = 0;
        if (v.length >= 8) s++;
        if (/[a-z]/.test(v) && /[A-Z]/.test(v)) s++;
        if (/\d/.test(v)) s++;
        if (/[^A-Za-z0-9]/.test(v)) s++;
        return v.length ? Math.max(s, 1) : 0;
      }
      psw.addEventListener('input', function () {
        var s = score(psw.value);
        meter.dataset.level = s;
        pswHint.textContent = s ? 'Password strength: ' + labels[s] : 'Use 8+ characters with a mix of letters, numbers and symbols.';
        checkMatch();
      });

      // Match check
      function checkMatch() {
        if (!repeat.value) {
          matchHint.textContent = '';
          matchHint.className = 'hint';
          repeat.classList.remove('invalid');
          return true;
        }
        var ok = psw.value === repeat.value;
        matchHint.textContent = ok ? 'Passwords match.' : 'Passwords do not match.';
        matchHint.className = 'hint ' + (ok ? 'good' : 'error');
        repeat.classList.toggle('invalid', !ok);
        return ok;
      }
      repeat.addEventListener('input', checkMatch);

      // Submit validation
      form.addEventListener('submit', function (e) {
        var firstBad = null;
        form.querySelectorAll('input[required]').forEach(function (el) {
          var bad = !el.checkValidity();
          el.classList.toggle('invalid', bad);
          if (bad && !firstBad) firstBad = el;
        });
        if (!checkMatch() && !firstBad) firstBad = repeat;
        if (firstBad) {
          e.preventDefault();
          firstBad.focus();
        }
      });
    })();
  </script>
</body>
</html>

