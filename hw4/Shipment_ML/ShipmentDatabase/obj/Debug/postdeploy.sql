/*
Post-Deployment Script Template                            
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.        
 Use SQLCMD syntax to include a file in the post-deployment script.            
 Example:      :r .\myfile.sql                                
 Use SQLCMD syntax to reference a variable in the post-deployment script.        
 Example:      :setvar TableName MyTable                            
               SELECT * FROM [$(TableName)]                    
--------------------------------------------------------------------------------------
*/

INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'John',N'Doe',N'1/23/1967');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Adam',N'Petr',N'5/23/1975');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Jin',N'Partida',N'3/15/1980');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Scott',N'Lucas',N'4/1/1985');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Alta',N'Olson',N'6/14/1975');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Arthur',N'Sullivan',N'4/26/1982');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Robert',N'Suarez',N'4/11/1975');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Timothy',N'Johns',N'10/7/1985');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Olive',N'Tucker',N'12/25/1986');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Lela',N'Coleman',N'4/20/1977');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Maurice',N'Elam',N'4/2/1981');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Charles',N'Delacruz',N'1/18/1975');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Branden',N'Webster',N'7/3/1964');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Bennie',N'Morley',N'12/25/1986');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Jacob',N'Sanders',N'4/20/1936');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Perry',N'Haley',N'4/26/1982');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Emma',N'White',N'4/3/1955');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Bryan',N'Baldridge',N'4/16/1952');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Tom',N'Stennis',N'1/27/1985');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Mike',N'O''Connor',N'12/20/1977');
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MAN',N'1ABC234',N'2010',18500,22,100);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'DAF',N'1ABC235',N'2009',15000,20,90);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MERCEDES BENZ',N'1ABC236',N'2013',15000,18,100);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'Foton',N'1ABC237',N'2011',9000,18,30);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'DAF',N'1ABC238',N'2009',26000,20,70);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'DAF',N'1ABC239',N'2011',12000,20,70);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'DAF',N'1ABC240',N'2014',12000,20,70);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'DAF',N'1ABC241',N'2011',9000,18,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'DAF',N'1ABC242',N'2011',9000,18,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'Ford',N'1ABC243',N'2011',9000,18,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MAN',N'1ABC244',N'2013',9000,18,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MAN',N'1ABC245',N'2012',5000,18,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MAN',N'1ABC246',N'2011',18500,20,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MAN',N'1ABC247',N'2011',26000,18,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MAN',N'1ABC248',N'2011',20000,18,50);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (1,1);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (1,2);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (2,3);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (3,1);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (4,4);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (5,6);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (6,5);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (7,7);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (7,20);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (8,8);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (9,9);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (9,8);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (10,10);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (11,10);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (12,11);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (13,12);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (13,13);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (13,14);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (14,15);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (14,16);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (15,17);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (15,18);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (15,19);
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('New York','New York');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Los Angeles','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Chicago','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Houston','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Philadelphia','Pennsylvania');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Phoenix','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('San Antonio','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('San Diego','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Dallas','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('San Jose','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Austin','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Indianapolis','Indiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Jacksonville','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('San Francisco','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Columbus','Ohio');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Charlotte','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fort Worth','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Detroit','Michigan');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('El Paso','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Memphis','Tennessee');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Seattle','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Denver','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Washington','District of Columbia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Boston','Massachusetts');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Nashville','Tennessee');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Baltimore','Maryland');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Oklahoma City','Oklahoma');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Louisville','Kentucky');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Portland','Oregon');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Las Vegas','Nevada');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Milwaukee','Wisconsin');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Albuquerque','New Mexico');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tucson','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fresno','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Sacramento','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Long Beach','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Kansas City','Missouri');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Mesa','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Virginia Beach','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Atlanta','Georgia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Colorado Springs','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Omaha','Nebraska');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Raleigh','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Miami','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Oakland','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Minneapolis','Minnesota');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tulsa','Oklahoma');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Cleveland','Ohio');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Wichita','Kansas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Arlington','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('New Orleans','Louisiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Bakersfield','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tampa','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Honolulu','Hawai''i');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Aurora','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Anaheim','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Santa Ana','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('St. Louis','Missouri');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Riverside','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Corpus Christi','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lexington','Kentucky');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pittsburgh','Pennsylvania');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Anchorage','Alaska');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Stockton','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Cincinnati','Ohio');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Saint Paul','Minnesota');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Toledo','Ohio');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Greensboro','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Newark','New Jersey');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Plano','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Henderson','Nevada');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lincoln','Nebraska');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Buffalo','New York');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Jersey City','New Jersey');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Chula Vista','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fort Wayne','Indiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Orlando','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('St. Petersburg','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Chandler','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Laredo','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Norfolk','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Durham','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Madison','Wisconsin');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lubbock','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Irvine','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Winston?Salem','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Glendale','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Garland','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Hialeah','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Reno','Nevada');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Chesapeake','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Gilbert','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Baton Rouge','Louisiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Irving','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Scottsdale','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('North Las Vegas','Nevada');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fremont','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Boise','Idaho');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Richmond','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('San Bernardino','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Birmingham','Alabama');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Spokane','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Rochester','New York');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Des Moines','Iowa');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Modesto','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fayetteville','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tacoma','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Oxnard','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fontana','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Columbus','Georgia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Montgomery','Alabama');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Moreno Valley','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Shreveport','Louisiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Aurora','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Yonkers','New York');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Akron','Ohio');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Huntington Beach','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Little Rock','Arkansas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Augusta','Georgia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Amarillo','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Glendale','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Mobile','Alabama');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Grand Rapids','Michigan');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Salt Lake City','Utah');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tallahassee','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Huntsville','Alabama');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Grand Prairie','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Knoxville','Tennessee');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Worcester','Massachusetts');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Newport News','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Brownsville','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Overland Park','Kansas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Santa Clarita','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Providence','Rhode Island');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Garden Grove','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Chattanooga','Tennessee');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Oceanside','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Jackson','Mississippi');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fort Lauderdale','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Santa Rosa','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Rancho Cucamonga','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Port St. Lucie','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tempe','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Ontario','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Vancouver','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Cape Coral','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Sioux Falls','South Dakota');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Springfield','Missouri');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Peoria','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pembroke Pines','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Elk Grove','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Salem','Oregon');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lancaster','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Corona','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Eugene','Oregon');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Palmdale','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Salinas','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Springfield','Massachusetts');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pasadena','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fort Collins','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Hayward','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pomona','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Cary','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Rockford','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Alexandria','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Escondido','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('McKinney','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Kansas City','Kansas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Joliet','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Sunnyvale','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Torrance','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Bridgeport','Connecticut');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lakewood','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Hollywood','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Paterson','New Jersey');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Naperville','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Syracuse','New York');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Mesquite','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Dayton','Ohio');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Savannah','Georgia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Clarksville','Tennessee');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Orange','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pasadena','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fullerton','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Killeen','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Frisco','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Hampton','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('McAllen','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Warren','Michigan');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Bellevue','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('West Valley City','Utah');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Columbia','South Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Olathe','Kansas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Sterling Heights','Michigan');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('New Haven','Connecticut');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Miramar','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Waco','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Thousand Oaks','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Cedar Rapids','Iowa');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Charleston','South Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Visalia','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Topeka','Kansas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Elizabeth','New Jersey');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Gainesville','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Thornton','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Roseville','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Carrollton','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Coral Springs','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Stamford','Connecticut');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Simi Valley','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Concord','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Hartford','Connecticut');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Kent','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lafayette','Louisiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Midland','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Surprise','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Denton','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Victorville','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Evansville','Indiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Santa Clara','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Abilene','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Athens','Georgia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Vallejo','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Allentown','Pennsylvania');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Norman','Oklahoma');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Beaumont','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Independence','Missouri');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Murfreesboro','Tennessee');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Ann Arbor','Michigan');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Springfield','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Berkeley','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Peoria','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Provo','Utah');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('El Monte','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Columbia','Missouri');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lansing','Michigan');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fargo','North Dakota');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Downey','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Costa Mesa','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Wilmington','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Arvada','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Inglewood','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Miami Gardens','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Carlsbad','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Westminster','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Rochester','Minnesota');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Odessa','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Manchester','New Hampshire');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Elgin','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('West Jordan','Utah');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Round Rock','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Clearwater','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Waterbury','Connecticut');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Gresham','Oregon');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fairfield','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Billings','Montana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lowell','Massachusetts');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Ventura','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pueblo','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('High Point','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('West Covina','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Richmond','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Murrieta','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Cambridge','Massachusetts');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Antioch','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Temecula','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Norwalk','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Centennial','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Everett','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Palm Bay','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Wichita Falls','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Green Bay','Wisconsin');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Daly City','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Burbank','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Richardson','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pompano Beach','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('North Charleston','South Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Broken Arrow','Oklahoma');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Boulder','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('West Palm Beach','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Santa Maria','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('El Cajon','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Davenport','Iowa');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Rialto','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Edison','New Jersey');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Las Cruces','New Mexico');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('San Mateo','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lewisville','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('South Bend','Indiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lakeland','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Erie','Pennsylvania');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Woodbridge','New Jersey');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tyler','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pearland','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('College Station','Texas');

