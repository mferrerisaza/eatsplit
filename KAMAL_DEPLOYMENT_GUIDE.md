# Kamal Deployment Guide for Legacy Rails Apps

This guide documents the complete process for deploying old Rails applications (like this Rails 5.1.5 app) to a VPS using Kamal, based on the successful eatsplit deployment.

## Prerequisites

### On Your Local Machine
- Ruby 3.0+ globally installed (for Kamal CLI)
- Docker Desktop running
- 1Password CLI installed and authenticated
- SSH access to your VPS

### On Your VPS
- Docker installed
- SSH key authentication configured
- Ports available for your apps

## Shared Infrastructure Setup (One Time)

### 1. Create VPS Infrastructure Project

```bash
mkdir -p ~/code/vps-infrastructure
cd ~/code/vps-infrastructure
```

### 2. Create `config/deploy.yml`

```yaml
service: infrastructure
image: infrastructure-placeholder

servers:
  web:
    hosts:
      - YOUR_VPS_IP

registry:
  server: ghcr.io
  username: YOUR_GITHUB_USERNAME
  password:
    - KAMAL_REGISTRY_PASSWORD

ssh:
  user: admin

builder:
  arch: amd64

accessories:
  postgres:
    image: postgres:13-alpine
    host: YOUR_VPS_IP
    port: 5432
    env:
      clear:
        POSTGRES_USER: postgres
        POSTGRES_INITDB_ARGS: "--auth-host=md5"
      secret:
        - POSTGRES_PASSWORD
    directories:
      - postgres_data:/var/lib/postgresql/data
```

### 3. Create `.kamal/secrets`

```bash
SECRETS=$(kamal secrets fetch --adapter 1password --account my.1password.com --from "Personal/VPS Infrastructure" KAMAL_REGISTRY_PASSWORD POSTGRES_PASSWORD)
KAMAL_REGISTRY_PASSWORD=$(kamal secrets extract KAMAL_REGISTRY_PASSWORD ${SECRETS})
POSTGRES_PASSWORD=$(kamal secrets extract POSTGRES_PASSWORD ${SECRETS})
```

### 4. Deploy PostgreSQL

```bash
gem install kamal  # Use global Ruby 3.0+
kamal accessory boot postgres
```

## Deploying a New Rails App

### Step 1: Check Ruby/Rails Versions

Look at:
- `.ruby-version`
- `Gemfile` (Ruby and Rails versions)
- `package.json` (Node.js dependencies)

### Step 2: Create Dockerfile

**For Rails 5.x with Ruby 2.4.x:**

```dockerfile
# Dockerfile for Rails 5.1 with Webpacker
FROM ruby:2.4.4

# Fix Debian Stretch EOL - use archive repositories
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install -y --allow-unauthenticated \
      curl \
      gnupg \
      apt-transport-https \
      lsb-release \
      postgresql-client \
      build-essential && \
    rm -rf /var/lib/apt/lists/*

# Add Node.js repository (use version 9.x for old Webpacker)
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo "deb https://deb.nodesource.com/node_9.x stretch main" > /etc/apt/sources.list.d/nodesource.list && \
    echo "deb-src https://deb.nodesource.com/node_9.x stretch main" >> /etc/apt/sources.list.d/nodesource.list

# Add Yarn repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

# Install Node.js and Yarn
RUN apt-get update -qq && \
    apt-get install -y --allow-unauthenticated nodejs yarn && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /rails

# Install Ruby dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Install JavaScript dependencies (if using Webpacker)
COPY package.json yarn.lock ./
RUN yarn install --check-files

# Copy application code
COPY . .

# Precompile assets
RUN SECRET_KEY_BASE=dummy bundle exec rails assets:precompile RAILS_ENV=production

# Expose port
EXPOSE 3000

# Start the server
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
```

