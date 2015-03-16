# 03/03/2001: FAQ module
CREATE TABLE faqs (
  id int(11) DEFAULT '0' NOT NULL auto_increment,
  question varchar(255) DEFAULT '' NOT NULL,
  answer text NOT NULL,
  weight tinyint(3) DEFAULT '0' NOT NULL,
  UNIQUE question (question),
  PRIMARY KEY (id)
);

# 26/02/2001: performance optimization
ALTER TABLE comments ADD INDEX lid_link (lid, link);

# 19/02/2001: internationalization / translation
alter table users add language varchar(2) DEFAULT '0' NOT NULL;
CREATE TABLE locales (
  id int(11) DEFAULT '0' NOT NULL auto_increment,
  location varchar(128) DEFAULT '' NOT NULL,
  string TEXT DEFAULT '' NOT NULL,
  en TEXT DEFAULT '' NOT NULL,
  PRIMARY KEY (id)
);

# 18/02/2001: permissions / access / group
alter table users drop permissions;
alter table users add access varchar(255) DEFAULT '' NOT NULL;

# 07/02/2001: value calculation
alter table users add rating decimal(8,4) DEFAULT '0' NOT NULL;

# 31/01/2001: block rehashing
alter table blocks add remove tinyint(1) DEFAULT '0' NOT NULL;

# 21/01/2001: section manager
alter table stories change category section varchar(64) DEFAULT '' NOT NULL;

# 20/01/2001: comment/discussion code rewrite:
alter table users modify mode tinyint(1) DEFAULT '' NOT NULL;
alter table comments change sid lid int(6) DEFAULT '0' NOT NULL;
alter table comments add link varchar(16) DEFAULT '' NOT NULL;
update comments set link = 'article';