DECLARE @maxDistance INT = 3000;
DECLARE @minDistance INT = 100;

INSERT INTO dbo.Route(
	OriginId,
	DestinationId,
	Distance
)
SELECT DISTINCT
    origin.Id,
    destination.Id,
	FLOOR(RAND(CHECKSUM(NEWID()))*(@maxDistance - @minDistance) + @minDistance)
FROM 
    dbo.Warehouse AS origin
CROSS JOIN
    dbo.Warehouse AS destination
WHERE origin.Id != destination.Id;
INSERT INTO dbo.ContactInformation(
	[FirstName],
    [LastName],
	[CellPhone]
)
VALUES(
	'Maksym',
	'Lapshyn',
	'111222333'
);

DECLARE @currentRow INT = 0;
DECLARE @shipmentsToInsert INT;

SELECT @shipmentsToInsert = 1000;

DECLARE @routeCount INT;
DECLARE @truckCount INT;

SELECT @routeCount = COUNT(*)
FROM dbo.[Route];

SELECT @truckCount = COUNT(*)
FROM dbo.Truck;

WHILE @currentRow < @shipmentsToInsert
BEGIN
	DECLARE @truckId INT = ROUND(((@truckCount - 1) * RAND() + 1), 0);
	DECLARE @driverId INT;
	DECLARE @dateFrom AS DATETIME = '1990-01-01';
	DECLARE @dateTo AS DATETIME = '2004-01-01';
	DECLARE @departureDate DATETIME = dbo.GenerateRandomDate(@dateFrom, @dateTo);
	SET @dateFrom = '2004-01-01';
	SET @dateTo = '2018-01-01';
	DECLARE @deliveryDate DATETIME = dbo.GenerateRandomDate(@dateFrom, @dateTo);

	SELECT TOP 1 @driverId = DriverId
	FROM dbo.DriverTruck
	WHERE TruckId = @truckId
	ORDER BY NEWID();

	INSERT INTO dbo.Shipment(
		[RouteId],
		[DriverId],
		[TruckId],
		[DepartureDate],
		[DeliveryDate]
	)
	VALUES(
		ROUND(((@routeCount - 1) * RAND() + 1), 0),
		@driverId,
		@truckId,
		@departureDate,
		@deliveryDate
	)

	SET @currentRow = @currentRow + 1;
