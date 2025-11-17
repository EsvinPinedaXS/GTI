DECLARE 
    @Mes INT = 11,
    @Anio INT = 2025,
    @MesesRetroceder INT = 2;

;WITH FechaBase AS (
    SELECT DATEFROMPARTS(@Anio, @Mes, 1) AS FechaInicio
),
Recursivo AS (
    SELECT 
        1 AS N,
        DATEADD(MONTH, -1, FechaInicio) AS FechaMes
    FROM FechaBase

    UNION ALL

    SELECT
        N + 1,
        DATEADD(MONTH, -1, FechaMes)
    FROM Recursivo
    WHERE N + 1 <= @MesesRetroceder
)
SELECT
    MONTH(FechaMes) AS Mes,
    YEAR(FechaMes) AS Anio,
    DATEFROMPARTS(YEAR(FechaMes), MONTH(FechaMes), 1) AS InicioMes,
    EOMONTH(FechaMes) AS FinMes
FROM Recursivo
ORDER BY FechaMes DESC;
