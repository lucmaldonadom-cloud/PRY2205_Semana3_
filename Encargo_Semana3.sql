-- ==========================================
-- CASO 1: Análisis de Propiedades
-- ==========================================
SELECT 
    id_tipo_propiedad AS "TIPO",
    COUNT(nro_propiedad) AS "TOTAL_PROPIEDADES",
    TO_CHAR(MAX(valor_arriendo), '$999G999G999') AS "MAX_ARRIENDO",
    TO_CHAR(ROUND(AVG(valor_arriendo), 3), '$999G999G999D000') AS "PROMEDIO_ARRIENDO",
    TO_CHAR(MIN(valor_arriendo), '$999G999G999') AS "MIN_ARRIENDO",
    TO_CHAR(SUM(NVL(valor_gasto_comun, 0)), '$999G999G999') AS "TOTAL_GASTOS_COMUNES"
FROM propiedad
GROUP BY id_tipo_propiedad
ORDER BY COUNT(nro_propiedad) DESC;


-- ==========================================
-- CASO 2: Análisis de Antigüedad de Empleados
-- ==========================================
SELECT 
    INITCAP(e.nombre_emp) || ' ' || INITCAP(e.appaterno_emp) AS "Nombre Empleado",
    TO_CHAR(e.sueldo_emp, '$999G999G999') AS "Sueldo con Formato",
    CASE 
        WHEN e.sueldo_emp > 2000000 THEN 'ALTO'
        ELSE 'MEDIO'
    END AS "Clasificación Sueldo",
    TRUNC(MONTHS_BETWEEN(SYSDATE, e.fecing_emp) / 12) AS "Años Antigüedad",
    CASE 
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, e.fecing_emp) / 12) BETWEEN 5 AND 10 THEN 'Corresponde bono  5%: ' || TO_CHAR(e.sueldo_emp * 0.05, '$999G999G999')
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, e.fecing_emp) / 12) BETWEEN 11 AND 20 THEN 'Corresponde bono 10%: ' || TO_CHAR(e.sueldo_emp * 0.10, '$999G999G999')
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, e.fecing_emp) / 12) > 20 THEN 'Corresponde bono 15%: ' || TO_CHAR(e.sueldo_emp * 0.15, '$999G999G999')
    END AS "BONO"
FROM empleado e
WHERE e.id_categoria_emp = 3
  AND TRUNC(MONTHS_BETWEEN(SYSDATE, e.fecing_emp) / 12) > 5
  AND e.id_sucursal <> 30
ORDER BY e.sueldo_emp DESC;


-- ==========================================
-- CASO 3: Lista de Clientes
-- ==========================================
SELECT 
    numrut_cli AS "RUN Cliente",
    dvrut_cli AS "DV",
    appaterno_cli || ' ' || apmaterno_cli || ' ' || nombre_cli AS "Nombre Completo",
    TO_CHAR(renta_cli, '$999G999G999') AS "Renta",
    fonofijo_cli AS "Teléfono Fijo",
    celular_cli AS "Celular"
FROM cliente
WHERE renta_cli >= 300000
ORDER BY appaterno_cli ASC, nombre_cli ASC
FETCH FIRST 10 ROWS ONLY;