USE [SOLICITUDES]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDiasLaborales]    Script Date: 08/11/2015 18:17:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[GetDiasLaborales] 
( @FechaInicial DATE, 
@FechaFinal DATE ) 
RETURNS INT 
AS 
BEGIN 

DECLARE @varfecha DATE
DECLARE @diaslaborales int 

SET @varfecha = @FechaInicial 
SET @diaslaborales = 0 


/*WHILE (@varfecha<>(@FechaFinal + 1)) */ 
WHILE ( DATEADD(dd,1,@fechafinal) > @varfecha) 
BEGIN 
IF (DATEPART(dw,@varfecha) NOT IN (1,7)) 
BEGIN 
SET @diaslaborales = @diaslaborales + 1
END 

SET @varfecha =DATEADD(dd,1,@varfecha)
END 

RETURN @diaslaborales 

END
GO
/****** Object:  UserDefinedFunction [dbo].[f_GetGlosaActividad]    Script Date: 08/11/2015 18:17:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  function [dbo].[f_GetGlosaActividad]
( 
 @CODACTIVIDAD INT 
)
RETURNS VARCHAR(50) 
AS
BEGIN 
  DECLARE @DESACTIVIDAD VARCHAR(50)
  
    SELECT @DESACTIVIDAD = UPPER(DESCRIPCION)
      FROM ACTIVIDAD
     WHERE CODACTIVIDAD=@CODACTIVIDAD;
  
   RETURN @DESACTIVIDAD;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetFechaVencimientoActividad]    Script Date: 08/11/2015 18:17:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetFechaVencimientoActividad] 
(
	-- Add the parameters for the function here
@FECHAACTIVIDAD datetime,
@CODACTIVIDAD int
)
RETURNS datetime
AS
BEGIN
	DECLARE 
				@AUXDURACION int,
				@FECHAVENC DATETIME,
				@CANTFERIADOS int,
				@FECHAVENC2 DATETIME,
				@HOY DATETIME,
				@CONTSAB INT,
				@CONTDOM INT,
				@SUMASABDOM INT,
				@DIA DATETIME,
				@AUXDURACION2 INT;
	-- Add the T-SQL statements to compute the return value here
					
-----------CALCULA LA CANTIDAD DE DIAS POR SOLICITUD
SELECT @AUXDURACION = SUM(DURACION) 
FROM   ACTIVIDAD
WHERE  CODACTIVIDAD   =  @CODACTIVIDAD;

-- print @AUXDURACION
-----------ESTIMA LA PRIMERA FECHA DE VENCIMIENTO 
SET @FECHAVENC =(SELECT DATEADD(DD, @AUXDURACION,(SELECT convert(char(10),@FECHAACTIVIDAD,20))))

-- print @FECHAVENC

----------- CUENTA  CUANTOS FERIADOS HAY ENTRE LA FECHA DE LA SOLICITUD Y FECHA ESTIMADA

SELECT @CANTFERIADOS = COUNT(FECHAFERIADO) FROM   FERIADOFINSEMANAS
where FECHAFERIADO between GETDATE() AND @FECHAVENC 

-- print @CANTFERIADOS
---------- ESTIMAMOS UNA NUEVA FECHA
SET @FECHAVENC2 = ( SELECT DATEADD(DD,@CANTFERIADOS,@FECHAVENC))

-- print @FECHAVENC2 

--------  CONTAMOS LOS DIAS SABADOS Y DIAS DOMINGOS

SET @DIA= (SELECT convert(char(10),@FECHAACTIVIDAD,20))

SET @CONTSAB = 0
SET @CONTDOM = 0

WHILE ( @DIA < @FECHAVENC2 )
			BEGIN  
			IF ((SELECT DATEPART(dw,@DIA)) = 7)
					BEGIN
					 SET @CONTSAB = @CONTSAB  + 1
				END 
	
			 IF ((SELECT DATEPART(dw,@DIA)) = 1)
					BEGIN
					SET @CONTDOM = @CONTDOM + 1
					END
						
	SET @DIA = (SELECT convert(char(10),DATEADD(dd,1,@DIA),20))
END
SET @SUMASABDOM = @CONTSAB + @CONTDOM



------------ CALCULAMOS UNA  NUEVA FECHA  DE VENCIMIENTO SUMANDO SABADOS Y DOMINGOS MAS LOS FERIADOS


WHILE (@FECHAVENC < @FECHAVENC2)
			BEGIN 
					IF (DATEPART(dw,(SELECT DATEADD(DD,1,@FECHAVENC)))  IN (1,7))
					BEGIN
						SET @FECHAVENC2 = (DATEADD(DD,1,@FECHAVENC2))
						SET @FECHAVENC = (DATEADD(DD,1,@FECHAVENC))
					END 
					ELSE
					BEGIN
						SET @FECHAVENC = (DATEADD(DD,1,@FECHAVENC)) 
					END
			END
			



WHILE (DATEPART(dw,@FECHAVENC2)  IN (1,7)) OR ((SELECT COUNT(FECHAFERIADO) FROM   FERIADOFINSEMANAS WHERE FECHAFERIADO = @FECHAVENC2 )=1)
		BEGIN 
		 SET @FECHAVENC2 = (SELECT DATEADD(DD,1,@FECHAVENC2))
		END

--RETURN @FECHAVENC2			

-- print @FECHAVENC2

	-- Return the result of the function
	
	RETURN @FECHAVENC2

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetFechaVencimientoFlujoSolicitud]    Script Date: 08/11/2015 18:17:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetFechaVencimientoFlujoSolicitud] 
(
	-- Add the parameters for the function here
@FECHASOLICITUD datetime,
@CODTIPOSOLICITUD int
)
RETURNS datetime
AS
BEGIN
	DECLARE 
				@AUXDURACION int,
				@FECHAESTIMADA int,
				@FECHAVENC DATETIME,
				@CANTFERIADOS int,
				@FECHAVENC2 DATETIME,
				@HOY DATETIME,
				@CONTSAB INT,
				@CONTDOM INT,
				@SUMASABDOM INT,
				@DIA DATETIME,
				@AUXDURACION2 INT;
	-- Add the T-SQL statements to compute the return value here
					
-----------CALCULA LA CANTIDAD DE DIAS POR SOLICITUD
SELECT @AUXDURACION = SUM(B.DURACION) 
FROM   FLUJOSOLICITUD A,    ACTIVIDAD B
WHERE  A.CODACTIVIDAD     = B.CODACTIVIDAD
  AND  A.CODTIPOSOLICITUD = @CODTIPOSOLICITUD;

-- print @AUXDURACION
-----------ESTIMA LA PRIMERA FECHA DE VENCIMIENTO 
SET @FECHAVENC =(SELECT DATEADD(DD, @AUXDURACION,(SELECT convert(char(10),DATEADD(dd,1,@FECHASOLICITUD),20))))

-- print @FECHAVENC

----------- CUENTA  CUANTOS FERIADOS HAY ENTRE LA FECHA DE LA SOLICITUD Y FECHA ESTIMADA

SELECT @CANTFERIADOS = COUNT(FECHAFERIADO) FROM   FERIADOFINSEMANAS
where FECHAFERIADO between GETDATE() AND @FECHAVENC 

-- print @CANTFERIADOS
---------- ESTIMAMOS UNA NUEVA FECHA
SET @FECHAVENC2 = ( SELECT DATEADD(DD,@CANTFERIADOS,@FECHAVENC))

-- print @FECHAVENC2 

--------  CONTAMOS LOS DIAS SABADOS Y DIAS DOMINGOS

SET @DIA= (SELECT convert(char(10),@FECHASOLICITUD,20))

SET @CONTSAB = 0
SET @CONTDOM = 0

WHILE ( @DIA < @FECHAVENC2 )
			BEGIN  
			IF ((SELECT DATEPART(dw,@DIA)) = 7)
					BEGIN
					 SET @CONTSAB = @CONTSAB  + 1
				END 
	
			 IF ((SELECT DATEPART(dw,@DIA)) = 1)
					BEGIN
					SET @CONTDOM = @CONTDOM + 1
					END
						
	SET @DIA = (SELECT convert(char(10),DATEADD(dd,1,@DIA),20))
END
SET @SUMASABDOM = @CONTSAB + @CONTDOM

------------ CALCULAMOS UNA  NUEVA FECHA  DE VENCIMIENTO SUMANDO SABADOS Y DOMINGOS MAS LOS FERIADOS

SET @FECHAVENC2 = ( SELECT DATEADD(DD,@SUMASABDOM,@FECHAVENC))
-- print @FECHAVENC2


WHILE (@FECHAVENC < @FECHAVENC2)
			BEGIN 
					IF (DATEPART(dw,(SELECT DATEADD(DD,1,@FECHAVENC)))  IN (1,7))
					BEGIN
						SET @FECHAVENC2 = (DATEADD(DD,1,@FECHAVENC2))
						SET @FECHAVENC = (DATEADD(DD,1,@FECHAVENC))
					END 
					ELSE
					BEGIN
						SET @FECHAVENC = (DATEADD(DD,1,@FECHAVENC)) 
					END
			END
			
			
			

WHILE (DATEPART(dw,@FECHAVENC2)  IN (1,7)) OR ((SELECT COUNT(FECHAFERIADO) FROM   FERIADOFINSEMANAS WHERE FECHAFERIADO = @FECHAVENC2 )=1)
		BEGIN 
		 SET @FECHAVENC2 = (SELECT DATEADD(DD,1,@FECHAVENC2))
		END

--RETURN @FECHAVENC2			

-- print @FECHAVENC2

	


	-- Return the result of the function
	RETURN @FECHAVENC2

END
GO
