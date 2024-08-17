--3. Crear un stored procedure para crear una nueva reservaci�n.
--El store procedure debe verificar si existe una habitaci�n disponible para la fecha deseada

CREATE PROCEDURE CreateReservation
    @CustomerID INT,
    @RoomID INT,
    @BookingDate DATETIME,
    @CheckInDate DATE,
    @CheckOutDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si la habitaci�n est� disponible
    IF NOT EXISTS (
        SELECT 1 
        FROM dbo.Bookings 
        WHERE RoomID = @RoomID 
        AND (
            (@CheckInDate < CheckOutDate AND @CheckOutDate > CheckInDate)
        )
    )
    BEGIN
        -- Insertar la nueva reservaci�n
        INSERT INTO dbo.Bookings (CustomerID, RoomID, BookingDate, CheckInDate, CheckOutDate, TotalAmount, Status)
        VALUES (@CustomerID, @RoomID, @BookingDate, @CheckInDate, @CheckOutDate, 0, 'reservado');

        PRINT 'Reservaci�n creada exitosamente.';
    END
    ELSE
    BEGIN
        PRINT 'Error: La habitaci�n no est� disponible para las fechas seleccionadas.';
    END
END