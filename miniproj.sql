-- ROOMS TABLE
CREATE TABLE rooms (
    room_id NUMBER PRIMARY KEY,
    room_type VARCHAR2(20),
    price_per_day NUMBER,
    status VARCHAR2(10) -- Available / Occupied
);

-- CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    phone VARCHAR2(15)
);

-- BOOKINGS TABLE
CREATE TABLE bookings (
    booking_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    room_id NUMBER,
    check_in DATE,
    check_out DATE,
    total_days NUMBER,
    total_amount NUMBER,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- PAYMENTS TABLE
CREATE TABLE payments (
    payment_id NUMBER PRIMARY KEY,
    booking_id NUMBER,
    amount_paid NUMBER,
    payment_date DATE,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

--insert sample data 
-- ROOMS
INSERT INTO rooms VALUES (1, 'Single', 2000, 'Available');
INSERT INTO rooms VALUES (2, 'Double', 3500, 'Available');
INSERT INTO rooms VALUES (3, 'Suite', 5000, 'Available');

-- CUSTOMERS
INSERT INTO customers VALUES (1, 'Ali', '03001234567');
INSERT INTO customers VALUES (2, 'Ahmed', '03111234567');

--room avalibility check 
SELECT * 
FROM rooms
WHERE status = 'Available';

--book a room (with calculations)
INSERT INTO bookings (
    booking_id, customer_id, room_id, check_in, check_out, total_days, total_amount
)
VALUES (
    1, 1, 1,
    DATE '2026-04-20',
    DATE '2026-04-25',
    (DATE '2026-04-25' - DATE '2026-04-20'),
    (DATE '2026-04-25' - DATE '2026-04-20') * 2000
);

--TRIGGER → AUTO UPDATE ROOM STATUS
CREATE OR REPLACE TRIGGER trg_room_booked
AFTER INSERT ON bookings
FOR EACH ROW
BEGIN
    UPDATE rooms
    SET status = 'Occupied'
    WHERE room_id = :NEW.room_id;
END;
/

--TRIGGER → AUTO CALCULATE BILL
CREATE OR REPLACE TRIGGER trg_calculate_bill
BEFORE INSERT ON bookings
FOR EACH ROW
DECLARE
    price NUMBER;
BEGIN
    SELECT price_per_day INTO price
    FROM rooms
    WHERE room_id = :NEW.room_id;

    :NEW.total_days := :NEW.check_out - :NEW.check_in;
    :NEW.total_amount := :NEW.total_days * price;
END;
/
--BILL GENERATION (JOIN)
SELECT 
    b.booking_id,
    c.name,
    r.room_type,
    b.check_in,
    b.check_out,
    b.total_days,
    b.total_amount
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN rooms r ON b.room_id = r.room_id;

--PAYMENT ENTRY
INSERT INTO payments VALUES (
    1, 1, 10000, SYSDATE
);

--HAVING CLAUSE (TOTAL REVENUE PER ROOM)
SELECT 
    room_id,
    SUM(total_amount) AS total_revenue
FROM bookings
GROUP BY room_id
HAVING SUM(total_amount) > 5000;

--EXTRA FEATURE → CHECK AVAILABLE ROOM BY DATE
SELECT *
FROM rooms r
WHERE r.room_id NOT IN (
    SELECT b.room_id
    FROM bookings b
    WHERE DATE '2026-04-22' BETWEEN b.check_in AND b.check_out
);