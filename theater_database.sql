# Création de la DataBase

CREATE DATABASE IF NOT EXISTS theater_management;


# Création des tables nécessaires

CREATE TABLE Users
(
    id        INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    firstName VARCHAR(200)                   NOT NULL,
    lastName  VARCHAR(200)                   NOT NULL,
    email     VARCHAR(250)                   NOT NULL,
    password  VARCHAR(50)                    NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

CREATE TABLE Administrator
(
    id      INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_id INT             NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

CREATE TABLE Theater
(
    id            INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name          VARCHAR(50)                    NOT NULL,
    address       VARCHAR(100)                   NOT NULL,
    zipcode       INT(5)                         NOT NULL,
    city          VARCHAR(50)                    NOT NULL,
    administrator INT                            NOT NULL,
    FOREIGN KEY (administrator) REFERENCES Administrator (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

CREATE TABLE Projection_room
(
    id           INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    number_seats INT(11)                        NOT NULL,
    room_number  INT(11)                        NOT NULL,
    theater_id   INT                            NOT NULL,
    FOREIGN KEY (theater_id) REFERENCES Theater (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

CREATE TABLE Movie
(
    id       INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    title    VARCHAR(200)                   NOT NULL,
    genre    VARCHAR(100)                   NOT NULL,
    duration INT(3)                         NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

CREATE TABLE Screening
(
    id              INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    movie           INT                            NOT NULL,
    date            DATE                           NOT NULl,
    time            TIME                           NOT NULL,
    projection_room INT                            NOT NULL,
    theater         INT                            NOT NULL,
    FOREIGN KEY (movie) REFERENCES Movie (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (projection_room) REFERENCES Projection_room (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (theater) REFERENCES Theater (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

CREATE TABLE Price
(
    id          INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    description VARCHAR(200)                   NOT NULL,
    price       FLOAT(4, 2)                    NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

CREATE TABLE Booking
(
    id           INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    screening_id INT                            NOT NULL,
    user_id      INT                            NOT NULL,
    price_id     INT                            NOT NULL,
    quantity     INT(11)                        NOT NULL,
    FOREIGN KEY (screening_id) REFERENCES Screening (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (price_id) REFERENCES Price (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;


# Insertion des données factices
# Hash des mots de passe au préalable sur le site Bcrypt

INSERT INTO Users (firstName, lastName, email, password)
VALUES ('Linea', 'Benner', 'lbenner0@ucla.edu', '$2y$10$vfBdF58FIMqD0N8PnZqqUuZmkrQ/ke5QpAAL8PS4KsYvA3rR/yXOa');

INSERT INTO Users (firstName, lastName, email, password)
VALUES ('Otha', 'Oag', 'ooag1@ovh.net', '$2y$10$waFvshjVJ6q5Iz70qVEgT.xnC/LWIKONB43/YLK5.d4NIFi9664G2');

INSERT INTO Users (firstName, lastName, email, password)
VALUES ('Palmer', 'Dorant', 'pdorant2@homestead.com',
        '$2y$10$xwtflzfmnqDx9C1h5ed/Iu8wAax9TRnGcQaF4gU6QyW2hb5amLI2G');

INSERT INTO Users (firstName, lastName, email, password)
VALUES ('Ofella', 'Kimmings', 'okimmings0@wired.com',
        '$2y$10$rH6wfWn0KjMhoI6fjVzUxeRdyKOEBYJ5MCH1uQdQbHE7FrIBtbTtO');

INSERT INTO Users (firstName, lastName, email, password)
VALUES ('Rosene', 'Follos', 'rfollos0@arizona.edu', '$2y$10$KigIuFQOZdXErmAxE2CjJuUBdWDXU2o7sEza.Yfl8wc0gUGeeweFu');

INSERT INTO Users (firstName, lastName, email, password)
VALUES ('Trev', 'Gotcliff', 'tgotcliff1@theglobeandmail.com',
        '$2y$10$M9CIU9G3GUZHQUji6SwmFOIcl5OcW6FMs1lEwMMPYjJx8uL9DUM8C');



INSERT INTO Administrator (user_id)
VALUES (2);
INSERT INTO Administrator (user_id)
VALUES (6);
INSERT INTO Administrator (user_id)
VALUES (4);

GRANT INSERT, UPDATE ON Screening TO 'Administrator';

INSERT INTO Theater (name, address, zipcode, city, administrator)
VALUES ('Palais Central', '78925 Melby Court',
        '09220',
        'Sammatti', 1);
INSERT INTO Theater (name, address, zipcode, city, administrator)
VALUES ('Vision Cinema', '5112 West Court', '62150',
        'Grahamstown', 2);
INSERT INTO Theater (name, address, zipcode, city, administrator)
VALUES ('Grand Theater', '56 Dorton Circle', '85897',
        'Rukem', 3);

INSERT INTO Projection_room (number_seats, room_number, theater_id) VALUES (250, 05, 2);
INSERT INTO Projection_room (number_seats, room_number, theater_id) VALUES (160, 05, 2);
INSERT INTO Projection_room (number_seats, room_number, theater_id) VALUES (60, 05, 1);
INSERT INTO Projection_room (number_seats, room_number, theater_id) VALUES (200, 05, 1);
INSERT INTO Projection_room (number_seats, room_number, theater_id) VALUES (100, 05, 3);
INSERT INTO Projection_room (number_seats, room_number, theater_id) VALUES (80, 05, 3);

INSERT INTO Movie (title, genre, duration) VALUES ('Prince of Foxes', 'Adventure|Drama', 125);
INSERT INTO Movie (title, genre, duration) VALUES ('Lords of Flatbush, The', 'Comedy|Drama', 94);
INSERT INTO Movie (title, genre, duration) VALUES ('Day of the Dead 2: Contagium', 'Horror|Sci-Fi', 84);
INSERT INTO Movie (title, genre, duration) VALUES ('The Tenant of Wildfell Hall', 'Drama', 112);
INSERT INTO Movie (title, genre, duration) VALUES ('Chop Shop', 'Drama', 105);

INSERT INTO Screening (movie, date, time, projection_room, theater) VALUES (4,'2022-15-03', '13:30', 3, 1);
INSERT INTO Screening (movie, date, time, projection_room, theater) VALUES (1,'2022-11-03', '15:00', 6, 3);
INSERT INTO Screening (movie, date, time, projection_room, theater) VALUES (2,'2022-08-03', '20:30', 2, 2);
INSERT INTO Screening (movie, date, time, projection_room, theater) VALUES (5,'2022-10-03', '21:00', 4, 1);
INSERT INTO Screening (movie, date, time, projection_room, theater) VALUES (3,'2022-18-03', '16:15', 1, 2);
INSERT INTO Screening (movie, date, time, projection_room, theater) VALUES (4,'2022-12-03', '19:30', 5, 3);

INSERT INTO Price(description, price) VALUES ('Plein Tarif', 9.20);
INSERT INTO Price(description, price) VALUES ('étudiant', 7.60);
INSERT INTO Price(description, price) VALUES ('Moins de 14 ans', 5.90);

INSERT INTO Booking(screening_id, user_id, price_id, quantity) VALUES (3, 2, 1, 2);
INSERT INTO Booking(screening_id, user_id, price_id, quantity) VALUES (2, 6, 2, 4);
INSERT INTO Booking(screening_id, user_id, price_id, quantity) VALUES (1, 4, 3, 1);
INSERT INTO Booking(screening_id, user_id, price_id, quantity) VALUES (5, 1, 2, 2);
INSERT INTO Booking(screening_id, user_id, price_id, quantity) VALUES (6, 3, 2, 1);
INSERT INTO Booking(screening_id, user_id, price_id, quantity) VALUES (5, 1, 1, 3);

# Ligne de commande pour l'export de la Base de Données

mysql -h localhost -u root -p password theater_management > fichier_dump