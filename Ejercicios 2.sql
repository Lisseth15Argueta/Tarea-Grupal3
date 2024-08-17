--2. Crear un stored procedure para cancelar una reservaci�n.
--El stored procedure debe cambiar el estado de la reservaci�n
--a "cancelado" adem�s debe verificar si existe la reservaci�n antes 
--de cancelarla.

CREATE PROCEDURE CancelReservation
    @BookingID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si la reservaci�n existe
    IF EXISTS (SELECT 1 FROM dbo.Bookings WHERE BookingID = @BookingID)
    BEGIN
        -- Actualizar el estado de la reservaci�n a "cancelado"
        UPDATE dbo.Bookings
        SET Status = 'cancelado'
        WHERE BookingID = @BookingID;

        PRINT 'Reservaci�n cancelada exitosamente.';
    END
    ELSE
    BEGIN
        PRINT 'Error: La reservaci�n no existe.';
    END
END