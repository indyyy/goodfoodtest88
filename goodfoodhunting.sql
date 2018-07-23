
CREATE DATABASE goodfoodhunting;

CREATE TABLE  dishes (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(100),
  image_url VARCHAR(400)
);

INSERT INTO dishes (name, image_url) values('birthday cake', 'https://www.google.com/search?q=birthday+cake+clint&client=safari&rls=en&source=lnms&tbm=isch&sa=X&ved=0ahUKEwje6JbaxqLcAhVTC6YKHf0WACgQ_AUICigB&biw=1199&bih=787#imgrc=Ux1MINZ4b02nCM:');

INSERT INTO dishes (name, image_url) values('clint cake', 'http://happybirthdaycakepic.com/Clint/8/happy-birthday-chocolate-cake');


values('ribs'INSERT INTO dishes (name, image_url) , 'https://www.mccormick.com/grill-mates/recipes/main-dishes/slow-and-low-memphis-pit-bbq-ribs');

CREATE TABLE comments (
  id SERIAL4 PRIMARY KEY,
  content TEXT NOT NULL, 
  dish_id INTEGER NOT NULL,
  FOREIGN KEY (dish_id) REFERENCES dishes (id) ON DELETE RESTRICT

 );

 insert into comments (content, dish_id) values('yum', 2);


 CREATE TABLE users (
   id SERIAL4 PRIMARY KEY,
   email VARCHAR(300), 
   password_digest VARCHAR(400)
 );

 
 ALTER TABLE dishes ADD COLUMN user_id INTEGER;

 CREATE TABLE likes (
   id SERIAL4 PRIMARY KEY,
   user_id INTEGER,
   dish_id INTEGER
 ); 

