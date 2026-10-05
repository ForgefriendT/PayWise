const fs = require('fs');
const path = require('path');
const os = require('os');

// Resolve Stitch API key dynamically from local config or environment
function getApiKey() {
  if (process.env.STITCH_API_KEY) return process.env.STITCH_API_KEY;
  try {
    const configPath = path.join(os.homedir(), '.gemini/antigravity-ide/mcp_config.json');
    if (fs.existsSync(configPath)) {
      const config = JSON.parse(fs.readFileSync(configPath, 'utf8'));
      return config.mcpServers?.stitch?.headers?.['X-Goog-Api-Key'] || '';
    }
  } catch (_) {}
  return '';
}

const ENDPOINT = 'https://stitch.googleapis.com/mcp';
const PROJECT_ID = '7192317764456965213';

async function callStitch(method, args) {
  const apiKey = getApiKey();
  const payload = {
    jsonrpc: '2.0',
    method: 'tools/call',
    params: { name: method, arguments: args },
    id: Date.now()
  };

  const res = await fetch(ENDPOINT, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey
    },
    body: JSON.stringify(payload)
  });

  return await res.json();
}

async function generateScreen(name, prompt) {
  console.log(`Generating screen: ${name}...`);
  const res = await callStitch('generate_screen_from_text', {
    projectId: PROJECT_ID,
    prompt: prompt,
    deviceType: 'MOBILE',
    modelId: 'GEMINI_3_FLASH'
  });
  console.log(`Result for ${name}:`, JSON.stringify(res).slice(0, 300));
  return res;
}

module.exports = { callStitch, generateScreen, PROJECT_ID };

if (require.main === module) {
  const args = process.argv.slice(2);
  const action = args[0] || 'list';
  if (action === 'list') {
    callStitch('list_screens', { projectId: PROJECT_ID }).then(r => console.log(JSON.stringify(r, null, 2)));
  } else if (action === 'test') {
    generateScreen('login_screen', 'PayWise mobile login screen with email, password, and continue as demo user button.');
  }
}
