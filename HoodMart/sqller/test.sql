-- 1. UNION/INTERSECT/EXCEPT Şartı
-- "Hem favorilere eklediğim hem de talep gönderdiğim ürünlerin ID'leri"
SELECT item_id FROM favorites WHERE user_id = 1
INTERSECT
SELECT item_id FROM requests WHERE requester_id = 1;

-- 2. Aggregate ve Having Şartı
-- "Ortalama ürün fiyatı 100 TL'den yüksek olan ve en az 2 ürünü olan satıcılar"
SELECT owner_id, COUNT(*) as total_items, AVG(price) as avg_price
FROM items
GROUP BY owner_id
HAVING COUNT(*) >= 2 AND AVG(price) > 100;