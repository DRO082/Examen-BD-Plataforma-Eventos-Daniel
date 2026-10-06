CREATE PROCEDURE sp_BuscarEvento
    @id_evento INT
AS
BEGIN
    SELECT 
        e.nombre AS NombreEvento,
        e.fecha AS Fecha,
        e.hora AS Hora,
        e.precio AS Precio,
        l.nombre AS Lugar,
        c.nombre AS Categoria
    FROM Eventos e
    INNER JOIN Lugares l ON e.id_lugar = l.id_lugar
    INNER JOIN Categorias c ON e.id_categoria = c.id_categoria
    WHERE e.id_evento = @id_evento;
END;
GO

-- Ejecución y prueba del Reto 1:
EXEC sp_BuscarEvento @id_evento = 1;
GO

CREATE PROCEDURE sp_TotalParticipantes
    @total INT OUTPUT
AS
BEGIN
    SELECT @total = COUNT(*) 
    FROM Participantes;
END;
GO

-- Ejecución y prueba del Reto 2:
DECLARE @cantidadTotal INT;

EXEC sp_TotalParticipantes 
    @total = @cantidadTotal OUTPUT;

SELECT @cantidadTotal AS TotalParticipantes;
GO

CREATE PROCEDURE sp_CalcularRecaudoEvento
    @id_evento INT,
    @recaudo DECIMAL(18,2) OUTPUT
AS
BEGIN
    DECLARE @precio DECIMAL(10,2);
    DECLARE @total_inscritos INT;

    -- 1. Obtener el precio del evento
    SELECT @precio = precio 
    FROM Eventos 
    WHERE id_evento = @id_evento;

    -- 2. Obtener el número de personas inscritas al evento
    SELECT @total_inscritos = COUNT(*) 
    FROM Inscripciones 
    WHERE id_evento = @id_evento;

    -- 3. Calcular el valor del recaudo total
    SET @recaudo = ISNULL(@total_inscritos, 0) * ISNULL(@precio, 0);
END;
GO

-- Ejecución y prueba del Reto 3:
DECLARE @recaudoEvento DECIMAL(18,2);

EXEC sp_CalcularRecaudoEvento
    @id_evento = 1,
    @recaudo = @recaudoEvento OUTPUT;

SELECT @recaudoEvento AS RecaudoTotalEvento;
GO