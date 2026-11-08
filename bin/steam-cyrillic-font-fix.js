#!/usr/bin/env node
// Runs the shared fix script with the font bundled in this package.
'use strict';

const { spawnSync } = require('child_process');
const path = require('path');

if (process.platform !== 'darwin') {
  console.error('Steam Cyrillic Font Fix works on macOS only.');
  process.exit(1);
}

const root = path.join(__dirname, '..');
const result = spawnSync(
  '/bin/bash',
  [path.join(root, 'scripts', 'steam-cyrillic-font-fix.command'), ...process.argv.slice(2)],
  {
    stdio: 'inherit',
    env: { ...process.env, FONT_FILE: path.join(root, 'Font', 'MotivaSansfallback-Regular.ttf') },
  }
);

if (result.error) {
  console.error(result.error.message);
  process.exit(1);
}
process.exit(result.status === null ? 1 : result.status);