**Key Considerations:**
- Match Node.js version to your dependencies (check `package.json` for engine requirements)
- For Debian Stretch (Ruby 2.4): use `--allow-unauthenticated` and archive repos
- For Ruby 2.7+: Can use newer base images with standard repos
- Always use `SECRET_KEY_BASE=dummy` for asset precompilation

### Step 3: Create `.dockerignore`

```
.git
.gitignore
.env
.kamal
log/*
tmp/*
node_modules
public/packs
public/packs-test
coverage
.byebug_history
```

### Step 4: Create `config/deploy.yml`

```yaml
service: YOUR_APP_NAME
image: YOUR_GITHUB_USERNAME/YOUR_APP_NAME

servers:
  web:
    hosts:
      - YOUR_VPS_IP
    proxy: false  # Simple setup, no zero-downtime
    options:
      publish:
        - "XXXX:3000"  # Choose a unique port for this app

registry:
  server: ghcr.io
  username: YOUR_GITHUB_USERNAME
  password:
    - KAMAL_REGISTRY_PASSWORD

env:
  clear:
    RAILS_ENV: production
    RAILS_SERVE_STATIC_FILES: true
    PORT: 3000
  secret:
    - DATABASE_URL
    - SECRET_KEY_BASE
    # Add other secrets as needed
    # - CLOUDINARY_URL
    # - GOOGLE_BACKEND_API
    # - STRIPE_SECRET_KEY
    # etc.

volumes:
  - "YOUR_APP_NAME_storage:/rails/storage"

asset_path: /rails/public/assets

ssh:
  user: admin

builder:
  arch: amd64

# Useful aliases
aliases:
  console: app exec --interactive --reuse "bin/rails console"
  logs: app logs -f
  seed: app exec --reuse "bin/rails db:seed"
  migrate: app exec --reuse "bin/rails db:migrate"
  status: app exec --reuse "bin/rails db:migrate:status"
  restart: app restart
  stop: app stop
  start: app start
```

### Step 5: Create `.kamal/secrets`

```bash
# Fetch secrets from 1Password
SECRETS=$(kamal secrets fetch --adapter 1password --account my.1password.com --from "Personal/YOUR_APP_NAME Deployment" KAMAL_REGISTRY_PASSWORD DATABASE_URL SECRET_KEY_BASE)

# Extract individual secrets
KAMAL_REGISTRY_PASSWORD=$(kamal secrets extract KAMAL_REGISTRY_PASSWORD ${SECRETS})
DATABASE_URL=$(kamal secrets extract DATABASE_URL ${SECRETS})
SECRET_KEY_BASE=$(kamal secrets extract SECRET_KEY_BASE ${SECRETS})
# Add more secrets as needed
```

### Step 6: Set Up 1Password Vault

Create a 1Password item: "Personal/YOUR_APP_NAME Deployment" with:

- `KAMAL_REGISTRY_PASSWORD`: Your GitHub Personal Access Token (classic) with `write:packages` permission
- `DATABASE_URL`: `postgresql://postgres:PASSWORD@infrastructure-postgres:5432/YOUR_APP_NAME_production`
  - **IMPORTANT**: Use `infrastructure-postgres` as host (Docker container name), NOT the VPS IP
  - Password must match the `POSTGRES_PASSWORD` from VPS Infrastructure
- `SECRET_KEY_BASE`: Generate with `bundle exec rails secret`
- Add other environment variables your app needs

### Step 7: Update `.gitignore`

```
.env
.kamal/secrets
```

### Step 8: Initial Deployment

```bash
# Use global Ruby for Kamal
gem install kamal

# Or if using rbenv
RBENV_VERSION=3.4.4 kamal setup
```

### Step 9: Create Database and Run Migrations

```bash
RBENV_VERSION=3.4.4 kamal app exec --reuse 'bin/rails db:create db:migrate'
```

### Step 10: Seed Database (Optional)

```bash
RBENV_VERSION=3.4.4 kamal seed
```

