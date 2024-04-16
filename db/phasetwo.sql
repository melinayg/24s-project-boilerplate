CREATE DATABASE GoMass;
USE GoMass;

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
    Balance INT, 
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
    /* category */
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

/* 8 */
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
   CleanlinessSafety VARCHAR(255)
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

/* 3 */ 
CREATE TABLE Restaurants(
	RestaurantID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
	Name TEXT,
	Reservations INT,
	CuisineType TEXT,
	PriceTag VARCHAR(5),
	ActivityTypeID INT,
	CONSTRAINT fk_16
	    FOREIGN KEY (ActivityType) REFERENCES Activity(ActivityID)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Restaurant_Location (
    Location VARCHAR(255) PRIMARY KEY UNIQUE,
    RestaurantID INT,
    CONSTRAINT fk_17
        FOREIGN KEY (RestaurantID) REFERENCES Restaurants (RestaurantID)
            ON UPDATE CASCADE ON DELETE RESTRICT
);

/* 7 */
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

/* 2 */ 
CREATE TABLE MusicFestivals(
	FestivalID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
	Name TEXT,
	MusicType TEXT,
	CrowdSize INT,
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

/* 4 */
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

/* 1 */
CREATE TABLE Outdoor_Activity (
    OutdoorID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Name VARCHAR(255),
    Difficulty_level VARCHAR(255),
    Danger_level VARCHAR(255),
    Experience VARCHAR(255),
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

/* 5 */
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    OverallRating DECIMAL(3, 1),
    Genre VARCHAR(255),
    Activity_Type_ID INT,
    FOREIGN KEY (Activity_Type_ID) REFERENCES Activity(ActivityID)
);

CREATE TABLE MoviesLocation (
    Location VARCHAR(255) PRIMARY KEY UNIQUE,
    MovieID INT,
    CONSTRAINT fk_28
	    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
	    ON UPDATE CASCADE ON DELETE RESTRICT
);

/* 6 */
CREATE TABLE ArtsMuseums (
    ArtMuseumID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Name TEXT,
    ArtType TEXT,
    CollegeStudents INT,
    PriceTag VARCHAR(5),
    OverallRating CHAR(5),
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
VALUES ('Jane Smith', 28, 'Artist', 'Cambridge', 1200.00, 'Spicy food', 'Art, Music concerts', 'Female', 'Vegetarian', 'Annual', 2, 'Yes', 'No', 'PayPal');


INSERT INTO User_Location (Location, UserID) VALUES ('Boston, MA', 1);
INSERT INTO User_Location (Location, UserID) VALUES ('Cambridge, MA', 2);


INSERT INTO Activity (Name) VALUES ('Hiking');
INSERT INTO Activity (Name) VALUES ('Coding');


INSERT INTO User_to_Activity (UserID, ActivityID) VALUES (1, 1);
INSERT INTO User_to_Activity (UserID, ActivityID) VALUES (2, 2);


INSERT INTO Interests_Hobbies (Physical, Art, Music, Cooking, UserID) VALUES ('Running', 'Painting', 'Classical', 'Italian', 1);
INSERT INTO Interests_Hobbies (Physical, Art, Music, Cooking, UserID) VALUES ('Yoga', 'Digital Art', 'Electronic', 'Japanese', 2);


INSERT INTO PaymentPlan (Paid, Free, PaymentMethod, UserID) VALUES (300, 0, 'Credit Card', 1);
INSERT INTO PaymentPlan (Paid, Free, PaymentMethod, UserID) VALUES (0, 0, 'PayPal', 2);


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


INSERT INTO Restaurants (Name, Reservations, CuisineType, PriceTag, Location, ActivityType) VALUES ('The Fancy Feast', 20, 'French', '$$$', '123 Gourmet Alley', 1);
INSERT INTO Restaurants (Name, Reservations, CuisineType, PriceTag, Location, ActivityType) VALUES ('Burger Barn', 50, 'American', '$', '456 Fast Food Way', 2);



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


INSERT INTO Outdoor_Activity (Name, Difficulty_level, Danger_level, Experience, Location, Cost, ActivityTypeID) VALUES ('Mountain Biking', 'High', 'Medium', 'Expert', 'Trail Park', '$$', 1);
INSERT INTO Outdoor_Activity (Name, Difficulty_level, Danger_level, Experience, Location, Cost, ActivityTypeID) VALUES ('Kayaking', 'Medium', 'Low', 'Beginner', 'River Run', '$', 2);


INSERT INTO Outdoor_Activity_Location (Location, OutdoorID) VALUES ('Trail Park', 1);
INSERT INTO Outdoor_Activity_Location (Location, OutdoorID) VALUES ('River Run', 2);


INSERT INTO ArtsMuseums (PriceTag, Name, ArtType, CollegeStudents, OverallRating, ActivityTypeID) VALUES ('$', 'Modern Art Museum', 'Modern', 500, 'A', 1);
INSERT INTO ArtsMuseums (PriceTag, Name, ArtType, CollegeStudents, OverallRating, ActivityTypeID) VALUES ('$', 'History Museum', 'Historical', 300, 'A-', 2);


INSERT INTO ArtMuseumsLocation (Location, ArtMuseumID) VALUES ('Cultural District', 1);
INSERT INTO ArtMuseumsLocation (Location, ArtMuseumID) VALUES ('Old Town', 2);


INSERT INTO Movies (TheaterLocation, Name, OverallRating, Genre, Activity_Type_ID) 
VALUES ('Downtown Cinema', 'Inception', 8.8, 'Science Fiction', 1);

INSERT INTO Movies (TheaterLocation, Name, OverallRating, Genre, Activity_Type_ID) 
VALUES ('Riverside Theater', 'The Dark Knight', 9.0, 'Action', 2);

select * from movies;
