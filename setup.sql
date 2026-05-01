-- SQL File to create tables manually for SQLite
-- Run this using: sqlite3 database/pharmacy.sqlite < setup.sql

-- Add activation fields to users table if not exists
ALTER TABLE users ADD COLUMN activated BOOLEAN DEFAULT 0;
ALTER TABLE users ADD COLUMN activation_code VARCHAR(255) NULL;
ALTER TABLE users ADD COLUMN activated_at TIMESTAMP NULL;
ALTER TABLE users ADD COLUMN activation_expiry TIMESTAMP NULL;
ALTER TABLE users ADD COLUMN full_name VARCHAR(255) NULL;
ALTER TABLE users ADD COLUMN phone VARCHAR(20) NULL;
ALTER TABLE users ADD COLUMN last_login TIMESTAMP NULL;

-- Create activation_cards table
CREATE TABLE IF NOT EXISTS activation_cards (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NOT NULL,
    used BOOLEAN DEFAULT 0,
    used_by VARCHAR(255) NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin user if not exists
INSERT OR IGNORE INTO users (id, name, email, password, full_name, activated, created_at, updated_at)
VALUES (1, 'admin', 'admin@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'مدير النظام', 1, datetime('now'), datetime('now'));

-- Create sessions table for Laravel
CREATE TABLE IF NOT EXISTS sessions (
    id VARCHAR(255) PRIMARY KEY,
    user_id INTEGER NULL,
    ip_address VARCHAR(45) NULL,
    user_agent TEXT NULL,
    payload TEXT NOT NULL,
    last_activity INTEGER NOT NULL
);

-- Create cache table for Laravel
CREATE TABLE IF NOT EXISTS cache (
    key VARCHAR(255) PRIMARY KEY,
    value TEXT NOT NULL,
    expiration INTEGER NOT NULL
);

-- Create queue jobs table
CREATE TABLE IF NOT EXISTS jobs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    queue VARCHAR(255) NOT NULL,
    payload TEXT NOT NULL,
    attempts TINYINT NOT NULL DEFAULT 0,
    reserved_at INTEGER NULL,
    available_at INTEGER NOT NULL,
    created_at INTEGER NOT NULL
);
