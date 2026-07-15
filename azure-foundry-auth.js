// azure-foundry-auth.js - Auto token refresh for OpenCode
const { execSync } = require('child_process');

module.exports = {
  name: 'azure-foundry-auth',
  version: '1.0.0',
  
  hooks: {
    'chat.headers': async (headers, context) => {
      // Only apply to azure-claude provider
      if (!context.provider || !context.provider.startsWith('azure-claude')) {
        return headers;
      }

      try {
        // Get fresh Azure token
        const token = execSync(
          'az account get-access-token --resource https://cognitiveservices.azure.com --query accessToken -o tsv',
          { encoding: 'utf8', stdio: ['pipe', 'pipe', 'ignore'] }
        ).trim();

        // Inject Bearer token
        return {
          ...headers,
          'Authorization': `Bearer ${token}`
        };
      } catch (error) {
        console.error('Failed to refresh Azure token:', error.message);
        return headers;
      }
    }
  }
};