## Common Issues & Solutions

### Issue: Port Already Allocated

**Error:** `Bind for 0.0.0.0:XXXX failed: port is already allocated`

**Solution:** With `proxy: false`, you need to stop the old container first:
```bash
RBENV_VERSION=3.4.4 kamal app stop
RBENV_VERSION=3.4.4 kamal deploy
```

### Issue: Can't Connect to PostgreSQL

**Error:** `could not connect to server: Connection timed out`

**Symptoms:** App tries to connect to VPS IP instead of container name

**Solution:** Update DATABASE_URL in 1Password to use `infrastructure-postgres` instead of VPS IP:
```
postgresql://postgres:PASSWORD@infrastructure-postgres:5432/dbname_production
```

Then restart:
```bash
RBENV_VERSION=3.4.4 kamal app stop
RBENV_VERSION=3.4.4 kamal app boot
```

### Issue: Node.js Version Incompatibility

**Error:** `The engine "node" is incompatible with this module`

**Solution:** Check `yarn.lock` for package version requirements and adjust Node.js version in Dockerfile:
- For `upath@1.0.4`: Use Node.js 9.x
- For most modern packages: Use Node.js 16.x or 18.x

### Issue: Debian Repository 404 Errors

**Error:** `Failed to fetch http://deb.debian.org/debian...`

**Solution:** For old Debian versions (Stretch), use archive repositories:
```dockerfile
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list
```

### Issue: Yarn is Wrong Package

**Error:** `yarn: error: no such option: --check-files`

**Solution:** Install yarn from official repository, not Debian's (which is cmdtest):
```dockerfile
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
```

### Issue: Missing Cloudinary/API Keys

**Error:** `Must supply api_key`

**Solution:** Add credentials to 1Password and update both `.kamal/secrets` and `config/deploy.yml`:
```yaml
env:
  secret:
    - CLOUDINARY_URL
    - GOOGLE_BACKEND_API
```

### Issue: CSRF Token Error with nginx/Cloudflare

**Error:** `ActionController::InvalidAuthenticityToken` - "HTTP Origin header (https://example.com) didn't match request.base_url (http://example.com)"

**Symptoms:**
- App loads fine but forms fail with CSRF errors
- Using Cloudflare (or any SSL-terminating proxy) + nginx + Rails

**Cause:** nginx's `proxy_set_header X-Forwarded-Proto $scheme;` overwrites Cloudflare's HTTPS header with HTTP (because nginx receives traffic on port 80)

**Solution:** Update nginx configuration to hardcode HTTPS:

1. Edit your nginx site config (e.g., `/etc/nginx/sites-available/yourapp`):
```nginx
server {
    listen 80;
    server_name yourapp.yourdomain.com;

    location / {
        proxy_pass http://127.0.0.1:3004;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;  # Changed from $scheme to https

        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

2. Test and reload nginx:
```bash
sudo nginx -t
sudo systemctl reload nginx
```

**Note:** This assumes ALL traffic comes through HTTPS (via Cloudflare). If you need to support both HTTP and HTTPS, use a conditional:
```nginx
proxy_set_header X-Forwarded-Proto $http_x_forwarded_proto;
```

## Regular Deployment Workflow

### Deploying Updates

```bash
cd /path/to/your/app

# 1. Make your changes
git add .
git commit -m "Your changes"
git push

# 2. Stop old container
RBENV_VERSION=3.4.4 kamal app stop

# 3. Deploy new version
RBENV_VERSION=3.4.4 kamal deploy
```

### Running Migrations After Deploy

```bash
RBENV_VERSION=3.4.4 kamal app exec --reuse 'bin/rails db:migrate'
```

### Useful Commands

```bash
# View logs
RBENV_VERSION=3.4.4 kamal app logs -f

# Access Rails console
RBENV_VERSION=3.4.4 kamal app exec --reuse --interactive 'bin/rails console'

