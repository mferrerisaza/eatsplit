# Deployment Guide for Eatsplit

This Rails 5.1 app is deployed to a Hetzner VPS using Kamal with shared PostgreSQL infrastructure.

## Architecture Overview

```
Hetzner VPS (100.72.242.58)
├── PostgreSQL 13 Container (managed by vps-infrastructure project)
│   ├── eatsplit_production database
│   └── (other app databases)
└── Eatsplit App Container (port 3004)
    └── Connects to PostgreSQL
```

## Prerequisites

### 1. Deploy Shared PostgreSQL (One-time)

The PostgreSQL container is managed separately in the `vps-infrastructure` project:

```bash
cd /Users/mferrerisaza/code/mferrerisaza/vps-infrastructure

# Edit .env and set POSTGRES_PASSWORD
# Then deploy PostgreSQL
kamal accessory boot postgres

# Verify it's running
kamal accessory details postgres
```

### 2. Create Eatsplit Database

```bash
cd /Users/mferrerisaza/code/mferrerisaza/vps-infrastructure

# Create the database
kamal accessory exec postgres "psql -U postgres -c 'CREATE DATABASE eatsplit_production;'"

# Verify it was created
kamal accessory exec postgres "psql -U postgres -c '\l'"
```

## Local Setup

### 1. Install Dependencies

```bash
cd /Users/mferrerisaza/code/mferrerisaza/eatsplit
bundle install
```

### 2. Configure Secrets

Edit `.env` file with your actual values:

```bash
# GitHub Personal Access Token
# Create at: https://github.com/settings/tokens
# Required scope: write:packages
KAMAL_REGISTRY_PASSWORD=ghp_your_token_here

# Rails Master Key
# If you have config/secrets.yml.enc, key is in config/master.key
# If not, generate: bundle exec rails secret
RAILS_MASTER_KEY=your_master_key_here

# PostgreSQL Connection
# MUST match the password set in vps-infrastructure/.env
DATABASE_URL=postgresql://postgres:same_password_as_infrastructure@100.72.242.58:5432/eatsplit_production
```

**IMPORTANT:** The PostgreSQL password must be identical to `POSTGRES_PASSWORD` in `vps-infrastructure/.env`.

### 3. Verify SSH Access

```bash
ssh admin@100.72.242.58
```

## Deployment

### First Deployment

```bash
cd /Users/mferrerisaza/code/mferrerisaza/eatsplit

# Build and deploy
bundle exec kamal setup

# Run database migrations
bundle exec kamal migrate

# (Optional) Seed database
bundle exec kamal seed
```

### Subsequent Deployments

```bash
# Deploy latest changes
bundle exec kamal deploy

# Run migrations if needed
bundle exec kamal migrate
```

## Managing the App

### Common Commands

```bash
# View application logs
bundle exec kamal logs

# Open Rails console
bundle exec kamal console

# Restart the app
bundle exec kamal restart

# Check app status
bundle exec kamal app details

# Run Rails commands
bundle exec kamal app exec "bin/rails db:migrate:status"

# SSH into app container
bundle exec kamal app exec --interactive bash
```

## Access the Application

After deployment, the app is available at:
- **URL:** http://100.72.242.58:3004
- **Port:** 3004 (container's 3000 → host's 3004)

## Database Management

All database operations use the infrastructure project:

```bash
cd /Users/mferrerisaza/code/mferrerisaza/vps-infrastructure

# Connect to PostgreSQL
kamal accessory exec postgres "psql -U postgres"

# Then in psql:
\c eatsplit_production  # Connect to eatsplit database
\dt                     # List tables
\q                      # Exit
```

### Backup Database

```bash
cd /Users/mferrerisaza/code/mferrerisaza/vps-infrastructure

# Backup eatsplit database
kamal accessory exec postgres "pg_dump -U postgres eatsplit_production" > eatsplit_backup_$(date +%Y%m%d).sql
```

### Restore Database

```bash
cd /Users/mferrerisaza/code/mferrerisaza/vps-infrastructure

# Restore from backup
cat eatsplit_backup_20241025.sql | kamal accessory exec postgres "psql -U postgres eatsplit_production"
```

## Troubleshooting

### Database Connection Errors

**Error:** `could not connect to server`

**Solutions:**
1. Verify PostgreSQL is running:
   ```bash
   cd /Users/mferrerisaza/code/mferrerisaza/vps-infrastructure
   kamal accessory details postgres
   ```

2. Test connection from VPS:
   ```bash
   ssh admin@100.72.242.58 'docker exec infrastructure-postgres psql -U postgres -c "SELECT 1"'
   ```

3. Verify DATABASE_URL in eatsplit/.env matches POSTGRES_PASSWORD in infrastructure/.env

### Authentication Errors

**Error:** `FATAL: password authentication failed`

**Solution:** Ensure passwords match between:
- `vps-infrastructure/.env` → `POSTGRES_PASSWORD=...`
- `eatsplit/.env` → `DATABASE_URL=postgresql://postgres:SAME_PASSWORD@...`

### Old pg Gem Compatibility

**Error:** Authentication method issues

**Solution:** PostgreSQL 13 is configured with md5 auth for compatibility with old `pg` gems. If you still have issues:

```bash
# Try upgrading pg gem in Gemfile
gem 'pg', '~> 1.2'  # Instead of 0.21
bundle install
```

### Asset Compilation Fails

**Error:** Webpacker compilation errors during build

**Solution:**
```bash
# Test locally
RAILS_ENV=production bundle exec rails assets:precompile

# If Node.js version issues, update Dockerfile
```

## Environment Variables

The app uses these environment variables (configured in `config/deploy.yml`):

- `RAILS_ENV=production`
- `RAILS_SERVE_STATIC_FILES=true` (serves assets without nginx)
- `PORT=3000` (internal container port)
- `RAILS_MASTER_KEY` (from .env, for encrypted credentials)
- `DATABASE_URL` (from .env, connects to shared PostgreSQL)

## Tech Stack

- **Rails:** 5.1.5
- **Ruby:** 2.4.4
- **Database:** PostgreSQL 13 (shared container)
- **Assets:** Webpacker 3.3
- **Server:** Puma
- **Container Registry:** GitHub Container Registry (ghcr.io)

## Sharing PostgreSQL with Other Apps

This PostgreSQL container is shared across multiple apps:

```
PostgreSQL Container (100.72.242.58:5432)
├── eatsplit_production (this app)
├── otherapp_production
└── (more databases as needed)
```

**Benefits:**
- Memory efficient (~200-350MB for all apps vs 1.4GB for separate containers)
- Centralized backups
- Single point of management

**To add another app:**
1. Create database: `kamal accessory exec postgres "psql -U postgres -c 'CREATE DATABASE newapp_production;'"`
2. Configure app's DATABASE_URL with same host/port, different database name
3. Deploy app

## Security Notes

- Never commit `.env` to git (already in `.gitignore`)
- Keep `config/master.key` secure (already in `.gitignore`)
- Use same PostgreSQL password across all apps, or create dedicated users per app
- Consider setting up SSL/TLS for production use
- PostgreSQL 13 receives security updates until November 2025

## Next Steps

After successful deployment:
1. Set up domain name and reverse proxy (nginx/Caddy)
2. Configure SSL certificates
3. Set up automated backups
4. Monitor resource usage
5. Consider upgrading to newer Rails version (Rails 7+)
