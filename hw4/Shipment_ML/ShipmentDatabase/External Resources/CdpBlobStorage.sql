CREATE EXTERNAL DATA SOURCE [CdpBlobStorage]
    WITH (
    TYPE = BLOB_STORAGE,
    LOCATION = N'https://shipment.blob.core.windows.net/importdata'
    );

