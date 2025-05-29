-- Migrations will appear here as you chat with AI

create table chapters (
  id bigint primary key generated always as identity,
  chapter_number int not null,
  description text not null
);

create table headings (
  id bigint primary key generated always as identity,
  chapter_id bigint not null references chapters (id),
  heading_number int not null,
  description text not null
);

create table subheadings (
  id bigint primary key generated always as identity,
  heading_id bigint not null references headings (id),
  subheading_number int not null,
  description text not null
);

create table tariff_items (
  id bigint primary key generated always as identity,
  subheading_id bigint not null references subheadings (id),
  tariff_item_number int not null,
  description text not null
);

create table users (
  id bigint primary key generated always as identity,
  username text not null unique,
  password text not null,
  role text not null check (role in ('admin', 'user'))
);