END

SET @currentRow = 0;
DECLARE @contactId INT = 1;
DECLARE @cargosToInsert INT = 10000;
DECLARE @maxVolume INT = 50;
DECLARE @minVolume INT = 1;
DECLARE @maxWeight INT = 5000;
DECLARE @minWeight INT = 1;

WHILE @currentRow < @cargosToInsert
BEGIN
	INSERT INTO dbo.Cargo(
		[Weight],
		[Volume],
		[SenderId],
		[RecipientId],
		[ShipmentId]
	)
	VALUES(
		FLOOR(RAND()*(@maxWeight - @minWeight) + @minWeight),
		FLOOR(RAND()*(@maxVolume - @minVolume) + @minVolume),
		@contactId,
		@contactId,
		FLOOR(RAND()*(@shipmentsToInsert - 1) + 1)
	)

	SET @currentRow = @currentRow + 1;
END
MERGE INTO dbo.ShipmentStatus AS t
USING (VALUES(N'Scheduled'),(N'Departured'),(N'Arrived'),(N'Cancelled')) AS s (DisplayName)
ON (t.DisplayName = s.DisplayName)
WHEN MATCHED AND (t.DisplayName <> s.DisplayName) THEN
    UPDATE SET
    DisplayName = s.DisplayName
WHEN NOT MATCHED BY TARGET THEN
    INSERT(DisplayName)
    VALUES(s.DisplayName)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
GO
