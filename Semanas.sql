DECLARE @Mes INT = 10;      -- Ejemplo
DECLARE @Anio INT = 2025;   -- Ejemplo
SET DATEFIRST 1;

;WITH Limites AS
(
    SELECT  
        InicioMes = DATEFROMPARTS(@Anio, @Mes, 1),
        FinMes    = EOMONTH(DATEFROMPARTS(@Anio, @Mes, 1))
),
Semanas AS
(
    SELECT 
        -- Obtener día de la semana del Inicio de mes (2 = Lunes si DATEFIRST = 1)
        FechaInicio = 
            CASE 
                WHEN DATEPART(WEEKDAY, InicioMes) = 2  -- ya es lunes
                    THEN InicioMes
                ELSE 
                    -- Retroceder hasta el lunes anterior
                    DATEADD(DAY, -( (DATEPART(WEEKDAY, InicioMes) + @@DATEFIRST + 5) % 7 ), InicioMes)
            END,
        FinMes
    FROM Limites

    UNION ALL

    SELECT 
        DATEADD(DAY, 7, FechaInicio),
        FinMes
    FROM Semanas
    WHERE DATEADD(DAY, 7, FechaInicio) <= FinMes
),
Resultado AS
(
    SELECT 
        SemanaInicio = CASE 
                            WHEN FechaInicio < (SELECT InicioMes FROM Limites) 
                                THEN (SELECT InicioMes FROM Limites)
                            ELSE FechaInicio 
                       END,
        SemanaFin = CASE 
                        WHEN DATEADD(DAY, 6, FechaInicio) > FinMes 
                            THEN FinMes
                        ELSE DATEADD(DAY, 6, FechaInicio)
                    END
    FROM Semanas
)
SELECT 
    SemanaInicio,
    SemanaFin
FROM Resultado
WHERE SemanaInicio <= SemanaFin
ORDER BY SemanaInicio
OPTION (MAXRECURSION 60);
