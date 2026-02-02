-- Temizlik (Varsa öncekileri sil)
DROP TABLE IF EXISTS requests, favorites, items, addresses, users CASCADE;

-- 1. Users Tablosu
CREATE TABLE users (
    user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    profile_pic VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Addresses Tablosu (Silme Kısıtı Burada: User silinirse adresi de silinsin - CASCADE)
CREATE TABLE addresses (
    address_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    country VARCHAR(50) DEFAULT 'Türkiye',
    city VARCHAR(50) NOT NULL,
    neighbor VARCHAR(100) NOT NULL, -- Çizimdeki 'neighbor'
    street VARCHAR(150) NOT NULL
);

-- 3. Items Tablosu (Sequence ve Check Kısıtı)
-- Sequence şartını sağlamak için burada manuel bir sequence oluşturalım.
CREATE SEQUENCE item_price_seq START 100 INCREMENT 50;

CREATE TABLE items (
    item_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    owner_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    renter_id INT REFERENCES users(user_id) ON DELETE SET NULL, -- Kiralayan silinirse item silinmesin, boşalsın.
    name VARCHAR(100) NOT NULL,
    description TEXT, -- Çizimdeki 'exp'
    price DECIMAL(10, 2) CHECK (price > 0), -- Sayı kısıtı (Check Constraint)
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Favorites Tablosu
CREATE TABLE favorites (
    user_id INT NOT NULL REFERENCES users(user_id),
    item_id INT NOT NULL REFERENCES items(item_id),
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, item_id) -- Composite Primary Key
);

-- 5. Requests Tablosu (Talep Yönetimi)
CREATE TABLE requests (
    request_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    requester_id INT NOT NULL REFERENCES users(user_id),
    item_id INT NOT NULL REFERENCES items(item_id),
    status VARCHAR(20) DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED')),
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);