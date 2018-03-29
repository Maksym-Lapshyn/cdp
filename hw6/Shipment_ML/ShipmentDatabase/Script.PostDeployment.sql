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

:r .\Scripts\ImportDrivers.sql
:r .\Scripts\ImportTrucks.sql
:r .\Scripts\UpdateTruckNames.sql
:r .\Scripts\ImportDriversTrucks.sql
:r .\Scripts\ImportWarehouses.sql
:r .\Scripts\PopulateRoutes.sql
:r .\Scripts\MergeShipmentStatuses.sql
:r .\Scripts\PopulateCargoAndShipment.sql