-- Rolleri oluştur
CREATE ROLE admin_user WITH LOGIN PASSWORD 'admin123';
CREATE ROLE app_user WITH LOGIN PASSWORD 'user123';

-- Yetkileri Ata
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_user;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_user;
GRANT INSERT, UPDATE ON requests, favorites TO app_user;
GRANT USAGE ON SEQUENCE item_price_seq TO app_user;