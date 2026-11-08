#!/usr/bin/env node
// npm doesn't render GitHub alerts (> [!NOTE]), so the published README gets plain
// bold labels instead. Runs around `npm pack` / `npm publish`:
//   node scripts/npm-readme.js prepack   save README.md, write the npm version
//   node scripts/npm-readme.js postpack  put the GitHub README.md back
'use strict';

const fs = require('fs');
const path = require('path');

const root = path.join(__dirname, '..');
const readme = path.join(root, 'README.md');
const saved = path.join(root, '.README.github.md');

const LABELS = { NOTE: 'Note', TIP: 'Tip', IMPORTANT: 'Important', WARNING: 'Warning', CAUTION: 'Caution' };

function toNpm(md) {
  return md.replace(/^> \[!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\]\n> /gm, (_, type) => `> **${LABELS[type]}:** `);
}

const step = process.argv[2];
if (step === 'prepack') {
  // A leftover copy means the last pack didn't finish: it holds the real README.
  if (!fs.existsSync(saved)) fs.copyFileSync(readme, saved);
  fs.writeFileSync(readme, toNpm(fs.readFileSync(saved, 'utf8')));
} else if (step === 'postpack') {
  if (fs.existsSync(saved)) fs.renameSync(saved, readme);
} else {
  console.error('Usage: node scripts/npm-readme.js prepack|postpack');
  process.exit(2);
}

module.exports = { toNpm };
