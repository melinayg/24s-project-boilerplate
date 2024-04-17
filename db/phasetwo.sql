/*CREATE DATABASE GoMass;
USE GoMass;*/

CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Name TEXT,
    Age INT,
    Occupation VARCHAR(255),
    Hometown VARCHAR(255),
    Budget FLOAT,
    Dislikes TEXT,
    Likes TEXT,
    Gender VARCHAR(10),
    DietaryRestrictions TEXT,
    SubscriptionPlan TEXT,
    PaymentID INT,
    Paid VARCHAR(255),
    Free TEXT,
    PaymentMethod TEXT
);





CREATE TABLE User_Location (
    Location VARCHAR(255) PRIMARY KEY UNIQUE,
    UserID INT,
    CONSTRAINT fk_0
        FOREIGN KEY (UserID) REFERENCES User (UserID)
            ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Activity (
    ActivityID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE User_to_Activity(
    UserID INT,
    ActivityID INT,
    CONSTRAINT fk_1
        FOREIGN KEY (UserID) REFERENCES User (UserID)
            ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_2
        FOREIGN KEY (ActivityID) REFERENCES Activity (ActivityID)
            ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Interests_Hobbies (
    InterestHobbiesID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Physical          TEXT,
    Art               TEXT,
    Music             TEXT,
    Cooking           TEXT,
    UserID            INT,
    CONSTRAINT fk_3
        FOREIGN KEY (UserID) REFERENCES User (UserID)
            ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE PaymentPlan(
	PaymentID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
	Paid INT,
	PaymentMethod TEXT,
    UserID INT,
    CONSTRAINT fk_4
        FOREIGN KEY (UserID) REFERENCES User (UserID)
            ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE GroupAct (
    Group_Type_ID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Number_of_Friends INT,
    Group_Budget INT,
    UserID INT,
    ActivityID INT,
    CONSTRAINT fk_5
        FOREIGN KEY (UserID) REFERENCES User (UserID)
            ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_6
        FOREIGN KEY (ActivityID) REFERENCES Activity(ActivityID)
            ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Group_Meeting (
    Meeting_Time VARCHAR(7) PRIMARY KEY UNIQUE,
    Group_Type_ID INT,
    CONSTRAINT fk_7
        FOREIGN KEY (Group_Type_ID) REFERENCES GroupAct (Group_Type_ID)
            ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Destination (
    Address VARCHAR(255) PRIMARY KEY UNIQUE,
    Street VARCHAR(255),
    Zipcode VARCHAR(10),
    City VARCHAR(255),
    State VARCHAR(255),
    Distance VARCHAR(255),
    Proximity ENUM('long', 'med', 'short'),
    WeatherRecommendations TEXT
);

CREATE TABLE Destination_location (
    Location VARCHAR(255) PRIMARY KEY UNIQUE,
    Address VARCHAR(255),
    CONSTRAINT fk_8
        FOREIGN KEY (Address) REFERENCES Destination(Address)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Transportation (
   TransportationID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
   Budget Float,
   CleanlinessSafety VarChar(255)
);


CREATE TABLE User_to_Transpo (
    UserID INT,
    TransportationID INT,
    CONSTRAINT fk_9
        FOREIGN KEY (UserID) REFERENCES User (UserID)
            ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_10
        FOREIGN KEY (TransportationID) REFERENCES Transportation (TransportationID)
            ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE User_Des (
    Address VARCHAR(255),
    UserID INT,
    CONSTRAINT fk_11
        FOREIGN KEY (UserID) REFERENCES User (UserID)
            ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_12
        FOREIGN KEY (Address) REFERENCES Destination (Address)
            ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE TransportationType (
    Type_of_Transpo VARCHAR(255) PRIMARY KEY UNIQUE,
    TransportationID INT,
    CONSTRAINT fk_13
        FOREIGN KEY (TransportationID) REFERENCES Transportation(TransportationID)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Destination_to_Transportation (
    TransportationID INT,
    Address VARCHAR(255),
    CONSTRAINT fk_14
        FOREIGN KEY (TransportationID) REFERENCES Transportation(TransportationID)
	    ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_15
        FOREIGN KEY (Address) REFERENCES Destination(Address)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Restaurants(
    RestaurantID INT PRIMARY KEY AUTO_INCREMENT,
    Name TEXT,
    Reservations INT,
    CuisineType TEXT,
    PriceTag VARCHAR(5),
    Location TEXT,
    ActivityTypeID INT,
    CONSTRAINT fk_16
        FOREIGN KEY (ActivityTypeID) REFERENCES Activity(ActivityID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE Restaurant_Location (
    Location VARCHAR(255) PRIMARY KEY UNIQUE,
    RestaurantID INT,
    CONSTRAINT fk_17
        FOREIGN KEY (RestaurantID) REFERENCES Restaurants (RestaurantID)
            ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Cafes (
    CafeID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Cuisine TEXT,
    Name TEXT,
    OverallRating INT,
    ActivityTypeID INT,
    PriceTag VARCHAR(5),
    CONSTRAINT fk_18
	    FOREIGN KEY (ActivityTypeID) REFERENCES Activity(ActivityID)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Cafe_Location (
    Location VARCHAR(255) PRIMARY KEY UNIQUE,
    CafeID INT,
    CONSTRAINT fk_19
	    FOREIGN KEY (CafeID) REFERENCES Cafes(CafeID)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE MusicFestivals(
	FestivalID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
	Name TEXT,
	MusicType TEXT,
	CrowdSize INT,
	Location TEXT,
	OverallRating INT,
    PriceTag VARCHAR(5),
	ActivityTypeID INT,
	CONSTRAINT fk_20
	    FOREIGN KEY (ActivityTypeID) REFERENCES Activity(ActivityID)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Music_Festivals_Artists (
    Artists VARCHAR(255) PRIMARY KEY UNIQUE,
    FestivalID INT,
    CONSTRAINT fk_21
	    FOREIGN KEY (FestivalID) REFERENCES MusicFestivals(FestivalID)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Shopping (
    ShoppingID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Name VARCHAR(255) NOT NULL,
    PriceTag VARCHAR(5),
    Shopping_Area_Size VARCHAR(255),
    OverallRating INT,
    ActivityTypeID INT,
    CONSTRAINT fk_22
	    FOREIGN KEY (ActivityTypeID) REFERENCES Activity(ActivityID)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Shopping_Location (
    Location VARCHAR(255) PRIMARY KEY UNIQUE,
    ShoppingID INT,
    CONSTRAINT fk_23
	    FOREIGN KEY (ShoppingID) REFERENCES Shopping(ShoppingID)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Outdoor_Activity (
    OutdoorID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Name VARCHAR(255),
    Difficulty_level VARCHAR(255),
    Danger_level VARCHAR(255),
    Experience VARCHAR(255),
    Location VARCHAR(255),
    PriceTag VARCHAR(5),
    ActivityTypeID INT,
    CONSTRAINT fk_24
	    FOREIGN KEY (ActivityTypeID) REFERENCES Activity(ActivityID)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Outdoor_Activity_Location (
    Location VARCHAR(255) PRIMARY KEY UNIQUE,
    OutdoorID INT,
    CONSTRAINT fk_25
	    FOREIGN KEY (OutdoorID) REFERENCES Outdoor_Activity(OutdoorID)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Movies (
    MovieID INT PRIMARY KEY AUTO_INCREMENT,
    TheaterLocation VARCHAR(255),
    Name VARCHAR(255) NOT NULL,
    OverallRating DECIMAL(3, 1),
    Genre VARCHAR(255),
    PriceTag VARCHAR(5),
    Activity_Type_ID INT,
    FOREIGN KEY (Activity_Type_ID) REFERENCES Activity(ActivityID)
);


CREATE TABLE ArtsMuseums (
    ArtMuseumID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Name TEXT,
    ArtType TEXT,
    CollegeStudents INT,
    PriceTag VARCHAR(5),
    OverallRating CHAR(5),
    Location VARCHAR(255),
    ActivityTypeID INT,
    CONSTRAINT fk_26
	    FOREIGN KEY (ActivityTypeID) REFERENCES Activity(ActivityID)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE ArtMuseumsLocation (
    Location VARCHAR(255) PRIMARY KEY UNIQUE,
    ArtMuseumID INT,
    CONSTRAINT fk_27
	    FOREIGN KEY (ArtMuseumID) REFERENCES ArtsMuseums(ArtMuseumID)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO User (Name, Age, Occupation, Hometown, Budget, Dislikes, Likes, Gender, DietaryRestrictions, SubscriptionPlan, PaymentID, Paid, Free, PaymentMethod)
VALUES ('Michael Smith', 30, 'Software Developer', 'Boston', 1500.00, 'Crowds, Loud music', 'Hiking, Reading', 'Male', 'None', 'Monthly', 1, 'Yes', 'No', 'Credit Card');

INSERT INTO User (Name, Age, Occupation, Hometown, Budget, Dislikes, Likes, Gender, DietaryRestrictions, SubscriptionPlan, PaymentID, Paid, Free, PaymentMethod)
VALUES ('Timothee Chalamet', 28, 'Actor', 'Boston', 1500.00, 'Crowds, Loud music', 'Hiking, Reading, Singing, SNL', 'Male', 'None', 'Monthly', 1, 'Yes', 'No', 'Credit Card');



INSERT INTO User (Name, Age, Occupation, Hometown, Budget, Dislikes, Likes, Gender, DietaryRestrictions, SubscriptionPlan, PaymentID, Paid, Free, PaymentMethod)
VALUES ('Jane Smith', 28, 'Artist', 'Cambridge', 1200.00, 'Spicy food', 'Art, Music concerts', 'Female', 'Vegetarian', 'Annual', 2, 'Yes', 'No', 'PayPal');


INSERT INTO User_Location (Location, UserID) VALUES ('Boston, MA', 1);
INSERT INTO User_Location (Location, UserID) VALUES ('Cambridge, MA', 2);


INSERT INTO Activity (Name) VALUES ('Hiking');
INSERT INTO Activity (Name) VALUES ('Coding');


INSERT INTO User_to_Activity (UserID, ActivityID) VALUES (1, 1);
INSERT INTO User_to_Activity (UserID, ActivityID) VALUES (2, 2);


INSERT INTO Interests_Hobbies (Physical, Art, Music, Cooking, UserID) VALUES ('Running', 'Painting', 'Classical', 'Italian', 1);
INSERT INTO Interests_Hobbies (Physical, Art, Music, Cooking, UserID) VALUES ('Yoga', 'Digital Art', 'Electronic', 'Japanese', 2);


INSERT INTO PaymentPlan (Paid, PaymentMethod, UserID) VALUES (300, 'Credit Card', 1);
INSERT INTO PaymentPlan (Paid, PaymentMethod, UserID) VALUES (0, 'PayPal', 2);


INSERT INTO GroupAct (Number_of_Friends, Group_Budget, UserID, ActivityID) VALUES (5, 500, 1, 1);
INSERT INTO GroupAct (Number_of_Friends, Group_Budget, UserID, ActivityID) VALUES (3, 300, 2, 2);


INSERT INTO Group_Meeting (Meeting_Time, Group_Type_ID) VALUES ('12:00', 1);
INSERT INTO Group_Meeting (Meeting_Time, Group_Type_ID) VALUES ('2:00', 2);


INSERT INTO Destination (Address, Street, Zipcode, City, State, Distance, Proximity, WeatherRecommendations) VALUES ('123 Main St', 'Main Street', '12345', 'Metropolis', 'MA', '10 miles', 'short', 'Sunny days recommended');
INSERT INTO Destination (Address, Street, Zipcode, City, State, Distance, Proximity, WeatherRecommendations) VALUES ('456 Side St', 'Side Street', '67890', 'Gotham', 'MA', '20 miles', 'med', 'Rainy days possible');


INSERT INTO Destination_location (Location, Address) VALUES ('Central Park', '123 Main St');
INSERT INTO Destination_location (Location, Address) VALUES ('Gotham Marina', '456 Side St');


INSERT INTO Transportation (Budget, CleanlinessSafety) VALUES (100.00, 'High');
INSERT INTO Transportation (Budget, CleanlinessSafety) VALUES (150.00, 'Medium');


INSERT INTO User_to_Transpo (UserID, TransportationID) VALUES (1, 1);
INSERT INTO User_to_Transpo (UserID, TransportationID) VALUES (2, 2);


INSERT INTO User_Des (Address, UserID) VALUES ('123 Main St', 1);
INSERT INTO User_Des (Address, UserID) VALUES ('456 Side St', 2);


INSERT INTO TransportationType (Type_of_Transpo, TransportationID) VALUES ('Bus', 1);
INSERT INTO TransportationType (Type_of_Transpo, TransportationID) VALUES ('Train', 2);


INSERT INTO Destination_to_Transportation (TransportationID, Address) VALUES (1, '123 Main St');
INSERT INTO Destination_to_Transportation (TransportationID, Address) VALUES (2, '456 Side St');


INSERT INTO Restaurants (Name, Reservations, CuisineType, PriceTag, Location, ActivityTypeID) VALUES ('The Fancy Feast', 20, 'French', '$$$', '123 Gourmet Alley', 1);
INSERT INTO Restaurants (Name, Reservations, CuisineType, PriceTag, Location, ActivityTypeID) VALUES ('Burger Barn', 50, 'American', '$', '456 Fast Food Way', 2);


INSERT INTO Restaurant_Location (Location, RestaurantID) VALUES ('Gourmet Alley', 1);
INSERT INTO Restaurant_Location (Location, RestaurantID) VALUES ('Fast Food Way', 2);


INSERT INTO Cafes (Cuisine, Name, OverallRating, PriceTag, ActivityTypeID) VALUES ('Italian', 'Cafe Roma', 5,'$$', 1);
INSERT INTO Cafes (Cuisine, Name, OverallRating, PriceTag, ActivityTypeID) VALUES ('French', 'Le Petit Cafe', 4,'$',2);


INSERT INTO Cafe_Location (Location, CafeID) VALUES ('Downtown District', 1);
INSERT INTO Cafe_Location (Location, CafeID) VALUES ('Historic Center', 2);


INSERT INTO MusicFestivals (Name, MusicType, CrowdSize, Location, OverallRating, PriceTag, ActivityTypeID) VALUES ('Summer Sounds', 'Pop', 10000, 'Beachside', 5, '$$',1);
INSERT INTO MusicFestivals (Name, MusicType, CrowdSize, Location, OverallRating, PriceTag, ActivityTypeID) VALUES ('Rock Riot', 'Rock', 5000, 'Downtown', 4, '$$', 2);


INSERT INTO Music_Festivals_Artists (Artists, FestivalID) VALUES ('The Zephyrs', 1);
INSERT INTO Music_Festivals_Artists (Artists, FestivalID) VALUES ('Guitar Heroes', 2);




INSERT INTO Shopping (Name, PriceTag, Shopping_Area_Size, OverallRating, ActivityTypeID) VALUES ('Zara', '$$$', 'Large', 5, 1);
INSERT INTO Shopping (Name, PriceTag, Shopping_Area_Size, OverallRating, ActivityTypeID) VALUES ('Sephora', '$$$', 'Medium', 4, 2);


INSERT INTO Shopping_Location (Location, ShoppingID) VALUES ('City Center', 1);
INSERT INTO Shopping_Location (Location, ShoppingID) VALUES ('Riverside', 2);


INSERT INTO Outdoor_Activity (Name, Difficulty_level, Danger_level, Experience, Location, PriceTag, ActivityTypeID) VALUES ('Mountain Biking', 'High', 'Medium', 'Expert', 'Trail Park', '$$', 1);
INSERT INTO Outdoor_Activity (Name, Difficulty_level, Danger_level, Experience, Location, PriceTag, ActivityTypeID) VALUES ('Kayaking', 'Medium', 'Low', 'Beginner', 'River Run', '$', 2);


INSERT INTO Outdoor_Activity_Location (Location, OutdoorID) VALUES ('Trail Park', 1);
INSERT INTO Outdoor_Activity_Location (Location, OutdoorID) VALUES ('River Run', 2);


INSERT INTO ArtsMuseums (PriceTag, Name, ArtType, CollegeStudents, OverallRating, ActivityTypeID) VALUES ('$', 'Modern Art Museum', 'Modern', 500, 'A', 1);
INSERT INTO ArtsMuseums (PriceTag, Name, ArtType, CollegeStudents, OverallRating, ActivityTypeID) VALUES ('$', 'History Museum', 'Historical', 300, 'A-', 2);


INSERT INTO ArtMuseumsLocation (Location, ArtMuseumID) VALUES ('Cultural District', 1);
INSERT INTO ArtMuseumsLocation (Location, ArtMuseumID) VALUES ('Old Town', 2);


INSERT INTO Movies (TheaterLocation, Name, OverallRating, Genre, PriceTag, Activity_Type_ID)
VALUES ('Downtown Cinema', 'Inception', 8.8, 'Science Fiction', '$',  1);

INSERT INTO Movies (TheaterLocation, Name, OverallRating, Genre, PriceTag, Activity_Type_ID)
VALUES ('Riverside Theater', 'The Dark Knight', 9.0, 'Action','$', 2);


/* INSERT STATEMENTS */

USE 'GoMass';

/* Activity */
insert into Activity  (ActivityID) values (1);
insert into Activity  (ActivityID) values (2);
insert into Activity  (ActivityID) values (3);
insert into Activity  (ActivityID) values (4);
insert into Activity  (ActivityID) values (5);
insert into Activity  (ActivityID) values (6);
insert into Activity  (ActivityID) values (7);
insert into Activity  (ActivityID) values (8);

/* User */
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (1, 4, 'Constancy Hargess', 'baker', 'Female', '321 Maple Dr Riverdale GA', 'funny movies', 'adventure movies', 'none', 1, 200, 'Apple Pay', 203);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (2, 26, 'Cherlyn Bernolet', 'unemployed', 'Female', '321 Walnut Ave Springfield MO', 'adventure movies', 'quiet areas', 'vegan', 2, 187, 'Credit Card', 227);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (3, 32, 'Stephanus Bonds', 'student', 'Male', '789 Ash Dr Cincinnati OH', 'good study areas', 'good study areas', 'none', 3, 400, 'Debit Card', 222);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (4, 47, 'Bennie Bollon', 'baker', 'Male', '321 Oak St Seattle WA', 'loud areas', 'funny movies', 'gluten free', 4, 425, 'Paypal', 80);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (5, 44, 'Melitta Stoller', 'fire fighter', 'Genderqueer', '987 Maple St Nashville TN', 'romance movies', 'Thai restaurant', 'vegan', 5, 92, 'Venmo', 247);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (6, 54, 'Sukey Younglove', 'teacher', 'Female', '987 Cedar Ave Boise ID', 'adventure movies', 'loud areas', 'paleo', 6, 225, 'Debit Card', 50);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (7, 9, 'Doloritas Gonzales', 'unemployed', 'Female', '654 Poplar St Baltimore MD', 'quiet areas', 'savory food', 'vegetarian', 7, 406, 'Paypal', 28);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (8, 11, 'Jereme Tams', 'unemployed', 'Male', '789 Elm Dr Philadelphia PA', 'savory food', 'quiet areas', 'none', 8, 53, 'Debit Card', 115);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (9, 32, 'Derk Toulch', 'unemployed', 'Male', '321 Oak St Seattle WA', 'quiet areas', 'romance movies', 'kosher', 9, 373, 'Venmo', 257);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (10, 16, 'Rupert Relph', 'unemployed', 'Male', '123 Ash St Denver CO', 'expensive places', 'Thai restaurant', 'vegetarian', 10, 479, 'Credit Card', 293);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (11, 2, 'Ferguson Holleran', 'teacher', 'Male', '321 Birch Ave Orlando FL', 'good study areas', 'adventure movies', 'none', 11, 191, 'Paypal', 219);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (12, 14, 'Romy Brood', 'teacher', 'Female', '456 Elm St St. Louis MO', 'Thai restaurant', 'loud areas', 'none', 12, 108, 'Debit Card', 179);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (13, 21, 'Zacherie Pendrid', 'unemployed', 'Male', '789 Elm Dr Philadelphia PA', 'funny movies', 'Thai restaurant', 'vegan', 13, 418, 'Paypal', 17);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (14, 54, 'Twyla Mein', 'unemployed', 'Female', '456 Elm St Springfield IL', 'romance movies', 'spicy food', 'lactose intolerance', 14, 363, 'Paypal', 223);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (15, 4, 'Sherlock Durrad', 'data scientist', 'Male', '321 Oak Ave Oklahoma City OK', 'Chinese restaurant', 'romance movies', 'vegetarian', 15, 317, 'Credit Card', 267);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (16, 36, 'Leela Heynel', 'data scientist', 'Female', '654 Poplar St Baltimore MD', 'sweet food', 'good study areas', 'none', 16, 384, 'Apple Pay', 201);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (17, 37, 'Chrystal Siman', 'police officer', 'Female', '321 Walnut Ave Springfield MO', 'spicy food', 'cheap places', 'gluten free', 17, 141, 'Apple Pay', 90);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (18, 38, 'Emalee Soldan', 'police officer', 'Female', '456 Elm Dr Minneapolis MN', 'spicy food', 'quiet areas', 'vegetarian', 18, 376, 'Venmo', 299);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (19, 38, 'Veda Robardet', 'baker', 'Female', '987 Oak Ave Charlotte NC', 'Thai restaurant', 'Thai restaurant', 'none', 19, 441, 'Credit Card', 221);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (20, 51, 'Dede Scudamore', 'police officer', 'Non-binary', '321 Main Ave Dallas TX', 'Chinese restaurant', 'Thai restaurant', 'none', 20, 442, 'Debit Card', 159);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (21, 51, 'Glen Sawforde', 'professor', 'Male', '987 Oak St Phoenix AZ', 'savory food', 'savory food', 'paleo', 21, 354, 'Credit Card', 279);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (22, 19, 'Nathanil Walbrook', 'unemployed', 'Male', '987 Oak Ave Charlotte NC', 'loud areas', 'adventure movies', 'none', 22, 313, 'Venmo', 18);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (23, 24, 'Wallie Allitt', 'unemployed', 'Male', '987 Elm St Raleigh NC', 'adventure movies', 'funny movies', 'none', 23, 67, 'Venmo', 108);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (24, 50, 'Che Lafayette', 'data scientist', 'Male', '987 Oak St Phoenix AZ', 'good study areas', 'romance movies', 'none', 24, 107, 'Venmo', 126);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (25, 55, 'Freedman Rhelton', 'unemployed', 'Male', '321 Ash St Madison WI', 'quiet areas', 'expensive places', 'vegan', 25, 257, 'Debit Card', 151);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (26, 17, 'Ephrem Commusso', 'fire fighter', 'Male', '789 Walnut St Cleveland OH', 'quiet areas', 'quiet areas', 'gluten free', 26, 163, 'Apple Pay', 158);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (27, 23, 'Carleen Merigon', 'unemployed', 'Female', '987 Oak Ave Charlotte NC', 'Thai restaurant', 'adventure movies', 'none', 27, 440, 'Apple Pay', 194);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (28, 31, 'Biddie Vaux', 'unemployed', 'Female', '456 Elm St Springfield IL', 'music', 'romance movies', 'gluten free', 28, 196, 'Paypal', 207);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (29, 40, 'Theodore Devenport', 'police officer', 'Male', '456 Elm St St. Louis MO', 'quiet areas', 'adventure movies', 'none', 29, 367, 'Venmo', 121);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (30, 15, 'Marjorie McGowan', 'teacher', 'Female', '654 Ash Dr San Diego CA', 'sweet food', 'savory food', 'lactose intolerance', 30, 96, 'Debit Card', 16);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (31, 29, 'Drugi Dickins', 'police officer', 'Male', '789 Walnut St Cleveland OH', 'loud areas', 'sweet food', 'gluten free', 31, 486, 'Apple Pay', 65);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (32, 6, 'Jeanette Dinzey', 'fire fighter', 'Female', '321 Cedar St Indianapolis IN', 'Thai restaurant', 'spicy food', 'kosher', 32, 82, 'Credit Card', 52);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (33, 34, 'Johnette Bramich', 'unemployed', 'Female', '321 Birch Ave Orlando FL', 'sweet food', 'sweet food', 'gluten free', 33, 274, 'Debit Card', 75);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (34, 13, 'Nowell Sange', 'data scientist', 'Male', '789 Pine Dr Boston MA', 'romance movies', 'loud areas', 'none', 34, 75, 'Venmo', 167);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (35, 48, 'Vance Gawkroge', 'unemployed', 'Male', '789 Elm Dr Philadelphia PA', 'spicy food', 'sweet food', 'vegan', 35, 92, 'Paypal', 286);
insert into User (UserID, Age, Name,  Occupation, gender, Hometown, Dislikes, Likes, DietaryRestrictions, PaymentID, Balance, PaymentMethod, Budget) values (36, 28, 'Timothee Chamalet', 'Actor', 'Male', '123 Hollywood Boulevard Boston MA', 'spicy food', 'sweet food, movies', 'vegan', 35, 92, 'Paypal', 286);

/* user location */
insert into User_Location (Location, UserID) values ('789 Birch St Boston MA', '15');
insert into User_Location (Location, UserID) values ('321 Cedar St Boston MA', '9');
insert into User_Location (Location, UserID) values ('456 Elm St Boston MA', '32');
insert into User_Location (Location, UserID) values ('654 Walnutwood Ct Somerville MA', '12');
insert into User_Location (Location, UserID) values ('654 Walnutwood Ct Somerville MA', '28');
insert into User_Location (Location, UserID) values ('321 Maplewood Dr Somerville MA', '4');
insert into User_Location (Location, UserID) values ('789 Walnut St Boston MA', '22');
insert into User_Location (Location, UserID) values ('456 Elm St Boston MA', '6');
insert into User_Location (Location, UserID) values ('765 Park St Rivertown MA', '24');
insert into User_Location (Location, UserID) values ('456 Elm St Boston MA', '21');
insert into User_Location (Location, UserID) values ('123 Elm St Boston MA', '10');
insert into User_Location (Location, UserID) values ('543 Birchwood Ave Cambridge MA', '18');
insert into User_Location (Location, UserID) values ('321 Cedar St Boston MA', '33');
insert into User_Location (Location, UserID) values ('654 Walnut Grove Ct Springfield MA', '25');
insert into User_Location (Location, UserID) values ('654 Walnutwood Ct Somerville MA', '2');
insert into User_Location (Location, UserID) values ('789 Birchwood Ln Springfield MA', '17');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Somerville MA', '27');
insert into User_Location (Location, UserID) values ('321 Maplewood Dr Springfield MA', '8');
insert into User_Location (Location, UserID) values ('321 Cedarhurst Ln Cambridge MA', '29');
insert into User_Location (Location, UserID) values ('234 Forest Rd Rivertown MA', '13');
insert into User_Location (Location, UserID) values ('654 Pineview Rd Cambridge MA', '26');
insert into User_Location (Location, UserID) values ('432 Riverside Cir Rivertown MA', '7');
insert into User_Location (Location, UserID) values ('543 Birchwood Ave Cambridge MA', '20');
insert into User_Location (Location, UserID) values ('098 Chestnutwood Rd Springfield MA', '30');
insert into User_Location (Location, UserID) values ('321 Maplewood Dr Springfield MA', '3');
insert into User_Location (Location, UserID) values ('789 Pine St Boston MA', '31');
insert into User_Location (Location, UserID) values ('765 Elmwood St Cambridge MA', '14');
insert into User_Location (Location, UserID) values ('543 Birchwood Ave Cambridge MA', '1');
insert into User_Location (Location, UserID) values ('789 Meadow Ln Rivertown MA', '23');
insert into User_Location (Location, UserID) values ('234 Pinehurst Rd Somerville MA', '19');
insert into User_Location (Location, UserID) values ('321 Maplewood Dr Springfield MA', '11');
insert into User_Location (Location, UserID) values ('789 Pine St Boston MA', '16');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Springfield MA', '34');
insert into User_Location (Location, UserID) values ('098 Chestnutwood Rd Springfield MA', '35');
insert into User_Location (Location, UserID) values ('987 Oak Ave Boston MA', '5');
insert into User_Location (Location, UserID) values ('789 Meadow Ln Rivertown MA', '24');
insert into User_Location (Location, UserID) values ('321 Valley Dr Rivertown MA', '35');
insert into User_Location (Location, UserID) values ('987 Elmwood Park Cambridge MA', '11');
insert into User_Location (Location, UserID) values ('098 Pine Hill Rd Rivertown MA', '13');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Somerville MA', '1');
insert into User_Location (Location, UserID) values ('456 Lakeview Ave Rivertown MA', '34');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Somerville MA', '12');
insert into User_Location (Location, UserID) values ('456 Chestnutview Ave Somerville MA', '23');
insert into User_Location (Location, UserID) values ('321 Cedar St Boston MA', '3');
insert into User_Location (Location, UserID) values ('654 Ash St Boston MA', '9');
insert into User_Location (Location, UserID) values ('654 Poplar St Boston MA', '26');
insert into User_Location (Location, UserID) values ('890 Lakeside Way Rivertown MA', '14');
insert into User_Location (Location, UserID) values ('789 Meadow Ln Rivertown MA', '29');
insert into User_Location (Location, UserID) values ('654 Walnutwood Ct Somerville MA', '6');
insert into User_Location (Location, UserID) values ('432 Poplarview Cir Springfield MA', '16');
insert into User_Location (Location, UserID) values ('987 Elmwood Park Cambridge MA', '18');
insert into User_Location (Location, UserID) values ('123 Pine Ave Boston MA', '30');
insert into User_Location (Location, UserID) values ('321 Maplewood Dr Springfield MA', '28');
insert into User_Location (Location, UserID) values ('123 Pine Ave Boston MA', '33');
insert into User_Location (Location, UserID) values ('098 Chestnut Hill Rd Cambridge MA', '22');
insert into User_Location (Location, UserID) values ('789 Birchwood Ln Springfield MA', '21');
insert into User_Location (Location, UserID) values ('456 Ashland Ave Cambridge MA', '7');
insert into User_Location (Location, UserID) values ('567 Summit Blvd Rivertown MA', '5');
insert into User_Location (Location, UserID) values ('321 Valley Dr Rivertown MA', '25');
insert into User_Location (Location, UserID) values ('123 Pine Ave Boston MA', '32');
insert into User_Location (Location, UserID) values ('765 Elmwood St Cambridge MA', '27');
insert into User_Location (Location, UserID) values ('456 Ash St Boston MA', '10');
insert into User_Location (Location, UserID) values ('098 Pine Hill Rd Rivertown MA', '20');
insert into User_Location (Location, UserID) values ('456 Ashland Ave Cambridge MA', '31');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Somerville MA', '2');
insert into User_Location (Location, UserID) values ('789 Birch St Boston MA', '4');
insert into User_Location (Location, UserID) values ('098 Pine Hill Rd Rivertown MA', '15');
insert into User_Location (Location, UserID) values ('432 Poplarview Cir Springfield MA', '19');
insert into User_Location (Location, UserID) values ('765 Elmwood St Springfield MA', '17');
insert into User_Location (Location, UserID) values ('654 Walnut Grove Ct Springfield MA', '8');
insert into User_Location (Location, UserID) values ('987 Oak Ave Boston MA', '20');
insert into User_Location (Location, UserID) values ('789 Birchwood Ln Springfield MA', '9');
insert into User_Location (Location, UserID) values ('109 Walnut Grove Ln Cambridge MA', '19');
insert into User_Location (Location, UserID) values ('765 Elmwood St Cambridge MA', '6');
insert into User_Location (Location, UserID) values ('789 Pine St Boston MA', '7');
insert into User_Location (Location, UserID) values ('098 Pine Hill Rd Rivertown MA', '32');
insert into User_Location (Location, UserID) values ('987 Brookside Pl Rivertown MA', '23');
insert into User_Location (Location, UserID) values ('321 Valley Dr Rivertown MA', '34');
insert into User_Location (Location, UserID) values ('789 Birch St Boston MA', '30');
insert into User_Location (Location, UserID) values ('234 Pinehurst Rd Springfield MA', '24');
insert into User_Location (Location, UserID) values ('098 Pine Hill Rd Rivertown MA', '4');
insert into User_Location (Location, UserID) values ('098 Pine Hill Rd Rivertown MA', '29');
insert into User_Location (Location, UserID) values ('987 Ashland Pl Somerville MA', '35');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Somerville MA', '21');
insert into User_Location (Location, UserID) values ('876 Maplewood Dr Cambridge MA', '18');
insert into User_Location (Location, UserID) values ('321 Cedar St Boston MA', '13');
insert into User_Location (Location, UserID) values ('432 Riverside Cir Rivertown MA', '26');
insert into User_Location (Location, UserID) values ('234 Pinehurst Rd Somerville MA', '17');
insert into User_Location (Location, UserID) values ('321 Valley Dr Rivertown MA', '33');
insert into User_Location (Location, UserID) values ('654 Poplar St Boston MA', '5');
insert into User_Location (Location, UserID) values ('456 Ash St Boston MA', '16');
insert into User_Location (Location, UserID) values ('456 Chestnut Hill Ave Springfield MA', '27');
insert into User_Location (Location, UserID) values ('321 Maplewood Dr Springfield MA', '10');
insert into User_Location (Location, UserID) values ('321 Cedarhurst Ln Cambridge MA', '28');
insert into User_Location (Location, UserID) values ('543 Maple Ave Rivertown MA', '11');
insert into User_Location (Location, UserID) values ('654 Hillside Ct Rivertown MA', '31');
insert into User_Location (Location, UserID) values ('456 Ash St Boston MA', '15');
insert into User_Location (Location, UserID) values ('876 Maplewood Dr Cambridge MA', '3');
insert into User_Location (Location, UserID) values ('987 Oak Ave Boston MA', '14');
insert into User_Location (Location, UserID) values ('109 Walnut Grove Ln Cambridge MA', '8');
insert into User_Location (Location, UserID) values ('432 Riverside Cir Rivertown MA', '22');
insert into User_Location (Location, UserID) values ('654 Poplar St Boston MA', '2');
insert into User_Location (Location, UserID) values ('234 Pinehurst Rd Somerville MA', '1');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Springfield MA', '12');
insert into User_Location (Location, UserID) values ('765 Elmwood St Springfield MA', '25');
insert into User_Location (Location, UserID) values ('890 Lakeside Way Rivertown MA', '16');
insert into User_Location (Location, UserID) values ('321 Maplewood Dr Somerville MA', '17');
insert into User_Location (Location, UserID) values ('234 Forest Rd Rivertown MA', '5');
insert into User_Location (Location, UserID) values ('654 Oak St Boston MA', '28');
insert into User_Location (Location, UserID) values ('789 Birchwood Ln Springfield MA', '35');
insert into User_Location (Location, UserID) values ('789 Birchwood Ln Springfield MA', '24');
insert into User_Location (Location, UserID) values ('543 Birchwood Ave Cambridge MA', '33');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Springfield MA', '23');
insert into User_Location (Location, UserID) values ('567 Summit Blvd Rivertown MA', '34');
insert into User_Location (Location, UserID) values ('543 Maple Ave Rivertown MA', '14');
insert into User_Location (Location, UserID) values ('456 Ashland Ave Cambridge MA', '8');
insert into User_Location (Location, UserID) values ('456 Elm St Boston MA', '32');
insert into User_Location (Location, UserID) values ('456 Chestnutview Ave Somerville MA', '27');
insert into User_Location (Location, UserID) values ('987 Maple St Boston MA', '4');
insert into User_Location (Location, UserID) values ('234 Pinehurst Rd Somerville MA', '1');
insert into User_Location (Location, UserID) values ('321 Valley Dr Rivertown MA', '25');
insert into User_Location (Location, UserID) values ('432 Riverside Cir Rivertown MA', '18');
insert into User_Location (Location, UserID) values ('321 Cedar St Boston MA', '20');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Somerville MA', '15');
insert into User_Location (Location, UserID) values ('321 Valley Dr Rivertown MA', '2');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Springfield MA', '29');
insert into User_Location (Location, UserID) values ('456 Ash St Boston MA', '3');
insert into User_Location (Location, UserID) values ('789 Birchwood Ln Springfield MA', '11');
insert into User_Location (Location, UserID) values ('123 Elm St Boston MA', '9');
insert into User_Location (Location, UserID) values ('543 Birchwood Ave Cambridge MA', '6');
insert into User_Location (Location, UserID) values ('456 Lakeview Ave Rivertown MA', '7');
insert into User_Location (Location, UserID) values ('123 Walnut St Boston MA', '26');
insert into User_Location (Location, UserID) values ('321 Maplewood Dr Springfield MA', '31');
insert into User_Location (Location, UserID) values ('876 Maplewood Dr Cambridge MA', '22');
insert into User_Location (Location, UserID) values ('234 Pinehurst Rd Somerville MA', '19');
insert into User_Location (Location, UserID) values ('098 Chestnut Hill Rd Cambridge MA', '21');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Somerville MA', '30');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Springfield MA', '10');
insert into User_Location (Location, UserID) values ('432 Poplar Cir Cambridge MA', '12');
insert into User_Location (Location, UserID) values ('123 Walnut St Boston MA', '13');
insert into User_Location (Location, UserID) values ('890 Lakeside Way Rivertown MA', '35');
insert into User_Location (Location, UserID) values ('654 Walnutwood Ct Somerville MA', '7');
insert into User_Location (Location, UserID) values ('987 Cedar St Boston MA', '12');
insert into User_Location (Location, UserID) values ('234 Forest Rd Rivertown MA', '23');
insert into User_Location (Location, UserID) values ('321 Maplewood Dr Somerville MA', '20');
insert into User_Location (Location, UserID) values ('654 Hillside Ct Rivertown MA', '17');
insert into User_Location (Location, UserID) values ('123 Poplarwood Ct Cambridge MA', '9');
insert into User_Location (Location, UserID) values ('123 Elmwood Dr Springfield MA', '33');
insert into User_Location (Location, UserID) values ('789 Pine St Boston MA', '8');
insert into User_Location (Location, UserID) values ('234 Pinehurst Rd Springfield MA', '14');
insert into User_Location (Location, UserID) values ('654 Pineview Rd Cambridge MA', '15');
insert into User_Location (Location, UserID) values ('789 Meadow Ln Rivertown MA', '22');
insert into User_Location (Location, UserID) values ('789 Birchwood Ln Somerville MA', '5');
insert into User_Location (Location, UserID) values ('543 Birchwood Ave Cambridge MA', '2');
insert into User_Location (Location, UserID) values ('234 Forest Rd Rivertown MA', '3');
insert into User_Location (Location, UserID) values ('654 Walnut Grove Ct Springfield MA', '4');
insert into User_Location (Location, UserID) values ('321 Maplewood Dr Somerville MA', '13');
insert into User_Location (Location, UserID) values ('123 Walnut St Boston MA', '18');
insert into User_Location (Location, UserID) values ('456 Lakeview Ave Rivertown MA', '19');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Somerville MA', '1');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Springfield MA', '31');
insert into User_Location (Location, UserID) values ('432 Riverside Cir Rivertown MA', '32');
insert into User_Location (Location, UserID) values ('456 Elm St Boston MA', '16');
insert into User_Location (Location, UserID) values ('654 Poplar St Boston MA', '34');
insert into User_Location (Location, UserID) values ('098 Chestnutwood Rd Springfield MA', '29');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Somerville MA', '21');
insert into User_Location (Location, UserID) values ('789 Birchwood Ln Somerville MA', '24');
insert into User_Location (Location, UserID) values ('567 Cedarwood Blvd Springfield MA', '26');
insert into User_Location (Location, UserID) values ('123 Elmwood Dr Springfield MA', '27');
insert into User_Location (Location, UserID) values ('123 Pine Ave Boston MA', '10');
insert into User_Location (Location, UserID) values ('321 Maplewood Dr Springfield MA', '30');
insert into User_Location (Location, UserID) values ('123 Pine Ave Boston MA', '6');
insert into User_Location (Location, UserID) values ('890 Lakeside Way Rivertown MA', '28');
insert into User_Location (Location, UserID) values ('890 Oakwood Way Springfield MA', '25');
insert into User_Location (Location, UserID) values ('789 Birch St Boston MA', '11');
insert into User_Location (Location, UserID) values ('543 Maple Ave Rivertown MA', '12');
insert into User_Location (Location, UserID) values ('456 Chestnutview Ave Somerville MA', '22');
insert into User_Location (Location, UserID) values ('789 Pine St Boston MA', '32');
insert into User_Location (Location, UserID) values ('321 Pine St Boston MA', '10');
insert into User_Location (Location, UserID) values ('456 Ash St Boston MA', '34');
insert into User_Location (Location, UserID) values ('432 Poplarview Cir Springfield MA', '7');
insert into User_Location (Location, UserID) values ('987 Brookside Pl Rivertown MA', '27');
insert into User_Location (Location, UserID) values ('987 Elmwood Park Cambridge MA', '11');
insert into User_Location (Location, UserID) values ('456 Chestnut Hill Ave Springfield MA', '13');
insert into User_Location (Location, UserID) values ('987 Maple St Boston MA', '20');
insert into User_Location (Location, UserID) values ('543 Birchwood Ave Cambridge MA', '24');
insert into User_Location (Location, UserID) values ('765 Elmwood St Springfield MA', '23');
insert into User_Location (Location, UserID) values ('321 Maplewood Dr Springfield MA', '4');
insert into User_Location (Location, UserID) values ('123 Pine Ave Boston MA', '17');
insert into User_Location (Location, UserID) values ('234 Forest Rd Rivertown MA', '8');
insert into User_Location (Location, UserID) values ('987 Ashland Pl Somerville MA', '3');
insert into User_Location (Location, UserID) values ('987 Ashwood Pl Springfield MA', '33');
insert into User_Location (Location, UserID) values ('654 Pineview Rd Cambridge MA', '19');
insert into User_Location (Location, UserID) values ('789 Pine St Boston MA', '35');
insert into User_Location (Location, UserID) values ('432 Poplar Cir Cambridge MA', '18');
insert into User_Location (Location, UserID) values ('456 Elm St Boston MA', '25');
insert into User_Location (Location, UserID) values ('234 Pinehurst Rd Somerville MA', '2');
insert into User_Location (Location, UserID) values ('789 Birchwood Ln Somerville MA', '15');
insert into User_Location (Location, UserID) values ('654 Pineview Rd Cambridge MA', '1');
insert into User_Location (Location, UserID) values ('890 Lakeside Way Rivertown MA', '9');

/* user_to_activity */
insert into User_to_Activity (UserID, ActivityID) values ('32', '5');
insert into User_to_Activity (UserID, ActivityID) values ('20', '1');
insert into User_to_Activity (UserID, ActivityID) values ('3', '4');
insert into User_to_Activity (UserID, ActivityID) values ('1', '3');
insert into User_to_Activity (UserID, ActivityID) values ('31', '7');
insert into User_to_Activity (UserID, ActivityID) values ('17', '6');
insert into User_to_Activity (UserID, ActivityID) values ('29', '8');
insert into User_to_Activity (UserID, ActivityID) values ('13', '2');
insert into User_to_Activity (UserID, ActivityID) values ('25', '4');
insert into User_to_Activity (UserID, ActivityID) values ('14', '7');
insert into User_to_Activity (UserID, ActivityID) values ('33', '2');
insert into User_to_Activity (UserID, ActivityID) values ('21', '5');
insert into User_to_Activity (UserID, ActivityID) values ('2', '8');
insert into User_to_Activity (UserID, ActivityID) values ('23', '1');
insert into User_to_Activity (UserID, ActivityID) values ('6', '3');
insert into User_to_Activity (UserID, ActivityID) values ('35', '6');
insert into User_to_Activity (UserID, ActivityID) values ('27', '3');
insert into User_to_Activity (UserID, ActivityID) values ('7', '4');
insert into User_to_Activity (UserID, ActivityID) values ('30', '7');
insert into User_to_Activity (UserID, ActivityID) values ('4', '6');
insert into User_to_Activity (UserID, ActivityID) values ('9', '2');
insert into User_to_Activity (UserID, ActivityID) values ('24', '5');
insert into User_to_Activity (UserID, ActivityID) values ('12', '1');
insert into User_to_Activity (UserID, ActivityID) values ('18', '8');
insert into User_to_Activity (UserID, ActivityID) values ('19', '7');
insert into User_to_Activity (UserID, ActivityID) values ('34', '4');
insert into User_to_Activity (UserID, ActivityID) values ('10', '3');
insert into User_to_Activity (UserID, ActivityID) values ('22', '8');
insert into User_to_Activity (UserID, ActivityID) values ('26', '1');
insert into User_to_Activity (UserID, ActivityID) values ('5', '6');
insert into User_to_Activity (UserID, ActivityID) values ('15', '5');
insert into User_to_Activity (UserID, ActivityID) values ('11', '2');
insert into User_to_Activity (UserID, ActivityID) values ('28', '1');
insert into User_to_Activity (UserID, ActivityID) values ('8', '7');
insert into User_to_Activity (UserID, ActivityID) values ('16', '6');
insert into User_to_Activity (UserID, ActivityID) values ('31', '3');
insert into User_to_Activity (UserID, ActivityID) values ('24', '4');
insert into User_to_Activity (UserID, ActivityID) values ('33', '8');
insert into User_to_Activity (UserID, ActivityID) values ('6', '5');
insert into User_to_Activity (UserID, ActivityID) values ('34', '2');
insert into User_to_Activity (UserID, ActivityID) values ('32', '8');
insert into User_to_Activity (UserID, ActivityID) values ('13', '4');
insert into User_to_Activity (UserID, ActivityID) values ('15', '2');
insert into User_to_Activity (UserID, ActivityID) values ('12', '7');
insert into User_to_Activity (UserID, ActivityID) values ('1', '5');
insert into User_to_Activity (UserID, ActivityID) values ('8', '3');
insert into User_to_Activity (UserID, ActivityID) values ('25', '1');
insert into User_to_Activity (UserID, ActivityID) values ('23', '6');
insert into User_to_Activity (UserID, ActivityID) values ('27', '8');
insert into User_to_Activity (UserID, ActivityID) values ('10', '5');
insert into User_to_Activity (UserID, ActivityID) values ('35', '6');
insert into User_to_Activity (UserID, ActivityID) values ('9', '2');
insert into User_to_Activity (UserID, ActivityID) values ('29', '4');
insert into User_to_Activity (UserID, ActivityID) values ('5', '1');
insert into User_to_Activity (UserID, ActivityID) values ('2', '3');
insert into User_to_Activity (UserID, ActivityID) values ('14', '7');
insert into User_to_Activity (UserID, ActivityID) values ('28', '4');
insert into User_to_Activity (UserID, ActivityID) values ('21', '1');
insert into User_to_Activity (UserID, ActivityID) values ('26', '7');
insert into User_to_Activity (UserID, ActivityID) values ('19', '5');
insert into User_to_Activity (UserID, ActivityID) values ('20', '3');
insert into User_to_Activity (UserID, ActivityID) values ('7', '6');
insert into User_to_Activity (UserID, ActivityID) values ('22', '2');
insert into User_to_Activity (UserID, ActivityID) values ('3', '8');
insert into User_to_Activity (UserID, ActivityID) values ('11', '6');
insert into User_to_Activity (UserID, ActivityID) values ('18', '1');
insert into User_to_Activity (UserID, ActivityID) values ('16', '3');
insert into User_to_Activity (UserID, ActivityID) values ('4', '2');
insert into User_to_Activity (UserID, ActivityID) values ('17', '8');
insert into User_to_Activity (UserID, ActivityID) values ('30', '7');
insert into User_to_Activity (UserID, ActivityID) values ('25', '5');
insert into User_to_Activity (UserID, ActivityID) values ('18', '4');
insert into User_to_Activity (UserID, ActivityID) values ('20', '1');
insert into User_to_Activity (UserID, ActivityID) values ('14', '4');
insert into User_to_Activity (UserID, ActivityID) values ('17', '7');
insert into User_to_Activity (UserID, ActivityID) values ('23', '5');
insert into User_to_Activity (UserID, ActivityID) values ('12', '2');
insert into User_to_Activity (UserID, ActivityID) values ('32', '3');
insert into User_to_Activity (UserID, ActivityID) values ('6', '6');
insert into User_to_Activity (UserID, ActivityID) values ('27', '8');
insert into User_to_Activity (UserID, ActivityID) values ('24', '2');
insert into User_to_Activity (UserID, ActivityID) values ('22', '3');
insert into User_to_Activity (UserID, ActivityID) values ('33', '1');
insert into User_to_Activity (UserID, ActivityID) values ('5', '8');
insert into User_to_Activity (UserID, ActivityID) values ('9', '7');
insert into User_to_Activity (UserID, ActivityID) values ('16', '6');
insert into User_to_Activity (UserID, ActivityID) values ('35', '5');
insert into User_to_Activity (UserID, ActivityID) values ('19', '4');
insert into User_to_Activity (UserID, ActivityID) values ('13', '5');
insert into User_to_Activity (UserID, ActivityID) values ('2', '4');
insert into User_to_Activity (UserID, ActivityID) values ('7', '3');
insert into User_to_Activity (UserID, ActivityID) values ('1', '7');
insert into User_to_Activity (UserID, ActivityID) values ('8', '6');
insert into User_to_Activity (UserID, ActivityID) values ('15', '1');
insert into User_to_Activity (UserID, ActivityID) values ('30', '2');
insert into User_to_Activity (UserID, ActivityID) values ('4', '8');
insert into User_to_Activity (UserID, ActivityID) values ('11', '4');
insert into User_to_Activity (UserID, ActivityID) values ('10', '1');
insert into User_to_Activity (UserID, ActivityID) values ('29', '7');
insert into User_to_Activity (UserID, ActivityID) values ('28', '6');
insert into User_to_Activity (UserID, ActivityID) values ('26', '8');
insert into User_to_Activity (UserID, ActivityID) values ('3', '3');
insert into User_to_Activity (UserID, ActivityID) values ('34', '5');
insert into User_to_Activity (UserID, ActivityID) values ('21', '2');
insert into User_to_Activity (UserID, ActivityID) values ('31', '8');
insert into User_to_Activity (UserID, ActivityID) values ('29', '1');
insert into User_to_Activity (UserID, ActivityID) values ('2', '6');
insert into User_to_Activity (UserID, ActivityID) values ('9', '2');
insert into User_to_Activity (UserID, ActivityID) values ('6', '3');
insert into User_to_Activity (UserID, ActivityID) values ('28', '4');
insert into User_to_Activity (UserID, ActivityID) values ('18', '5');
insert into User_to_Activity (UserID, ActivityID) values ('1', '7');
insert into User_to_Activity (UserID, ActivityID) values ('12', '2');
insert into User_to_Activity (UserID, ActivityID) values ('26', '5');
insert into User_to_Activity (UserID, ActivityID) values ('13', '8');
insert into User_to_Activity (UserID, ActivityID) values ('24', '1');
insert into User_to_Activity (UserID, ActivityID) values ('16', '7');
insert into User_to_Activity (UserID, ActivityID) values ('25', '4');
insert into User_to_Activity (UserID, ActivityID) values ('19', '3');
insert into User_to_Activity (UserID, ActivityID) values ('20', '6');
insert into User_to_Activity (UserID, ActivityID) values ('5', '6');
insert into User_to_Activity (UserID, ActivityID) values ('4', '1');
insert into User_to_Activity (UserID, ActivityID) values ('3', '5');
insert into User_to_Activity (UserID, ActivityID) values ('31', '7');
insert into User_to_Activity (UserID, ActivityID) values ('35', '4');
insert into User_to_Activity (UserID, ActivityID) values ('23', '2');
insert into User_to_Activity (UserID, ActivityID) values ('15', '3');
insert into User_to_Activity (UserID, ActivityID) values ('14', '8');
insert into User_to_Activity (UserID, ActivityID) values ('17', '2');
insert into User_to_Activity (UserID, ActivityID) values ('10', '8');
insert into User_to_Activity (UserID, ActivityID) values ('32', '3');
insert into User_to_Activity (UserID, ActivityID) values ('8', '7');
insert into User_to_Activity (UserID, ActivityID) values ('21', '1');
insert into User_to_Activity (UserID, ActivityID) values ('27', '5');
insert into User_to_Activity (UserID, ActivityID) values ('22', '4');
insert into User_to_Activity (UserID, ActivityID) values ('34', '6');
insert into User_to_Activity (UserID, ActivityID) values ('11', '2');
insert into User_to_Activity (UserID, ActivityID) values ('33', '8');
insert into User_to_Activity (UserID, ActivityID) values ('30', '6');
insert into User_to_Activity (UserID, ActivityID) values ('7', '5');
insert into User_to_Activity (UserID, ActivityID) values ('11', '3');
insert into User_to_Activity (UserID, ActivityID) values ('1', '1');
insert into User_to_Activity (UserID, ActivityID) values ('31', '4');
insert into User_to_Activity (UserID, ActivityID) values ('3', '7');
insert into User_to_Activity (UserID, ActivityID) values ('21', '4');
insert into User_to_Activity (UserID, ActivityID) values ('6', '1');
insert into User_to_Activity (UserID, ActivityID) values ('10', '6');
insert into User_to_Activity (UserID, ActivityID) values ('25', '5');
insert into User_to_Activity (UserID, ActivityID) values ('13', '2');
insert into User_to_Activity (UserID, ActivityID) values ('34', '8');
insert into User_to_Activity (UserID, ActivityID) values ('8', '3');
insert into User_to_Activity (UserID, ActivityID) values ('30', '7');
insert into User_to_Activity (UserID, ActivityID) values ('35', '3');
insert into User_to_Activity (UserID, ActivityID) values ('12', '7');
insert into User_to_Activity (UserID, ActivityID) values ('16', '4');
insert into User_to_Activity (UserID, ActivityID) values ('7', '6');
insert into User_to_Activity (UserID, ActivityID) values ('14', '2');
insert into User_to_Activity (UserID, ActivityID) values ('33', '5');
insert into User_to_Activity (UserID, ActivityID) values ('32', '1');
insert into User_to_Activity (UserID, ActivityID) values ('27', '8');
insert into User_to_Activity (UserID, ActivityID) values ('26', '5');
insert into User_to_Activity (UserID, ActivityID) values ('29', '2');
insert into User_to_Activity (UserID, ActivityID) values ('15', '3');
insert into User_to_Activity (UserID, ActivityID) values ('18', '8');
insert into User_to_Activity (UserID, ActivityID) values ('24', '1');
insert into User_to_Activity (UserID, ActivityID) values ('23', '6');
insert into User_to_Activity (UserID, ActivityID) values ('20', '7');
insert into User_to_Activity (UserID, ActivityID) values ('19', '4');
insert into User_to_Activity (UserID, ActivityID) values ('2', '4');
insert into User_to_Activity (UserID, ActivityID) values ('5', '7');
insert into User_to_Activity (UserID, ActivityID) values ('28', '2');
insert into User_to_Activity (UserID, ActivityID) values ('9', '1');
insert into User_to_Activity (UserID, ActivityID) values ('22', '8');
insert into User_to_Activity (UserID, ActivityID) values ('17', '5');
insert into User_to_Activity (UserID, ActivityID) values ('4', '3');
insert into User_to_Activity (UserID, ActivityID) values ('12', '6');
insert into User_to_Activity (UserID, ActivityID) values ('29', '1');
insert into User_to_Activity (UserID, ActivityID) values ('31', '4');
insert into User_to_Activity (UserID, ActivityID) values ('24', '7');
insert into User_to_Activity (UserID, ActivityID) values ('19', '8');
insert into User_to_Activity (UserID, ActivityID) values ('18', '5');
insert into User_to_Activity (UserID, ActivityID) values ('15', '3');
insert into User_to_Activity (UserID, ActivityID) values ('27', '2');
insert into User_to_Activity (UserID, ActivityID) values ('11', '6');
insert into User_to_Activity (UserID, ActivityID) values ('32', '6');
insert into User_to_Activity (UserID, ActivityID) values ('28', '3');
insert into User_to_Activity (UserID, ActivityID) values ('5', '4');
insert into User_to_Activity (UserID, ActivityID) values ('4', '7');
insert into User_to_Activity (UserID, ActivityID) values ('7', '8');
insert into User_to_Activity (UserID, ActivityID) values ('6', '1');
insert into User_to_Activity (UserID, ActivityID) values ('33', '5');
insert into User_to_Activity (UserID, ActivityID) values ('13', '2');
insert into User_to_Activity (UserID, ActivityID) values ('14', '7');
insert into User_to_Activity (UserID, ActivityID) values ('3', '8');
insert into User_to_Activity (UserID, ActivityID) values ('26', '1');
insert into User_to_Activity (UserID, ActivityID) values ('22', '4');
insert into User_to_Activity (UserID, ActivityID) values ('25', '3');
insert into User_to_Activity (UserID, ActivityID) values ('2', '5');
insert into User_to_Activity (UserID, ActivityID) values ('20', '2');
insert into User_to_Activity (UserID, ActivityID) values ('17', '6');

/* Interests/Hobbies */
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (1, 'biking', 'Digital art creation', 'Jazz', 'Sauteing', '5');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (2, 'skiing', 'Glassblowing', 'Latin', 'Indonesian', '27');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (3, 'biking', 'Knitting', 'Ska', 'Vietnamese', '8');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (4, 'Surfing', 'Pencil sketching', 'Death metal', 'French', '22');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (5, 'Tennis', 'Quilting', 'Country', 'Vietnamese', '19');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (6, 'fencing', 'Digital art creation', 'Country rock', 'French', '14');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (7, 'fencing', 'Calligraphy', 'Progressive rock', 'Greek', '24');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (8, 'fencing', 'Collage making', 'Ambient', 'Preserving', '18');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (9, 'Surfing', 'Graphic design', 'Jazz', 'Grilling', '16');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (10, 'fencing', 'Jewelry making', 'New wave', 'Moroccan', '28');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (11, 'yoga', 'Woodworking', 'Salsa', 'Turkish', '7');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (12, 'zumba', 'Digital art creation', 'Classical', 'Portuguese', '23');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (13, 'Surfing', 'Painting', 'Dance', 'Preserving', '25');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (14, 'Tennis', 'Watercolor painting', 'Reggae', 'Indonesian', '20');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (15, 'Basketball', 'Pottery', 'Ska', 'Spanish', '30');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (16, 'Golf', 'Woodworking', 'Synth-pop', 'Argentinean', '29');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (17, 'Tennis', 'Crocheting', 'Blues', 'Peruvian', '3');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (18, 'skiing', 'Jewelry making', 'Techno', 'Caribbean', '6');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (19, 'yoga', 'Acrylic painting', 'Ska', 'Peruvian', '32');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (20, 'dance', 'Woodworking', 'Salsa', 'Caribbean', '33');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (21, 'Rock climbing', 'Glassblowing', 'Trance', 'Malaysian', '11');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (22, 'fencing', 'Graphic design', 'Orchestral', 'Portuguese', '10');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (23, 'dance', 'Painting', 'Techno', 'Broiling', '9');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (24, 'dance', 'Calligraphy', 'Acoustic', 'Italian', '31');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (25, 'Hockey', 'Sewing', 'Emo', 'Braising', '34');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (26, 'running', 'Oil painting', 'R&B', 'Broiling', '13');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (27, 'skiing', 'Watercolor painting', 'Death metal', 'Steaming', '17');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (28, 'skiing', 'Quilting', 'Synth-pop', 'Mediterranean', '15');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (29, 'Hockey', 'Pottery', 'Indie', 'Italian', '35');
insert into Interests_Hobbies (InterestHobbiesID ,  Physical , Art , Music, Cooking, UserID) values (30, 'yoga', 'Crocheting', 'Blues', 'Peruvian', '26');

/* payment plan */
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (1, 1, 'Gift Card', '9');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (2, 0, 'Cash', '4');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (3, 0, 'Credit Card', '30');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (4, 0, 'Bitcoin', '3');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (5, 0, 'Bitcoin', '23');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (6, 1, 'PayPal', '7');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (7, 1, 'Cash', '34');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (8, 1, 'Bank Transfer', '32');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (9, 1, 'Cash', '1');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (10, 0, 'PayPal', '27');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (11, 0, 'Apple Pay', '14');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (12, 1, 'Apple Pay', '31');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (13, 0, 'Cash', '29');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (14, 1, 'Credit Card', '10');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (15, 1, 'Venmo', '24');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (16, 1, 'Zelle', '11');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (17, 1, 'Credit Card', '25');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (18, 0, 'Bank Transfer', '15');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (19, 0, 'Apple Pay', '28');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (20, 0, 'Cash', '33');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (21, 1, 'Bitcoin', '26');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (22, 0, 'Bank Transfer', '8');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (23, 1, 'Gift Card', '13');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (24, 1, 'Google Pay', '2');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (25, 1, 'Gift Card', '17');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (26, 1, 'Bank Transfer', '6');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (27, 1, 'Cash', '16');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (28, 0, 'Venmo', '35');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (29, 1, 'Credit Card', '5');
insert into PaymentPlan (PaymentID, Paid, PaymentMethod, UserID) values (30, 0, 'Venmo', '22');



Select * from User;