# Check container status
RBENV_VERSION=3.4.4 kamal app details

# Restart without rebuilding
RBENV_VERSION=3.4.4 kamal app restart

# SSH into VPS
ssh admin@YOUR_VPS_IP

# Check Docker containers on VPS
ssh admin@YOUR_VPS_IP 'docker ps'

# Check PostgreSQL container
ssh admin@YOUR_VPS_IP 'docker exec -it infrastructure-postgres psql -U postgres'
```

## Port Allocation Reference

Keep track of which ports you've assigned to each app:

| App | Port | URL |
|-----|------|-----|
| its-listed | 3003 | http://VPS_IP:3003 |
| eatsplit | 3004 | http://VPS_IP:3004 |
| app3 | 3005 | http://VPS_IP:3005 |
| app4 | 3006 | http://VPS_IP:3006 |

## Architecture Overview

```
┌─────────────────────────────────────────┐
│           VPS (100.72.242.58)          │
│                                         │
│  ┌───────────────────────────────────┐ │
│  │   Docker Network: kamal           │ │
│  │                                   │ │
│  │  ┌─────────────────────────────┐ │ │
│  │  │ infrastructure-postgres     │ │ │
│  │  │ (PostgreSQL 13)             │ │ │
│  │  │ Port: 5432                  │ │ │
│  │  └─────────────────────────────┘ │ │
│  │                                   │ │
│  │  ┌─────────────────────────────┐ │ │
│  │  │ its-listed-web-XXXXX        │ │ │
│  │  │ Port: 0.0.0.0:3003 -> 3000  │ │ │
│  │  └─────────────────────────────┘ │ │
│  │                                   │ │
│  │  ┌─────────────────────────────┐ │ │
│  │  │ eatsplit-web-XXXXX          │ │ │
│  │  │ Port: 0.0.0.0:3004 -> 3000  │ │ │
│  │  └─────────────────────────────┘ │ │
│  │                                   │ │
│  └───────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

**Key Points:**
- All containers are on the same `kamal` Docker network
- Apps communicate with PostgreSQL using `infrastructure-postgres:5432`
- External access uses VPS IP and assigned ports (3003, 3004, etc.)

## Checklist for New App Deployment

- [ ] Check Ruby, Rails, and Node.js versions
- [ ] Create Dockerfile (adjust for versions)
- [ ] Create `.dockerignore`
- [ ] Create `config/deploy.yml` (assign unique port)
- [ ] Create `.kamal/secrets`
- [ ] Update `.gitignore`
- [ ] Create 1Password vault with all secrets
- [ ] **IMPORTANT**: Use `infrastructure-postgres` in DATABASE_URL, not VPS IP
- [ ] Generate SECRET_KEY_BASE with `bundle exec rails secret`
- [ ] Commit Kamal configuration files
- [ ] Run `kamal setup`
- [ ] Create database and run migrations
- [ ] Test the deployment at `http://VPS_IP:PORT`
- [ ] Document the port assignment

## Future Improvements

### Enable Zero-Downtime Deployments

Change `config/deploy.yml`:
```yaml
servers:
  web:
    hosts:
      - YOUR_VPS_IP
    proxy: true  # Enable Kamal proxy
```

Then you can use `kamal deploy` without manual stop/start.

### Add Reverse Proxy (nginx)

Set up nginx on VPS to:
- Use domain names instead of IP:PORT
- Handle SSL certificates
- Route multiple apps

### Monitoring & Backups

- Set up PostgreSQL automated backups
- Add application monitoring (e.g., Honeybadger, Sentry)
- Set up log aggregation

## Additional Resources

- [Kamal Documentation](https://kamal-deploy.org/)
- [Kamal GitHub Repository](https://github.com/basecamp/kamal)
- [1Password CLI Documentation](https://developer.1password.com/docs/cli/)
- [Docker Networking](https://docs.docker.com/network/)
