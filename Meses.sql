DECLARE 
    @Mes INT = 11,
    @Anio INT = 2025,
    @MesesRetroceder INT = 2;

;WITH Parametros AS (
    SELECT CAST(DATEFROMPARTS(@Anio, @Mes, 1) AS DATE) AS FechaBase
),
Meses AS (
    SELECT 
        DATEADD(MONTH, -v.number, FechaBase) AS FechaMes
    FROM master..spt_values v
    CROSS JOIN Parametros
    WHERE v.type = 'P'
      AND v.number BETWEEN 1 AND @MesesRetroceder
)
SELECT 
    MONTH(FechaMes) AS Mes,
    YEAR(FechaMes) AS Anio,
    DATEFROMPARTS(YEAR(FechaMes), MONTH(FechaMes), 1) AS InicioMes,
    EOMONTH(FechaMes) AS FinMes
FROM Meses
ORDER BY FechaMes DESC;