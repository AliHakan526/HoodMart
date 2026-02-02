-- Trigger 1: Talep Onaylanınca Ürünü Pasife Çek
CREATE OR REPLACE FUNCTION update_item_availability() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'APPROVED' THEN
        UPDATE items SET is_available = FALSE WHERE item_id = NEW.item_id;
        RAISE NOTICE 'Ürün (ID: %) kiralandı, durumu pasife çekildi.', NEW.item_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_request_approved
AFTER UPDATE ON requests
FOR EACH ROW
EXECUTE FUNCTION update_item_availability();

-- Trigger 2: Kişi Kendi Malına Talep Oluşturamasın
CREATE OR REPLACE FUNCTION check_self_request() RETURNS TRIGGER AS $$
DECLARE
    owner_id_check INT;
BEGIN
    SELECT owner_id INTO owner_id_check FROM items WHERE item_id = NEW.item_id;
    
    IF owner_id_check = NEW.requester_id THEN
        RAISE EXCEPTION 'Hata: Kullanıcı kendi ürününe talep oluşturamaz!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_self_rent
BEFORE INSERT ON requests
FOR EACH ROW
EXECUTE FUNCTION check_self_request();