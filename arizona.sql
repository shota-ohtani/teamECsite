set names utf8;
set foreign_key_checks=0;

drop database if exists arizona;
create database if not exists arizona;

use arizona;

create table user_info(
id int primary key not null auto_increment comment "ID",
user_id varchar(16) unique not null comment "ユーザーID",
password varchar(16) not null comment "パスワード",
family_name varchar(32) not null comment "姓",
first_name varchar(32) not null comment "名",
family_name_kana varchar(32) not null comment "姓かな",
first_name_kana varchar(32) not null comment "名かな",
sex tinyint default 0 comment "性別",
email varchar(32) comment "メールアドレス",
status tinyint default 0 comment "ステータス",
logined tinyint not null default 0 comment "ログインフラグ",
regist_date datetime not null comment "登録日時",
update_date datetime comment "更新日時"
)
default charset = utf8
comment="会員情報テーブル"
;

create table product_info(
id int primary key not null auto_increment comment "ID",
product_id int unique not null comment "商品ID",
product_name varchar(100) unique not null comment "商品名",
product_name_kana varchar(100) unique not null comment "商品名かな",
product_description varchar(255) comment "商品詳細",
category_id int not null comment "カテゴリID",
price int not null comment "値段",
image_file_path varchar(100) not null comment "画像ファイルパス",
image_file_name varchar(50) not null comment "画像ファイル名",
release_date datetime comment "発売年月",
release_company varchar(50) comment "発売会社",
status tinyint default 1 comment "ステータス",
regist_date datetime not null comment "登録日時",
update_date datetime comment "更新日時",
foreign key(category_id) references m_category(category_id)
)
default charset = utf8
comment ="商品情報テーブル"
;

create table cart_info(
id int primary key not null auto_increment comment "ID",
user_id varchar(16) not null comment "ユーザーID",
product_id int not null comment "商品ID",
product_count int not null comment "個数",
regist_date datetime not null comment "登録日時",
update_date datetime comment "更新日時",
foreign key(product_id) references product_info(product_id)
)
default charset=utf8
comment="カート情報テーブル"
;

create table purchase_history_info(
id int primary key not null auto_increment comment "ID",
user_id varchar(16) not null comment "ユーザーID",
product_id int not null comment "商品ID",
product_count int not null comment "個数",
price int not null comment "値段",
destination_id int not null comment "宛先情報ID",
regist_date datetime not null comment "登録日時",
update_date datetime comment "更新日時",
foreign key(user_id) references user_info(user_id),
foreign key(product_id) references product_info(product_id)
)
default charset=utf8
comment="購入履歴情報テーブル"
;

create table destination_info(
id int primary key not null auto_increment comment "ID",
user_id varchar(16) not null comment "ユーザーID",
family_name varchar(32) not null comment "姓",
first_name varchar(32) not null comment "名",
family_name_kana varchar(32) not null comment "姓かな",
first_name_kana varchar(32) not null comment "名かな",
email varchar(32) comment "メールアドレス",
tel_number varchar(13) comment "電話番号",
user_address varchar(50) not null comment "住所",
regist_date datetime not null comment "登録日時",
update_date datetime comment "更新日時",
foreign key(user_id)references user_info(user_id)
)
default charset = utf8
comment ="宛先情報テーブル"
;

create table m_category(
id int primary key not null auto_increment comment"ID",
category_id int not null unique comment "カテゴリID",
category_name varchar(20) not null unique comment "カテゴリ名",
category_description varchar(100) comment "カテゴリ詳細",
regist_date datetime not null comment "登録日時",
update_date datetime comment "更新日時"
)
default charset = utf8
comment ="カテゴリマスタテーブル"
;

