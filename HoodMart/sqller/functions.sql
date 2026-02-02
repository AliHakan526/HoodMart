-- Fonksiyon 1: Cursor ve Record Kullanan (Portföy Değeri Hesaplama)
-- Bir kullanıcının satıştaki/kiradaki ürünlerinin toplam değerini döngüyle hesaplar.
CREATE OR REPLACE FUNCTION calculate_portfolio_value(owner_input INT) 
RETURNS DECIMAL AS $$
DECLARE
    total_value DECIMAL := 0;
    rec_item RECORD; -- Record kullanımı
    cur_items CURSOR FOR SELECT price, is_available FROM items WHERE owner_id = owner_input; -- Cursor kullanımı
BEGIN
    OPEN cur_items;
    LOOP
        FETCH cur_items INTO rec_item;
        EXIT WHEN NOT FOUND;
        
        -- Sadece müsait olan ürünlerin değerini topla
        IF rec_item.is_available THEN
            total_value := total_value + rec_item.price;
        END IF;
    END LOOP;
    CLOSE cur_items;
    
    RETURN total_value;
END;
$$ LANGUAGE plpgsql;

-- Fonksiyon 2: Tablo Döndüren Fonksiyon (Fiyat Aralığı Arama)
CREATE OR REPLACE FUNCTION search_items_by_price(min_p DECIMAL, max_p DECIMAL)
RETURNS TABLE (item_name VARCHAR, price DECIMAL, owner VARCHAR) AS $$
BEGIN
    RETURN QUERY 
    SELECT i.name, i.price, u.name
    FROM items i
    JOIN users u ON i.owner_id = u.user_id
    WHERE i.price BETWEEN min_p AND max_p;
END;
$$ LANGUAGE plpgsql;

-- Fonksiyon 3: Basit Parametrik Fonksiyon (Toplam Ürün Sayısı)
CREATE OR REPLACE FUNCTION get_user_item_count(user_id_input INT)
RETURNS INT AS $$
DECLARE
    item_count INT;
BEGIN
    SELECT COUNT(*) INTO item_count FROM items WHERE owner_id = user_id_input;
    RETURN item_count;
END;
$$ LANGUAGE plpgsql;