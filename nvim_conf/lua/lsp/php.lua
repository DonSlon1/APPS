-- PHP/Intelephense LSP Configuration
local M = {}

-- Function to get Intelephense license
local get_intelephense_license = function()
  local f = io.open(os.getenv("HOME") .. "/intelephense/license.txt", "rb")
  if not f then
    return ""
  end
  local content = f:read("*a")
  f:close()
  return string.gsub(content, "%s+", "")
end

M.setup = function(capabilities)
  local lspconfig = require("lspconfig")
  
  -- Stop any running intelephense instances first
  vim.lsp.stop_client(vim.lsp.get_active_clients({ name = "intelephense" }))
  
  lspconfig.intelephense.setup({
    cmd = { "node", "/home/lukas/.npm-global/lib/node_modules/intelephense/lib/intelephense.js", "--stdio" },
    capabilities = capabilities,
    single_file_support = false,
    root_dir = lspconfig.util.root_pattern("composer.json", ".git") or function()
      return vim.loop.cwd()
    end,
    init_options = {
      licenceKey = get_intelephense_license(),
      storagePath = vim.fn.expand("~/.cache/intelephense"),
      globalStoragePath = vim.fn.expand("~/.cache/intelephense")
    },
    settings = {
      intelephense = {
        files = {
          associations = {
            "**/*.php",
            "**/*.phtml",
            "**/*.inc",
            "**/*.module",
            "**/*.theme",
            "**/*.install",
          },
          exclude = {
            "**/dist/**",
            "**/.git/**",
            "**/node_modules/**",
            "**/bower_components/**",
            "**/vendor/**/.*/**",
            "**/vendor/**/{Test,test,Tests,tests}/**",
            "**/cache/**",
            "**/tmp/**",
            "**/temp/**"
          },
          maxSize = 5000000
        },
        environment = {
          includePaths = {
            "/home/lukas/apertia/autocrm",
            "/home/lukas/apertia/espocrm",
            "/home/lukas/apertia/espocrm/application",
            "/home/lukas/apertia/espocrm/application/Espo",
            "/home/lukas/apertia/espocrm/custom",
            "/home/lukas/apertia/modules",
            "/home/lukas/apertia/projects",
            "/home/lukas/apertia/PhpSpreadsheet"
          },
          phpVersion = "8.3.0"
        },
        diagnostics = {
          enable = true,
          undefinedTypes = true,
          undefinedFunctions = true,
          undefinedConstants = true,
          undefinedVariables = true,
          duplicateSymbols = true,
          unreachableCode = true,
        },
        stubs = {
          "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date", "dba", "dom", "enchant", "exif", "fileinfo", "filter", "fpm", "ftp", "gd", "hash", "iconv", "imap", "interbase", "intl", "json", "ldap", "libxml", "mbstring", "mcrypt", "meta", "mssql", "mysqli", "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix", "pspell", "readline", "recode", "Reflection", "regex", "session", "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals", "sybase", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "wddx", "xml", "xmlreader", "xmlrpc", "xmlwriter", "Zend OPcache", "zip", "zlib"
        },
        completion = {
          fullyQualifyGlobalConstantsAndFunctions = false,
          insertUseDeclaration = true,
          maxItems = 100,
          triggerParameterHints = true
        },
        format = {
          enable = false
        },
        trace = {
          server = "off"
        }
      }
    }
  })
end

return M
