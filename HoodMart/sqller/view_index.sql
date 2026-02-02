-- 1. Index Oluşturma (Arama performansı için)
-- Ürün ismine ve mahalleye göre aramaları hızlandırır.
CREATE INDEX idx_items_name ON items(name);
CREATE INDEX idx_addr_neighbor ON addresses(neighbor);

-- 2. View Oluşturma (Sanal Tablo)
-- Kullanıcı, adres ve ürün detaylarını tek tabloda birleştirir.
CREATE OR REPLACE VIEW view_item_details AS
SELECT 
    i.item_id, 
    i.name AS item_name, 
    i.price, 
    i.is_available,
    u.name AS owner_name, 
    a.city, 
    a.neighbor
FROM items i
JOIN users u ON i.owner_id = u.user_id
JOIN addresses a ON u.user_id = a.user_id;