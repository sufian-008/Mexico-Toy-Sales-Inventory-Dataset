-- Products
CREATE TABLE products (
  product_id BIGINT PRIMARY KEY,
  product_name TEXT NOT NULL,
  product_category TEXT,
  product_cost NUMERIC(10,2) NOT NULL CHECK (product_cost >= 0),
  product_price NUMERIC(10,2) NOT NULL CHECK (product_price >= 0)
);

-- Stores
CREATE TABLE stores (
  store_id BIGINT PRIMARY KEY,
  store_name TEXT NOT NULL,
  store_city TEXT,
  store_location TEXT,
  store_open_date DATE
);

-- Sales
CREATE TABLE sales (
  sale_id BIGINT PRIMARY KEY,
  date DATE NOT NULL,
  calendar_date DATE,
  store_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  units_sold INTEGER NOT NULL CHECK (units_sold >= 0),
  FOREIGN KEY (store_id) REFERENCES stores(store_id) ON DELETE RESTRICT,
  FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT
);

-- Inventory
CREATE TABLE inventory (
  store_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  stock_on_hand INTEGER NOT NULL CHECK (stock_on_hand >= 0),
  PRIMARY KEY (store_id, product_id),
  FOREIGN KEY (store_id) REFERENCES stores(store_id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);
