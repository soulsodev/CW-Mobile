CREATE TABLE [user] (
	user_id integer NOT NULL,
	name varchar(255) NOT NULL,
	phone varchar(255) NOT NULL,
	login varchar(255) NOT NULL,
	password varchar(255) NOT NULL,
	role integer NOT NULL,
  CONSTRAINT [PK_USER] PRIMARY KEY CLUSTERED
  (
  [user_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [consultation] (
	consultation_id integer NOT NULL,
	user_id integer NOT NULL,
	city varchar(255) NOT NULL,
	salon_address varchar(255) NOT NULL,
	date datetime NOT NULL,
	time datetime NOT NULL,
	service datetime NOT NULL,
  CONSTRAINT [PK_CONSULTATION] PRIMARY KEY CLUSTERED
  (
  [consultation_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [favorite] (
	favorite_id integer NOT NULL,
	user_id integer NOT NULL,
	product_id integer NOT NULL,
	news_id integer NOT NULL,
  CONSTRAINT [PK_FAVORITE_PRODUCT] PRIMARY KEY CLUSTERED
  (
  [favorite_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [product] (
	product_id integer NOT NULL,
	brand varchar(255) NOT NULL,
	model varchar(255) NOT NULL,
	description varchar(255) NOT NULL,
	material varchar(255) NOT NULL,
	cost decimal NOT NULL,
	counrty varchar(255) NOT NULL,
	photo binary(255) NOT NULL,
  CONSTRAINT [PK_PRODUCT] PRIMARY KEY CLUSTERED
  (
  [product_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [frame] (
	frame_id integer NOT NULL,
	frame_design varchar(255) NOT NULL,
	color varchar(255) NOT NULL,
	temple_length varchar(255) NOT NULL,
	rim_opening_width varchar(255) NOT NULL,
	bridge_width varchar(255) NOT NULL,
	age integer NOT NULL,
	gender varchar(1) NOT NULL,
  CONSTRAINT [PK_FRAME] PRIMARY KEY CLUSTERED
  (
  [frame_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [lenses] (
	lenses_id integer NOT NULL,
	type varchar(255) NOT NULL,
	wearing_mode varchar(255) NOT NULL,
	moisture_containing decimal NOT NULL,
	oxygen_transmittance decimal NOT NULL,
	diameter decimal NOT NULL,
	blisters_number integer NOT NULL,
  CONSTRAINT [PK_LENSES] PRIMARY KEY CLUSTERED
  (
  [lenses_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [glasses] (
	glasses_id integer NOT NULL,
	form varchar(255) NOT NULL,
	frame_design varchar(255) NOT NULL,
	color varchar(255) NOT NULL,
	coating varchar(255) NOT NULL,
	lens_color varchar(255) NOT NULL,
	age integer NOT NULL,
	gender varchar(1) NOT NULL,
  CONSTRAINT [PK_GLASSES] PRIMARY KEY CLUSTERED
  (
  [glasses_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [news] (
	news_id integer NOT NULL,
	title varchar(255) NOT NULL,
	description varchar(255) NOT NULL,
	image binary NOT NULL,
	date datetime NOT NULL,
  CONSTRAINT [PK_NEWS] PRIMARY KEY CLUSTERED
  (
  [news_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO







