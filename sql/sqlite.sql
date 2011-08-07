DROP TABLE entry;
CREATE TABLE `entry` (
   `entry_id` integer NOT NULL primary key AUTOINCREMENT,
   `body` text,
   `updated_at` datetime,
   `created_at` datetime
);

DROP TABLE entry_log;
CREATE TABLE `entry_log` (
   `entry_log_id` integer NOT NULL primary key AUTOINCREMENT,
   `entry_id` integer,
   `body` text,
   `event` varchar(100),
   `updated_at` datetime,
   `created_at` datetime
);
