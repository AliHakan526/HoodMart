-- Users (10 Adet Örnek)
INSERT INTO users (name, email) VALUES 
('Burak', 'burak@ytu.edu.tr'), ('Ahmet', 'ahmet@mail.com'), ('Ayşe', 'ayse@mail.com'),
('Mehmet', 'mehmet@mail.com'), ('Zeynep', 'zeynep@mail.com'), ('Can', 'can@mail.com'),
('Elif', 'elif@mail.com'), ('Deniz', 'deniz@mail.com'), ('Cem', 'cem@mail.com'), ('Selin', 'selin@mail.com');

-- Addresses
INSERT INTO addresses (user_id, city, neighbor, street) VALUES
(1, 'İstanbul', 'Beşiktaş', 'Yıldız Cd.'), (2, 'İstanbul', 'Kadıköy', 'Moda Cd.'),
(3, 'Ankara', 'Çankaya', 'Atatürk Blv.'), (4, 'İzmir', 'Konak', 'Kordon'),
(5, 'Bursa', 'Nilüfer', 'FSM Blv.'), (6, 'İstanbul', 'Üsküdar', 'Sahil Yolu'),
(7, 'Antalya', 'Muratpaşa', 'Lara Cd.'), (8, 'İstanbul', 'Şişli', 'Halaskargazi'),
(9, 'Eskişehir', 'Odunpazarı', 'Atatürk Cd.'), (10, 'İstanbul', 'Bakırköy', 'İncirli Cd.');

-- Items (Burada SEQUENCE kullanıyoruz: nextval('item_price_seq'))
INSERT INTO items (owner_id, name, description, price) VALUES
(1, 'Matkap', 'Bosch Darbeli Matkap', nextval('item_price_seq')), -- 100 TL
(1, 'Çadır', '4 Kişilik Kamp Çadırı', nextval('item_price_seq')), -- 150 TL
(2, 'Bisiklet', 'Dağ Bisikleti', 500.00),
(3, 'PS5', 'Oyun Konsolu + 2 Kol', 800.00),
(4, 'Kamera', 'Canon DSLR', 600.00),
(5, 'Projeksiyon', 'Mini Projeksiyon Cihazı', 200.00),
(6, 'Matkap', 'Şarjlı Vidalama', 120.00),
(7, 'Kitap Seti', 'Yüzüklerin Efendisi Serisi', 50.00),
(8, 'Gitar', 'Klasik Gitar', 100.00),
(9, 'Dürbün', 'Doğa Gözlem Dürbünü', 300.00),
(10,'Bavul', 'Büyük Boy Kabin Valiz', 150.00);

-- Favorites (En az 10 kayıt)
-- Mantık: (user_id, item_id) -> 2 numaralı kullanıcı 1 numaralı ürünü favoriledi gibi.
INSERT INTO favorites (user_id, item_id) VALUES
(2, 1),  -- Ahmet, Burak'ın matkabını favoriledi
(3, 1),  -- Ayşe de matkabı favoriledi
(1, 3),  -- Burak, Ahmet'in bisikletini favoriledi
(4, 2),  -- Mehmet, Çadırı favoriledi
(5, 3),  -- Zeynep, Bisikleti favoriledi
(2, 4),  -- Ahmet, PS5'i favoriledi
(6, 5),  -- Can, Kamerayı favoriledi
(7, 1),  -- Elif, Matkabı favoriledi
(8, 10), -- Deniz, Dürbünü favoriledi
(9, 11), -- Cem, Bavulu favoriledi
(10, 3), -- Selin, Bisikleti favoriledi
(1, 5);  -- Burak, Kamerayı favoriledi

-- Requests (En az 10 kayıt)
-- Status: 'PENDING' (Bekliyor), 'APPROVED' (Onaylandı), 'REJECTED' (Reddedildi)
INSERT INTO requests (requester_id, item_id, status) VALUES
(2, 1, 'PENDING'),   -- Ahmet, Matkap istiyor (Beklemede)
(3, 2, 'APPROVED'),  -- Ayşe, Çadırı istedi (Onaylandı)
(1, 3, 'PENDING'),   -- Burak, Bisiklet istiyor (Beklemede)
(4, 3, 'REJECTED'),  -- Mehmet, Bisiklet istedi (Reddedildi - belki tarih uymadı)
(5, 4, 'PENDING'),   -- Zeynep, PS5 istiyor
(6, 1, 'PENDING'),   -- Can da Matkap istiyor
(2, 5, 'APPROVED'),  -- Ahmet, Kamera kiraladı
(7, 6, 'PENDING'),   -- Elif, Projeksiyon istiyor
(8, 7, 'REJECTED'),  -- Deniz, Şarjlı Matkap istedi (Reddedildi)
(9, 8, 'APPROVED'),  -- Cem, Kitap setini aldı
(10, 9, 'PENDING');  -- Selin, Gitar istiyor