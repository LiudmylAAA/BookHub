
create table if not exists categories (
    category_id int auto_increment primary key,
    name varchar(255) not null
);

create table if not exists genres (
    genre_id int auto_increment primary key,
    name varchar(255) not null,
    category_id int default null,
    foreign key (category_id) references categories(category_id) on delete cascade on update cascade
);

create table if not exists publisher (
    publisher_id int auto_increment primary key,
    name varchar(255) not null
);

create table if not exists authors (
    author_id int auto_increment primary key,
    nickname varchar(255),
    first_name varchar(255) not null,
    last_name varchar(255) not null
);

create table if not exists books (
    book_id int auto_increment primary key,
    name varchar(255) not null,
    price decimal(10,2) not null check (price >= 0),
    quantity int not null,
    genre_id int,
    publisher_id int,
    author_id int not null,
    foreign key (genre_id) references genres(genre_id) on delete set null,
    foreign key (publisher_id) references publisher(publisher_id) on delete set null,
    foreign key (author_id) references authors(author_id) on delete cascade
);

create table if not exists customers (
    customer_id int auto_increment primary key,
    first_name varchar(255) not null,
    last_name varchar(255) not null,
    email varchar(255) not null unique,
    phone_number varchar(20) not null,
    password varchar(255) not null check (length(password) >= 8)
);

create table if not exists cities (
    city_id int auto_increment primary key,
    name varchar(255) not null unique
);

create table if not exists branches (
    branch_id int auto_increment primary key,
    city_id int not null,
    name varchar(255) not null,
    foreign key (city_id) references cities(city_id) on delete cascade
);

create table if not exists orders (
    order_id int auto_increment primary key,
    customer_id int,
    city_id int not null,
    branch_id int not null,
    order_date datetime not null,
    total_amount decimal(10,2) not null,
    order_status enum('нове', 'в обробці', 'відправлено', 'доставлено') not null,
    foreign key (customer_id) references customers(customer_id) on delete cascade on update cascade,
    foreign key (city_id) references cities(city_id) on delete restrict on update cascade,
    foreign key (branch_id) references branches(branch_id) on delete restrict on update cascade
);

create table if not exists order_items (
    order_item_id int auto_increment primary key,
    order_id int not null,
    book_id int not null,
    quantity int not null,
    unit_price decimal(10,2) not null,
    foreign key (order_id) references orders(order_id) on delete cascade on update cascade,
    foreign key (book_id) references books(book_id) on delete cascade on update cascade
);

create table if not exists payments (
    payment_id int auto_increment primary key,
    order_id int not null,
    payment_date datetime not null,
    amount decimal(10,2) not null,
    payment_method enum('онлайн-оплата', 'накладний платіж') not null,
    foreign key (order_id) references orders(order_id) on delete cascade on update cascade
);