insert into product_info values
( 1, 1,"人参","にんじん","人参の商品詳細",2,300,"./images","carrots.jpg",now(),"arizona農園",1,now(),now()),
( 2, 2,"コーヒー豆","こーひーまめ","コーヒー豆の商品詳細",2,500,"./images","coffee-beans.jpg",now(),"arizona農園",1,now(),now()),
( 3, 3,"ニンニク","にんにく","ニンニクの商品詳細",2,300,"./images","garlic.jpg",now(),"arizona農園",1,now(),now()),
( 4, 4,"苺のジュース","いちごのじゅーす","苺のジュースの商品詳細",2,100,"./images","smoothie.jpg",now(),"arizona農園",1,now(),now()),
( 5, 5,"トマト","とまと","トマトの商品詳細",2,200,"./images","tomatoes.jpg",now(),"arizona農園",1,now(),now()),
( 6,6,"クラリネット","くらりねっと","クラリネットの商品詳細",3,10000,"./images","clarinet.jpg",now(),"arizona楽器",1,now(),now()),
( 7,7,"エレキギター","えれきぎたー","エレキギターの商品詳細",3,10000,"./images","Electric guitar.jpg",now(),"arizona楽器",1,now(),now()),
( 8,8,"ギター","ぎたー","ギターの商品詳細",3,5000,"./images","guitar.jpg",now(),"arizona楽器",1,now(),now()),
( 9,9,"サックス","さっくす","サックスの商品詳細",3,10000,"./images","saxophone.jpg",now(),"arizona楽器",1,now(),now()),
( 10,10,"バイオリン","ばいおりん","バイオリンの商品詳細",3,15000,"./images","violin.jpg",now(),"arizona楽器",1,now(),now()),
( 11,11,"ブロック","ぶろっく","ブロックの商品詳細",4,500,"./images","block.jpg",now(),"arizona株式会社",1,now(),now()),
( 12,12,"チェス","ちぇす","チェスの商品詳細",4,700,"./images","chess.jpg",now(),"arizona株式会社",1,now(),now()),
( 13,13,"ダーツ","だーつ","ダーツの商品詳細",4,1000,"./images","darts.jpg",now(),"arizona株式会社",1,now(),now()),
( 14,14,"羊のぬいぐるみ","ひつじのぬいぐるみ","羊のぬいぐるみの商品詳細",4,500,"./images","Doll.jpg",now(),"arizona株式会社",1,now(),now()),
( 15,15,"ビー玉","びーだま","ビー玉の商品詳細",4,300,"./images","marbles.jpg",now(),"arizona株式会社",1,now(),now()),
( 16,16,"クレヨン","くれよん","クレヨンの商品詳細",5,200,"./images","crayon.jpg",now(),"arizona文具株式会社",1,now(),now()),
( 17,17,"ノート","のーと","ノートの商品詳細",5,150,"./images","notepad.jpg",now(),"arizona文具株式会社",1,now(),now()),
( 18,18,"クリップ","くりっぷ","クリップの商品詳細",5,100,"./images","paperclip.jpg",now(),"arizona文具株式会社",1,now(),now()),
( 19,19,"万年筆","まんねんひつ","万年筆の商品詳細",5,1000,"./images","pen.jpg",now(),"arizona文具株式会社",1,now(),now()),
( 20,20,"色鉛筆","いろえんぴつ","色鉛筆の商品詳細",5,300,"./images","pencil.jpg",now(),"arizona文具株式会社",1,now(),now());

insert into user_info values
(1,"guest","guest","インターノウス","ゲストユーザー","いんたーのうす","げすとゆーざー",0,"guest@gmail.com",1,0,now(),now()),
(2,"guest2","guest2","インターノウス","ゲストユーザー2","いんたーのうす","げすとゆーざー2",0,"guest2@gmail.com",0,0,now(),now()),
(3,"guest3","guest3","インターノウス","ゲストユーザー3","いんたーのうす","げすとゆーざー3",0,"guest3@gmail.com",0,0,now(),now()),
(4,"guest4","guest4","インターノウス","ゲストユーザー4","いんたーのうす","げすとゆーざー4",0,"guest4@gmail.com",0,0,now(),now()),
(5,"guest5","guest5","インターノウス","ゲストユーザー5","いんたーのうす","げすとゆーざー5",0,"guest5@gmail.com",0,0,now(),now()),
(6,"guest6","guest6","インターノウス","ゲストユーザー6","いんたーのうす","げすとゆーざー6",0,"guest6@gmail.com",0,0,now(),now()),
(7,"guest7","guest7","インターノウス","ゲストユーザー7","いんたーのうす","げすとゆーざー7",0,"guest7@gmail.com",0,0,now(),now()),
(8,"guest8","guest8","インターノウス","ゲストユーザー8","いんたーのうす","げすとゆーざー8",0,"guest8@gmail.com",0,0,now(),now()),
(9,"guest9","guest9","インターノウス","ゲストユーザー9","いんたーのうす","げすとゆーざー9",0,"guest9@gmail.com",0,0,now(),now()),
(10,"guest10","guest10","インターノウス","ゲストユーザー10","いんたーのうす","げすとゆーざー10",0,"guest10@gmail.com",0,0,now(),now()),
(11,"guest11","guest11","インターノウス","ゲストユーザー11","いんたーのうす","げすとゆーざー11",0,"guest11@gmail.com",0,0,now(),now()),
(12,"guest12","guest12","インターノウス","ゲストユーザー12","いんたーのうす","げすとゆーざー12",0,"guest12@gmail.com",0,0,now(),now());

insert into m_category values
(1,1,"全てのカテゴリー","食品・飲料、楽器、おもちゃ・ゲーム、文房具、全てのカテゴリーが対象となります",now(), now()),
(2,2,"食品・飲料","食品・飲料に関するカテゴリーが対象となります",now(),now()),
(3,3,"楽器","楽器に関するカテゴリーが対象となります",now(),now()),
(4,4,"おもちゃ・ゲーム","おもちゃ・ゲームに関するカテゴリーが対象となります",now(),now()),
(5,5,"文房具","文房具に関するカテゴリーが対象となります",now(),now());
