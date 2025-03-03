USE [SOLICITUDES]
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByDinamicaInternas_Solicitudes]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByDinamicaInternas_Solicitudes]
(
@FOLIOSOLICITUD int,
@CODCLI varchar(30),
@CODTIPOSOLICITUD int,
@CODESTADOSOL int,
@FECHASOLICITUD datetime,
@FECHASOLICITUDHASTA datetime,
@FECHARESOLUCION datetime,
@FECHARESOLUCIONHASTA datetime
)

AS BEGIN
BEGIN
    TRY
declare @SQL VARCHAR(MAX)
declare @sw int

declare @FechaFinal datetime
SET @FechaFinal = DATEADD(day, 1, @FECHASOLICITUD)

 --   set @SQL = 'SELECT
 --           A.FOLIOSOLICITUD,
 --           A.FECHASOLICITUD,
 --           A.CODCLI,
 --           A.FECHARESOLUCION,
 --           A.OBSSOLUCION,
 --           A.GLOSASOLICITUD,
 --           B.DESCTIPOSOLICITUD,
 --           C.NOMBRE, C.PATERNO, C.MATERNO,
 --           D.NOMBRE_L,
 --           E.DESCESTADO,
 --           F.JORNADA,
 --           A.ORIGEN
 --           FROM    SOLICITUD A
 --   INNER JOIN TIPOSOLICITUD B ON A.CODTIPOSOLICITUD = B.CODTIPOSOLICITUD
 --   JOIN TestUmasNet.dbo.MT_CLIENT C ON A.CODCLI = C.CODCLI
 --   JOIN  TestUmasNet.dbo.MT_CARRER D ON A.CODCARR = D.CODCARR
 --   INNER JOIN ESTADOS E ON A.CODESTADOSOL = E.CODESTADO
	--FULL OUTER JOIN   TestUmasNet.dbo.MT_ALUMNO F ON A.CODCLI = F.CODCLI
 --   WHERE 1=1'
    
    
    set @SQL = 'SELECT
            A.FOLIOSOLICITUD,
            A.FECHASOLICITUD,
            A.CODCLI,
            A.FECHARESOLUCION,
            A.OBSSOLUCION,
            A.GLOSASOLICITUD,
            B.DESCTIPOSOLICITUD,
            C.NOMBRE, 
            C.APELLIDO,
            E.DESCESTADO,
            A.ORIGEN
            FROM    SOLICITUD A
            INNER JOIN TIPOSOLICITUD B ON A.CODTIPOSOLICITUD = B.CODTIPOSOLICITUD
            INNER JOIN USUARIO C ON A.CODCLI = C.RUTUSUARIO
            INNER JOIN ESTADOS E ON A.CODESTADOSOL = E.CODESTADO
            WHERE 1=1' 

    set @SQL = @SQL + ' AND A.ORIGEN = '+ CHAR(39) + 'I' + CHAR(39)

    if(@FOLIOSOLICITUD is not null)
        BEGIN
            set @SQL = @SQL + 'AND FOLIOSOLICITUD = ' + STR(@FOLIOSOLICITUD)
        END

    if (@CODCLI is not null)
        BEGIN
        set @SQL = @SQL + ' AND A.CODCLI = '+ CHAR(39) + @CODCLI + CHAR(39)
        END

    if (@CODTIPOSOLICITUD is not null)
        BEGIN
        set @SQL = @SQL + ' AND A.CODTIPOSOLICITUD = ' + STR(@CODTIPOSOLICITUD)
        END

    if (@CODESTADOSOL  is not null)
        BEGIN
        set @SQL = @SQL + ' AND A.CODESTADOSOL = ' + STR(@CODESTADOSOL)
        END

    if(@FECHASOLICITUD is not null and @FECHASOLICITUDHASTA is null)
        BEGIN
        set @SQL = @SQL + ' AND A.FECHASOLICITUD between '+ CHAR(39) + convert(char(10),@FECHASOLICITUD,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHASOLICITUD),20)+ CHAR(39)
        END

    if(@FECHASOLICITUDHASTA is not null and @FECHASOLICITUD is null)
        BEGIN
        set @SQL = @SQL + ' AND A.FECHASOLICITUD between '+ CHAR(39) + convert(char(10),@FECHASOLICITUDHASTA,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHASOLICITUDHASTA),20)+ CHAR(39)
        END

    if (@FECHASOLICITUD is not null and @FECHASOLICITUDHASTA is not null )
        BEGIN
        set @SQL =  @SQL +' AND.A.FECHASOLICITUD between ' + CHAR(39) + convert(char(10),@FECHASOLICITUD,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHASOLICITUDHASTA),20)+ CHAR(39)
        END

    if(@FECHARESOLUCION is not null and @FECHARESOLUCIONHASTA is null )
        BEGIN
        set @SQL = @SQL + ' AND A.FECHARESOLUCION between  '+ CHAR(39)  + CONVERT(char(10),@FECHARESOLUCION,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHARESOLUCION),20)+ CHAR(39)
        END

    if(@FECHARESOLUCIONHASTA is not null and @FECHARESOLUCION is null )
        BEGIN
        set @SQL = @SQL + ' AND A.FECHARESOLUCION between  '+ CHAR(39)  + CONVERT(char(10),@FECHARESOLUCIONHASTA,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHARESOLUCIONHASTA),20)+ CHAR(39)
        END

    if(@FECHARESOLUCION is not null and @FECHARESOLUCIONHASTA is not null )
        BEGIN
        set @SQL = @SQL + ' AND A.FECHARESOLUCION between  '+ CHAR(39)  + CONVERT(char(10),@FECHARESOLUCION,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHARESOLUCIONHASTA),20)+ CHAR(39)
        END

    
    
PRINT @SQL
EXEC (@SQL)
END try
BEGIN CATCH
    BEGIN
        SELECT ERROR_MESSAGE()
    END

END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByDinamica_Solicitudes]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByDinamica_Solicitudes]
(
@FOLIOSOLICITUD int,
@CODCLI varchar(30),
@CODTIPOSOLICITUD int,
@CODCARR varchar(30),
@CODESTADOSOL int,
@FECHASOLICITUD datetime,
@FECHASOLICITUDHASTA datetime,
@FECHARESOLUCION datetime,
@FECHARESOLUCIONHASTA datetime,
@JORNADA varchar (30),
@ORIGEN VARCHAR(1))

AS BEGIN
BEGIN
    TRY
declare @SQL VARCHAR(MAX)
declare @sw int

declare @FechaFinal datetime
SET @FechaFinal = DATEADD(day, 1, @FECHASOLICITUD)

    set @SQL = 'SELECT
            A.FOLIOSOLICITUD,
            A.FECHASOLICITUD,
            A.CODCLI,
            A.FECHARESOLUCION,
            A.OBSSOLUCION,
            A.GLOSASOLICITUD,
            B.DESCTIPOSOLICITUD,
            C.NOMBRE, C.PATERNO, C.MATERNO,
            D.NOMBRE_L,
            E.DESCESTADO,
            F.JORNADA,
            A.ORIGEN
            FROM    SOLICITUD A
    INNER JOIN TIPOSOLICITUD B ON A.CODTIPOSOLICITUD = B.CODTIPOSOLICITUD
    FULL OUTER JOIN TestUmasNet.dbo.MT_CLIENT C ON A.CODCLI = C.CODCLI
    FULL OUTER JOIN  TestUmasNet.dbo.MT_CARRER D ON A.CODCARR = D.CODCARR
    INNER JOIN ESTADOS E ON A.CODESTADOSOL = E.CODESTADO
	FULL OUTER JOIN  TestUmasNet.dbo.MT_ALUMNO F ON A.CODCLI = F.CODCLI
    WHERE 1=1'

   set @SQL = @SQL + ' AND A.ORIGEN = '+ CHAR(39) + 'E' + CHAR(39)

    if(@FOLIOSOLICITUD is not null)
        BEGIN
            set @SQL = @SQL + 'AND FOLIOSOLICITUD = ' + STR(@FOLIOSOLICITUD)
        END

    if (@CODCLI is not null)
        BEGIN
        set @SQL = @SQL + ' AND A.CODCLI = '+ CHAR(39) + @CODCLI + CHAR(39)
        END

    if (@CODTIPOSOLICITUD is not null)
        BEGIN
        set @SQL = @SQL + ' AND A.CODTIPOSOLICITUD = ' + STR(@CODTIPOSOLICITUD)
        END

    if (@CODCARR  is not null)
        BEGIN
        set @SQL = @SQL + ' AND A.CODCARR = '+ CHAR(39) + @CODCARR + CHAR(39)
        END

    if (@CODESTADOSOL  is not null)
        BEGIN
        set @SQL = @SQL + ' AND A.CODESTADOSOL = ' + STR(@CODESTADOSOL)
        END

    if(@FECHASOLICITUD is not null and @FECHASOLICITUDHASTA is null)
        BEGIN
        set @SQL = @SQL + ' AND A.FECHASOLICITUD between '+ CHAR(39) + convert(char(10),@FECHASOLICITUD,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHASOLICITUD),20)+ CHAR(39)
        END

    if(@FECHASOLICITUDHASTA is not null and @FECHASOLICITUD is null)
        BEGIN
        set @SQL = @SQL + ' AND A.FECHASOLICITUD between '+ CHAR(39) + convert(char(10),@FECHASOLICITUDHASTA,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHASOLICITUDHASTA),20)+ CHAR(39)
        END

    if (@FECHASOLICITUD is not null and @FECHASOLICITUDHASTA is not null )
        BEGIN
        set @SQL =  @SQL +' AND.A.FECHASOLICITUD between ' + CHAR(39) + convert(char(10),@FECHASOLICITUD,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHASOLICITUDHASTA),20)+ CHAR(39)
        END

    if(@FECHARESOLUCION is not null and @FECHARESOLUCIONHASTA is null )
        BEGIN
        set @SQL = @SQL + ' AND A.FECHARESOLUCION between  '+ CHAR(39)  + CONVERT(char(10),@FECHARESOLUCION,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHARESOLUCION),20)+ CHAR(39)
        END

    if(@FECHARESOLUCIONHASTA is not null and @FECHARESOLUCION is null )
        BEGIN
        set @SQL = @SQL + ' AND A.FECHARESOLUCION between  '+ CHAR(39)  + CONVERT(char(10),@FECHARESOLUCIONHASTA,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHARESOLUCIONHASTA),20)+ CHAR(39)
        END

    if(@FECHARESOLUCION is not null and @FECHARESOLUCIONHASTA is not null )
        BEGIN
        set @SQL = @SQL + ' AND A.FECHARESOLUCION between  '+ CHAR(39)  + CONVERT(char(10),@FECHARESOLUCION,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHARESOLUCIONHASTA),20)+ CHAR(39)
        END

    if (@JORNADA  is not null)
        BEGIN
        set @SQL = @SQL + ' AND A.JORNADA = ' + CHAR(39) + @JORNADA + CHAR(39)
        END


    IF (@ORIGEN IS NOT NULL)
        BEGIN
        SET @SQL = @SQL  +  ' AND A.ORIGEN = ' + CHAR(39)+ @ORIGEN  + CHAR(39)
        END


PRINT @SQL
EXEC (@SQL)
END try
BEGIN CATCH
    BEGIN
        SELECT ERROR_MESSAGE()
    END

END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByDinamica_DetalleSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Get_Consulta_ByDinamica_DetalleSolicitud]
AS BEGIN
BEGIN
    TRY
declare @SQL VARCHAR(MAX)
declare @sw int

declare @FechaFinal datetime

set @SQL = '  SELECT  A.FOLIOSOLICITUD, 
			   A.SECUENCIA, 
			   A.CODTIPOSOLICITUD,
			   B.DESCRIPCION,
			   A.CODACTIVIDAD,
			   A.RUTUSUARIO,
			   C.NOMBRE, 
			   C.APELLIDO,    
			   A.FECHAVENCSOL,
			   A.CODESTADO,
			   A.DIASATRASO,
			   D.DESCESTADO,
			   A.FECHARESOLUCION,
			   A.FECHARECEP,
			   A.FECHAEJECACTIVIDAD,
			   A.GLOSADETALLESOL                 
		  FROM DETALLESOLICITUD A,
			   ACTIVIDAD B,
			   USUARIO C, 
			   ESTADOS D
		WHERE  A.CODACTIVIDAD   = B.CODACTIVIDAD
		  AND  A.RUTUSUARIO     = C.RUTUSUARIO 
		  AND  A.CODESTADO      = D.CODESTADO
		  WHERE 1=1 '
      
      
PRINT @SQL
EXEC (@SQL)
END try
BEGIN CATCH
    BEGIN
        SELECT ERROR_MESSAGE()
    END

END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByDinamica_Auditoria]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByDinamica_Auditoria]

(
   @RUTUSUARIO VARCHAR(10),
   @FECHA      DATETIME,
   @FECHAHASTA DATETIME,
   @IP         VARCHAR(MAX),
   @DISPOSITIVO VARCHAR(50) 
)
AS BEGIN
BEGIN 
	TRY
declare @SQL VARCHAR(MAX)

set @SQL = 'SELECT A.RUTUSUARIO,
					(B.NOMBRE +'' ''+B.APELLIDO) AS NOMBRE,
					A.FECHA, 
					A.IP, 
					A.MODULO, 
					A.ACCION, 
					A.OBSERVACION, 
					A.DISPOSITIVO,
					A.NOMBREMAQUINA,
					A.MACADDRESS
					FROM AUDITORIA A
					INNER JOIN USUARIO B ON A.RUTUSUARIO = B.RUTUSUARIO                 
					WHERE 1=1'
                   
        if(@RUTUSUARIO is not null) 
		BEGIN
			set @SQL = @SQL + ' AND A.RUTUSUARIO = ' + CHAR(39) + (@RUTUSUARIO)+CHAR(39) 
	    END
	    
	    if(@FECHA is not null and @FECHAHASTA is null)
		BEGIN 
		set @SQL = @SQL + ' AND A.FECHA between '+ CHAR(39) + convert(char(10),@FECHA,20)+ CHAR(39)+
											' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHA),20)+ CHAR(39) 
		END
		
		 if(@FECHAHASTA is not null and @FECHA is null)
		BEGIN 
		set @SQL = @SQL + ' AND A.FECHA between '+ CHAR(39) + convert(char(10),@FECHAHASTA,20)+ CHAR(39)+
											' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHAHASTA),20)+ CHAR(39) 
		END
		
			    if(@FECHA is not null and @FECHAHASTA is not null)
		BEGIN 
		set @SQL = @SQL + ' AND A.FECHA between '+ CHAR(39) + convert(char(10),@FECHA,20)+ CHAR(39)+
											' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHAHASTA),20)+ CHAR(39) 
		END
											
	    if(@IP is not null) 
		BEGIN 
			set @SQL = @SQL + 'AND A.IP LIKE ' + CHAR(39) +'%' + @IP + '%'+CHAR(39)
	    END
	   
	      if(@DISPOSITIVO is not null) 
		BEGIN 
			set @SQL = @SQL + 'AND A.DISPOSITIVO = ' + CHAR(39) + (@DISPOSITIVO) +CHAR(39)
	    END
		    
	   SET @SQL = @SQL + ' ORDER BY A.FECHA  ASC' 

PRINT @SQL
EXEC (@SQL)
END try
BEGIN CATCH
	BEGIN 
		SELECT ERROR_MESSAGE() 
	END

END CATCH        

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByDinamica_Actividad]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        <Author,,Name>
-- Create date: <Create Date,,>
-- Description:    <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByDinamica_Actividad]
    -- Add the parameters for the stored procedure here
@TIPOSOLICITUD INT,
@TIPOACTIVIDAD INT,
@ESTADO INT,
@CODUNIDAD INT,
@FECHARECEPCIONDESDE DATETIME,
@FECHARECEPCIONHASTA DATETIME,
@FECHAEJECUCIONDESDE DATETIME,
@FECHAEJECUCIONHASTA DATETIME,
@FECHARESOLUCIONDESDE DATETIME,
@FECHARESOLUCIONHASTA DATETIME 


AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

BEGIN
    TRY
declare @SQL VARCHAR(MAX)
declare @sw int

    SET @SQL = 'SELECT		A.FOLIOSOLICITUD,
                                            A.SECUENCIA,
                                            B.DESCTIPOSOLICITUD,
                                            C.DESCRIPCION,
                                            (D.NOMBRE +'' ''+ D.APELLIDO) AS NOMBRE,
                                             A.GLOSADETALLESOL, E.DESCESTADO,
                                            A.FECHAEJECACTIVIDAD,
                                            A.FECHAVENCSOL,
                                            A.DIASATRASO,
                                            A.FECHARESOLUCION,
                                            A.FECHARECEP,
											G.DESCUNIDAD
    FROM DETALLESOLICITUD A
    INNER JOIN TIPOSOLICITUD B  ON A.CODTIPOSOLICITUD = B. CODTIPOSOLICITUD
    INNER JOIN ACTIVIDAD C ON A.CODACTIVIDAD = C.CODACTIVIDAD
    FULL OUTER JOIN USUARIO D ON A.RUTUSUARIO = D.RUTUSUARIO
    INNER JOIN ESTADOS E ON A.CODESTADO = E.CODESTADO
    INNER JOIN ACTIVIDAD F ON A.CODACTIVIDAD = F.CODACTIVIDAD
    INNER JOIN UNIDADES G ON A.CODUNIDAD = G.CODUNIDAD 
    WHERE 1=1  '

    IF(@TIPOSOLICITUD IS NOT NULL)
    BEGIN
        SET @SQL = @SQL +  ' AND A.CODTIPOSOLICITUD = ' + STR(@TIPOSOLICITUD)
    END

    IF(@TIPOACTIVIDAD IS NOT NULL)
    BEGIN
        SET @SQL = @SQL + ' AND A.CODACTIVIDAD = ' + STR( @TIPOACTIVIDAD)
    END

    IF (@ESTADO IS NOT NULL)
    BEGIN
        SET @SQL = @SQL + ' AND A.CODESTADO = ' + STR(@ESTADO)
    END


    if(@FECHARECEPCIONDESDE is not null and @FECHARECEPCIONHASTA is null)
        BEGIN
        set @SQL = @SQL + ' AND A.FECHARECEP between '+ CHAR(39) + convert(char(10),@FECHARECEPCIONDESDE,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHARECEPCIONDESDE),20)+ CHAR(39)
        END

    if(@FECHARECEPCIONHASTA is not null and @FECHARECEPCIONDESDE is null)
        BEGIN
        set @SQL = @SQL + ' AND A.FECHARECEP between '+ CHAR(39) + convert(char(10),@FECHARECEPCIONHASTA,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHARECEPCIONHASTA),20)+ CHAR(39)
        END

    if (@FECHARECEPCIONDESDE is not null and @FECHARECEPCIONHASTA is not null )
        BEGIN
        set @SQL =  @SQL +' AND A.FECHARECEP between ' + CHAR(39) + convert(char(10),@FECHARECEPCIONDESDE,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHARECEPCIONHASTA),20)+ CHAR(39)
        END


        if(@FECHAEJECUCIONDESDE is not null and @FECHAEJECUCIONHASTA is null)
        BEGIN
        set @SQL = @SQL + ' AND A.FECHAEJECACTIVIDAD between '+ CHAR(39) + convert(char(10),@FECHAEJECUCIONDESDE,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHAEJECUCIONDESDE),20)+ CHAR(39)
        END

    if(@FECHAEJECUCIONHASTA is not null and @FECHAEJECUCIONDESDE is null)
        BEGIN
        set @SQL = @SQL + ' AND A.FECHAEJECACTIVIDAD between '+ CHAR(39) + convert(char(10),@FECHAEJECUCIONHASTA,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHAEJECUCIONHASTA),20)+ CHAR(39)
        END

    if (@FECHAEJECUCIONDESDE is not null and @FECHAEJECUCIONHASTA is not null )
        BEGIN
        set @SQL =  @SQL +' AND A.FECHAEJECACTIVIDAD between ' + CHAR(39) + convert(char(10),@FECHAEJECUCIONDESDE,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHAEJECUCIONHASTA),20)+ CHAR(39)
        END

        if(@FECHARESOLUCIONDESDE is not null and @FECHARESOLUCIONHASTA is null)
        BEGIN
        set @SQL = @SQL + ' AND A.FECHARESOLUCION between '+ CHAR(39) + convert(char(10),@FECHARESOLUCIONDESDE,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHARESOLUCIONDESDE),20)+ CHAR(39)
        END

    if(@FECHARESOLUCIONHASTA is not null and @FECHARESOLUCIONDESDE is null)
        BEGIN
        set @SQL = @SQL + ' AND A.FECHARESOLUCION between '+ CHAR(39) + convert(char(10),@FECHARESOLUCIONHASTA,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHARESOLUCIONHASTA),20)+ CHAR(39)
        END

    if (@FECHARESOLUCIONDESDE is not null and @FECHARESOLUCIONHASTA is not null )
        BEGIN
        set @SQL =  @SQL +' AND A.FECHARESOLUCION between ' + CHAR(39) + convert(char(10),@FECHARESOLUCIONDESDE,20)+ CHAR(39)+
                                                            ' and ' + CHAR(39) + convert(char(10),DATEADD(dd,1,@FECHARESOLUCIONHASTA),20)+ CHAR(39)
        END
       
          IF(@CODUNIDAD IS NOT NULL)
    BEGIN
        SET @SQL = @SQL +  ' AND A.CODUNIDAD = ' + STR(@CODUNIDAD)
    END
        

PRINT @SQL
EXEC (@SQL)
END try
BEGIN CATCH
    BEGIN
        SELECT ERROR_MESSAGE()
    END
END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Borra_RolesPrivilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Borra_RolesPrivilegios]
	
	(

	@CODPRIVILEGIOS int,
	@CODROL int
	
	)
	
AS
	DELETE ROLESPRIVIOS WHERE CODPRIVILEGIOS = @CODPRIVILEGIOS AND CODROL=@CODROL
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByCodUnidad_Usuarios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByCodUnidad_Usuarios]
(
 @CODUNIDAD int 
)
AS

SELECT COUNT(*) AS CANTIDAD
FROM USUARIOS
WHERE CODUNIDAD  = @CODUNIDAD;
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Inserta_Unidad]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Inserta_Unidad]
	
	(
	@DESCUNIDAD varchar(50),
	@ESTADOUNIDAD int
	)
	
AS
	INSERT INTO UNIDADES (DESCUNIDAD, ESTADOUNIDAD) VALUES (@DESCUNIDAD, @ESTADOUNIDAD)
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Inserta_TipoSol]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Inserta_TipoSol]
	
	(
	
	@DESCTIPOSOLICITUD varchar(50),
	@ESTADOSOLICITUD int,
	@FECHAINICIO datetime,
	@FECHAFIN datetime,
	@CANTMAXSOLICITUD int,
	@ORIGEN varchar(1),
	@CANTMAXDOC int
	)
	
AS
	INSERT INTO TIPOSOLICITUD(DESCTIPOSOLICITUD, ESTADOSOLICITUD, FECHAINICIO, FECHAFIN, CANTMAXSOLICITUD, ORIGEN, CANTMAXDOC) VALUES (@DESCTIPOSOLICITUD,@ESTADOSOLICITUD,  @FECHAINICIO, @FECHAFIN, @CANTMAXSOLICITUD, @ORIGEN,@CANTMAXDOC )
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Inserta_Feriados]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Inserta_Feriados]
	
	(

	@DESCRIPCIONFERIADO varchar(50),
	@FECHAFERIADO datetime
	)
	
AS
	INSERT INTO FERIADOFINSEMANAS (DESCRIPCIONFERIADO,FECHAFERIADO) 
	VALUES (@DESCRIPCIONFERIADO,@FECHAFERIADO)
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Inserta_Rol]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Inserta_Rol]
	
	(
	@DESCRIPCION varchar(50),
	@ESTADOROL int
	)
	
AS
	INSERT INTO ROL (DESCRIPCION, ESTADOROL) VALUES (@DESCRIPCION, @ESTADOROL)
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Inserta_Privilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Set_Inserta_Privilegios]
	
	(
	@DESCPRIVILEGIOS varchar(50),
	@NOMPRIVILEGIOS varchar(50),
	@ESTADOPRIVILEGIOS int
	)
	
AS
	INSERT INTO PRIVILEGIOS (DESCPRIVILEGIOS,NOMPRIVILEGIOS,ESTADOPRIVILEGIOS) VALUES (@DESCPRIVILEGIOS,@NOMPRIVILEGIOS,@ESTADOPRIVILEGIOS)
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Inserta_Actividad]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Inserta_Actividad]
	
	(
	@DESCRIPCION varchar(50),
	@DURACION int,
	@ESTADOACTIVIDAD int
	)
	
AS
	INSERT INTO ACTIVIDAD(DESCRIPCION, DURACION,ESTADOACTIVIDAD) VALUES (@DESCRIPCION, @DURACION,@ESTADOACTIVIDAD)
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[Sp_Set_Elimina_TipoSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Set_Elimina_TipoSolicitud]
	
	(
	@CODTIPOSOLICITUD int
	
	)
	
AS
	DELETE TIPOSOLICITUD WHERE CODTIPOSOLICITUD = @CODTIPOSOLICITUD
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Borra_Rol]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Borra_Rol]
	
	(
	@CODROL int
	
	)
	
AS
	DELETE ROL WHERE CODROL = @CODROL
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Borra_Privilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Borra_Privilegios]
	
	(
	@CODPRIVILEGIOS int
	
	)
	
AS
	DELETE PRIVILEGIOS WHERE CODPRIVILEGIOS = @CODPRIVILEGIOS
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Borra_Feriados]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Borra_Feriados]
	
	(

	@CODFERIADO int
		
	)
	
AS
	DELETE FERIADOFINSEMANAS WHERE CODFERIADO = @CODFERIADO
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Borra_Actividad]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Borra_Actividad]
	
	(
	@CODACTIVIDAD int
	
	)
	
AS
	DELETE ACTIVIDAD WHERE CODACTIVIDAD = @CODACTIVIDAD
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_ActualizaByTipo_Solicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_ActualizaByTipo_Solicitud]
	
	(
	@CODTIPOSOLICITUD int,
	@DESCTIPOSOLICITUD varchar(50),	
	@ESTADOSOLICITUD int,
	@FECHAINICIO datetime,
	@FECHAFIN datetime,
	@CANTMAXSOLICITUD int,
	@ORIGEN varchar(1),
	@CANTMAXDOC int
	)
	
AS
	UPDATE TIPOSOLICITUD 
	SET DESCTIPOSOLICITUD = @DESCTIPOSOLICITUD, 
		ESTADOSOLICITUD =@ESTADOSOLICITUD,
	    FECHAINICIO =@FECHAINICIO, 
	    FECHAFIN = @FECHAFIN,
		CANTMAXSOLICITUD = @CANTMAXSOLICITUD,
		ORIGEN = @ORIGEN,
		CANTMAXDOC = @CANTMAXDOC
	    WHERE CODTIPOSOLICITUD = @CODTIPOSOLICITUD
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_Unidad]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Actualiza_Unidad]
	
	(
	@CODUNIDAD int,
	@DESCUNIDAD varchar(50),
	@ESTADOUNIDAD INT	
	)
	
AS
	UPDATE UNIDADES 
	SET DESCUNIDAD = @DESCUNIDAD, ESTADOUNIDAD = @ESTADOUNIDAD
	WHERE CODUNIDAD = @CODUNIDAD
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_Rol]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Actualiza_Rol]
	
	(
	@CODROL int,
	@DESCRIPCION varchar(50)	
	)
	
AS
	UPDATE ROL 
	SET DESCRIPCION = @DESCRIPCION
	WHERE CODROL = @CODROL
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_Privilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Actualiza_Privilegios]
	
	(
	@CODPRIVILEGIOS int,
	@DESCPRIVILEGIOS varchar(50),
	@NOMPRIVILEGIOS varchar(50),
	@ESTADOPRIVILEGIOS int	
	)
	
AS
	UPDATE PRIVILEGIOS 
	SET DESCPRIVILEGIOS = @DESCPRIVILEGIOS, NOMPRIVILEGIOS = @NOMPRIVILEGIOS, ESTADOPRIVILEGIOS= @ESTADOPRIVILEGIOS
	WHERE CODPRIVILEGIOS = @CODPRIVILEGIOS
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_Feriados]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Actualiza_Feriados]
	
	(
	@CODFERIADO int,
	@DESCRIPCIONFERIADO varchar(50),
	@FECHAFERIADO datetime 

	)
	
AS
	UPDATE FERIADOFINSEMANAS 
	SET DESCRIPCIONFERIADO = @DESCRIPCIONFERIADO, FECHAFERIADO = @FECHAFERIADO
	WHERE CODFERIADO = @CODFERIADO
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_EstadoRol]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Actualiza_EstadoRol]
	
	(
		@CODROL int,
		@ESTADOROL int	
	)
	
AS
	UPDATE ROL 
	SET ESTADOROL = @ESTADOROL
	WHERE CODROL = @CODROL
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_ByCodEstado_Rol]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Actualiza_ByCodEstado_Rol]
	
	(
	@CODROL int,
	@ESTADOROL int		
	)
	
AS
	UPDATE ROL 
	SET ESTADOROL = @ESTADOROL
	WHERE CODROL = @CODROL
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_ByCodEstado_Privilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Actualiza_ByCodEstado_Privilegios]
	
	(
	@CODPRIVILEGIOS int,
	@ESTADOPRIVILEGIOS int		
	)
	
AS
	UPDATE PRIVILEGIOS 
	SET ESTADOPRIVILEGIOS = @ESTADOPRIVILEGIOS
	WHERE CODPRIVILEGIOS = @CODPRIVILEGIOS
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_Actividad]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Actualiza_Actividad]
	
	(
	@CODACTIVIDAD int,
	@DESCRIPCION varchar(50),
	@DURACION int,
	@ESTADOACTIVIDAD int
	)
	
AS
	UPDATE ACTIVIDAD 
	SET DESCRIPCION = @DESCRIPCION, DURACION = @DURACION ,  ESTADOACTIVIDAD = @ESTADOACTIVIDAD
	WHERE CODACTIVIDAD = @CODACTIVIDAD
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_Unidad]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_Unidad]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CODUNIDAD,
				  DESCUNIDAD,	              	
	             (SELECT CASE ESTADOUNIDAD WHEN '0' THEN 'INACTIVO' WHEN 1 THEN 'ACTIVO' END) AS ESTADOUNIDAD  
	FROM UNIDADES

	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_TipoSolicitudes]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_TipoSolicitudes]
	
	
	
AS

	SELECT CODTIPOSOLICITUD,
				 DESCTIPOSOLICITUD, 
				 (SELECT CASE ESTADOSOLICITUD WHEN '0' THEN 'INACTIVO' WHEN 1 THEN 'ACTIVO' END) AS ESTADOSOLICITUD, 
				 FECHAINICIO, 
				 FECHAFIN, 
				 CANTMAXSOLICITUD, 
				 (SELECT CASE ORIGEN WHEN 'i' THEN 'INTERNO' WHEN 'E'THEN 'EXTERNO' END) AS ORIGEN, 
				 CANTMAXDOC
				 
	FROM TIPOSOLICITUD
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_Rol]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_Rol]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CODROL,
				  DESCRIPCION,
				 (SELECT CASE ESTADOROL WHEN '0' THEN 'INACTIVO' WHEN 1 THEN 'ACTIVO' END) AS ESTADOROL 
	FROM ROL

	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_Privilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_Privilegios]

AS

BEGIN
	
SET NOCOUNT ON; 

SELECT  CODPRIVILEGIOS, 
DESCPRIVILEGIOS, 
NOMPRIVILEGIOS, 
(SELECT CASE ESTADOPRIVILEGIOS WHEN '0' THEN 'INACTIVO' WHEN 1 THEN 'ACTIVO' END) AS ESTADOPRIVILEGIOS 
FROM  PRIVILEGIOS
  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_Feriados]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Get_Consulta_Feriados]

AS

BEGIN
	
SET NOCOUNT ON; 

SELECT  CODFERIADO, DESCRIPCIONFERIADO, FECHAFERIADO
FROM  FERIADOFINSEMANAS
  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByTipo_Solicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Get_Consulta_ByTipo_Solicitud] 
(
 @CODTIPOSOLICITUD int 
)
as 
select  DESCTIPOSOLICITUD
  FROM  TIPOSOLICITUD
  WHERE CODTIPOSOLICITUD = @CODTIPOSOLICITUD;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_Estados]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Get_Consulta_Estados]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CODESTADO, DESCESTADO 
	FROM ESTADOS 
	WHERE CODESTADO <= 4;
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_CantMaxDoc_ByTipo_Solicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Get_Consulta_CantMaxDoc_ByTipo_Solicitud] 
(
 @CODTIPOSOLICITUD int 
)
as 
select  CANTMAXDOC
  FROM  TIPOSOLICITUD
  WHERE CODTIPOSOLICITUD = @CODTIPOSOLICITUD;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByRol_Rol]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByRol_Rol]
	(
	@CODROL INT
	)
AS
	SELECT CODROL, DESCRIPCION, ESTADOROL 
	FROM ROL
	WHERE CODROL = @CODROL;

	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByPrivilegios_Privilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Get_Consulta_ByPrivilegios_Privilegios]
	(
	@DESCPRIVILEGIOS VARCHAR(50)
	)
AS
	SELECT COUNT(*)
	AS CANTIDAD 
	FROM PRIVILEGIOS
	WHERE DESCPRIVILEGIOS = @DESCPRIVILEGIOS

	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByPrivilegios_NomPrivilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_Get_Consulta_ByPrivilegios_NomPrivilegios]
	(
	@NOMPRIVILEGIOS VARCHAR(50)
	)
AS
	SELECT COUNT(*)
	AS CANTIDAD 
	FROM PRIVILEGIOS
	WHERE NOMPRIVILEGIOS = @NOMPRIVILEGIOS

	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByDescripcionUnidades_Unidades]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByDescripcionUnidades_Unidades]
	(
	@DESCUNIDAD VARCHAR(50)
	)
AS
	SELECT COUNT(*)
	AS CANTIDAD 
	FROM UNIDADES
	WHERE DESCUNIDAD = @DESCUNIDAD

	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByCodUnidad_Unidades]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByCodUnidad_Unidades]
	(
	@CODUNIDAD INT
	)
AS
	SELECT CODUNIDAD, DESCUNIDAD, ESTADOUNIDAD 
	FROM UNIDADES
	WHERE CODUNIDAD = @CODUNIDAD;

	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByCodFeriado_Feriados]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByCodFeriado_Feriados]
	(
	@CODFERIADO int
	)
AS
	SELECT COUNT(*)
	AS CANTIDAD 
	FROM FERIADOFINSEMANAS
	WHERE CODFERIADO = @CODFERIADO

	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_Actividad]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_Actividad]
	
	
	
AS
	SELECT CODACTIVIDAD, DESCRIPCION, DURACION, 
    (SELECT CASE ESTADOACTIVIDAD WHEN '0' THEN 'INACTIVO' WHEN 1 THEN 'ACTIVO' END)AS ESTADOACTIVIDAD
	 FROM ACTIVIDAD 
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Actualiza_ByPassword_Usuario]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Get_Actualiza_ByPassword_Usuario]
(
	@RUTUSUARIO varchar (10),
	@PASSWORD varchar(300),
    @PASSWORDMD5 varchar(300)
)
as

declare @FOLIOSOLICITUD   int,
        @SECUENCIA        int,         
        @CODACTIVIDAD     int,
        @DURACION         int,
        @FECHAVENCACT     datetime,
        @EMAILALUMNO      varchar(max),
        @EMAILRESPONSABLE  varchar(max),
        @AsuntoResponsable VARCHAR(max) = 'Workflow Solicitudes - recuperacion de contraseña',
		@CuerpoResponsable VARCHAR(max),
	    @AsuntoAlumno      VARCHAR(max) = 'Solicitud ',
		@CuerpoAlumno      VARCHAR(max),
		@NombreResponsable VARCHAR(max),
		@FECHAVENCSOL     datetime,
		@DESACTIVIDAD      VARCHAR(max),
		@EMAILUSUARIO VARCHAR(50);
 

UPDATE USUARIO
SET    PASSWORD     = @PASSWORDMD5
WHERE RUTUSUARIO    = @RUTUSUARIO

SELECT @NombreResponsable = (NOMBRE +' ' + APELLIDO), 
       @EMAILUSUARIO      = EMAILUSUARIO
  FROM USUARIO
 WHERE RUTUSUARIO =@RUTUSUARIO; 


SET @CuerpoResponsable = '<html>Estimado Sr(a) ' + @NombreResponsable + ' Su nueva contraseña es ' + @PASSWORD +  ' Para Mayor Información Visite Workflow Solicitudes';  

print @CuerpoResponsable;
 		
 EXEC msdb.dbo.sp_send_dbmail 
	@recipients      = @EMAILUSUARIO,    
	@subject         = @AsuntoResponsable,
    @body            = @CuerpoResponsable,
    @body_format     = 'HTML',
	@profile_name    ='Workflow IP CIISA';
GO
/****** Object:  StoredProcedure [dbo].[sp_get_aprobador_flujoSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_get_aprobador_flujoSolicitud]
(
  @SECUENCIA        INT,
  @CODTIPOSOLICITUD INT, 
  @CODUNIDAD        INT
)
AS
SELECT APROBADOR 
  FROM FLUJOSOLICITUD
WHERE SECUENCIA        = @SECUENCIA 
  AND CODTIPOSOLICITUD = @CODTIPOSOLICITUD 
  AND CODUNIDAD       = @CODUNIDAD;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_Consulta_ByCodtipoSolSecuencia_FlujoSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_Consulta_ByCodtipoSolSecuencia_FlujoSolicitud]
(
  @CODTIPOSOLICITUD int,
  @SECUENCIA        int  
)
AS

SELECT B.DESCRIPCION 
FROM   FLUJOSOLICITUD A, 
       ACTIVIDAD B
WHERE  A.CODTIPOSOLICITUD = @CODTIPOSOLICITUD
  AND  A.SECUENCIA        = @SECUENCIA
    AND  A.CODACTIVIDAD     = B.CODACTIVIDAD;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByCodTipoSolSec_FlujoSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Get_Consulta_ByCodTipoSolSec_FlujoSolicitud]
(
    @CODTIPOSOLICITUD INT,
    @SECUENCIA        INT
)
AS

SELECT     SECUENCIA, 
           CODACTIVIDAD,
           CODUNIDAD, 
           BIFURCACION,
           APROBADOR, 
           SI,
           NO    
    FROM   FLUJOSOLICITUD   
	WHERE  CODTIPOSOLICITUD = @CODTIPOSOLICITUD 
	AND    SECUENCIA        = @SECUENCIA;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByCodtipoSol_flujosolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByCodtipoSol_flujosolicitud]
(

    @CODTIPOSOLICITUD INT
)
	
AS
	SELECT A.SECUENCIA, 
	       UPPER(B.DESCRIPCION) AS DESCRIPCION, 
	       A.CODUNIDAD, 
	       UPPER(C.DESCUNIDAD) AS DESCUNIDAD,
		   (SELECT CASE A.APROBADOR WHEN '0' THEN 'No' WHEN 1 THEN 'Si' END) AS APROBADOR, 
		  (SELECT CASE A.BIFURCACION WHEN '0' THEN 'No' WHEN 1 THEN 'Si' END) AS BIFURCACION,  
	       A.CODTIPOSOLICITUD, 
	       A.CODACTIVIDAD,
	       A.SI,
	       A.NO,
	       dbo.f_GetGlosaActividad(A.SI) AS DESCACTIVIDADSI,
	       dbo.f_GetGlosaActividad(A.NO) AS DESACTIVIDADCNO
	FROM FLUJOSOLICITUD A, 
	     ACTIVIDAD B, 
	     UNIDADES C 
	WHERE A.CODACTIVIDAD     = B.CODACTIVIDAD 
	  AND A.CODUNIDAD        = C.CODUNIDAD
	  AND A.CODTIPOSOLICITUD = @CODTIPOSOLICITUD
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByCodRolCodPrivi_RolesPrivilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Get_Consulta_ByCodRolCodPrivi_RolesPrivilegios]
(
  @CODROL         INT,
  @CODPRIVILEGIOS INT
          
)
 AS
 SELECT  COUNT(*) 
     AS  CANTIDAD
   FROM  ROLESPRIVILEGIOS
   WHERE CODROL         = @CODROL
     AND CODPRIVILEGIOS = @CODPRIVILEGIOS;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_consulta_ByCodrol_RolesPrivilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_consulta_ByCodrol_RolesPrivilegios] 
	-- Add the parameters for the stored procedure here
	(@CODROL int)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT B.CODPRIVILEGIOS, B.NOMPRIVILEGIOS 
		FROM ROLESPRIVILEGIOS A
		INNER JOIN PRIVILEGIOS B ON A.CODPRIVILEGIOS = B.CODPRIVILEGIOS 
		WHERE A.CODROL = @CODROL;
  
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByNombreConsulta_Usuario]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByNombreConsulta_Usuario]
	-- Add the parameters for the stored procedure here
@TEXTOBUSQUEDA varchar (Max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT RUTUSUARIO, CODROL , NOMBRE, APELLIDO, PASSWORD,EMAILUSUARIO FROM USUARIO
WHERE NOMBRE LIKE('%' + @TextoBusqueda + '%') OR APELLIDO LIKE ('%' + @TextoBusqueda + '%')


END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByUsuPass_Usuario]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByUsuPass_Usuario] 
	@RUTUSUARIO varchar (10),
	@PASSWORD varchar(300)
	
AS
BEGIN
	
--DECLARE @MD5 varbinary(MAX)


--SET @MD5= CONVERT(varbinary(max), @PASSWORD, 0)

--SELECT 
--    HASHBYTES('MD5', @MD5), CAST(REVERSE(CAST( HASHBYTES('MD5', @MD5) AS varchar(max)) ) 
--    AS varbinary(max))

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT	CODROL 
   FROM		USUARIO
   WHERE	RUTUSUARIO = @RUTUSUARIO
		AND	PASSWORD = @PASSWORD ;
											; 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByCodUnidad_Usuario]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Get_Consulta_ByCodUnidad_Usuario]
(
 @CODUNIDAD INT
)
as
SELECT  RUTUSUARIO, 
        CODROL, 
        PASSWORD, 
        NOMBRE, 
        APELLIDO, 
        EMAILUSUARIO, 
        ESTADOUSUARIO, 
        CODUNIDAD, 
        DEPENDE
  FROM  USUARIO
  WHERE CODUNIDAD=@CODUNIDAD;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByTipo_Privilegio]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByTipo_Privilegio]
(
 @CODROL int 
)
AS

SELECT COUNT(*) AS CANTIDAD
FROM ROLESPRIVILEGIOS
WHERE CODROL  = @CODROL;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByTipo_FlujoSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Get_Consulta_ByTipo_FlujoSolicitud]
(
   @CODTIPOSOLICITUD INT 
)

AS

SELECT COUNT(*) AS CANTIDAD
FROM   FLUJOSOLICITUD
WHERE  CODTIPOSOLICITUD = @CODTIPOSOLICITUD;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByRutUsuario_Usuario]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByRutUsuario_Usuario]
	(
	@RUTUSUARIO VARCHAR(10)
	)
AS
	SELECT COUNT(*)
	AS CANTIDAD 
	FROM USUARIO
	WHERE RUTUSUARIO = @RUTUSUARIO

	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByRut_Usuario]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByRut_Usuario]
(

    @RUTUSUARIO varchar(50)
)
	
AS
	SELECT RUTUSUARIO, NOMBRE, APELLIDO, EMAILUSUARIO, CODROL , ESTADOUSUARIO, CODUNIDAD 
	FROM USUARIO
	WHERE  RUTUSUARIO =  @RUTUSUARIO
	
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByRol_RolesPrivilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByRol_RolesPrivilegios]
(
 @CODROL INT
)
AS
SELECT  A.CODPRIVILEGIOS, A.CODROL, A.ESTADOROLPRIVI, B.DESCRIPCION, C.DESCPRIVILEGIOS,
        (SELECT CASE ESTADOROLPRIVI WHEN '0' THEN 'INACTIVO' WHEN 1 THEN 'ACTIVO' END) AS ESTADOROLESPRIVILEGIOS 
  FROM  ROLESPRIVILEGIOS A, 
        ROL B, PRIVILEGIOS C
  WHERE A.CODROL         = B.CODROL 
  AND   A.CODPRIVILEGIOS = C.CODPRIVILEGIOS
  AND   A.CODROL=@CODROL;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_FechaPosibleResolucion]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_FechaPosibleResolucion]
(
  @CODTIPOSOLICITUD int 
)
AS

DECLARE @AUXDURACION int;  

SELECT @AUXDURACION = SUM(B.DURACION) 
FROM   FLUJOSOLICITUD A,    ACTIVIDAD B
WHERE  A.CODACTIVIDAD     = B.CODACTIVIDAD
  AND  A.CODTIPOSOLICITUD = @CODTIPOSOLICITUD;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_TipoSolicitud_internas]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Get_Consulta_TipoSolicitud_internas] 
as 
  --SELECT  DISTINCT A.CODTIPOSOLICITUD, A.DESCTIPOSOLICITUD 
  --  FROM  TIPOSOLICITUD A, FLUJOSOLICITUD B 
  --  WHERE A.CODTIPOSOLICITUD =  B.CODTIPOSOLICITUD
  --    AND a.FECHAINICIO < GETDATE()
  --    AND a.FECHAFIN  >   GETDATE()
  --    AND A.ESTADOSOLICITUD = 1
  --    AND A.ORIGEN = 'I'
  --    AND B.APROBADOR =1;
  
  -- Se saca si es aprobador, ya que sebe incorporar la actividad 
  -- de bifurcación
  
   SELECT  DISTINCT A.CODTIPOSOLICITUD, A.DESCTIPOSOLICITUD 
    FROM  TIPOSOLICITUD A, FLUJOSOLICITUD B 
    WHERE A.CODTIPOSOLICITUD =  B.CODTIPOSOLICITUD
      AND a.FECHAINICIO < GETDATE()
      AND a.FECHAFIN  >   GETDATE()
      AND A.ESTADOSOLICITUD = 1
      AND A.ORIGEN = 'I';
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_TipoSolicitud_externas]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Get_Consulta_TipoSolicitud_externas] 
as 
  SELECT  DISTINCT A.CODTIPOSOLICITUD, A.DESCTIPOSOLICITUD 
    FROM  TIPOSOLICITUD A, FLUJOSOLICITUD B 
    WHERE A.CODTIPOSOLICITUD =  B.CODTIPOSOLICITUD
      AND a.FECHAINICIO < GETDATE()
      AND a.FECHAFIN  >   GETDATE()
      AND A.ESTADOSOLICITUD = 1
      AND A.ORIGEN = 'E'
      AND B.APROBADOR =1;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_Usuario_NomApellido]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Get_Consulta_Usuario_NomApellido]
as
   SELECT RUTUSUARIO, (NOMBRE + ' ' + APELLIDO) AS NOMBRES 
   FROM USUARIO;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_Usuario]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_Usuario]

AS

BEGIN
	
SET NOCOUNT ON; 

SELECT	A.RUTUSUARIO, 
				A.CODROL, 
				A.PASSWORD, 
				A.NOMBRE, 
				A.APELLIDO, 
				A.EMAILUSUARIO, 
				(SELECT CASE A.ESTADOUSUARIO WHEN '0' THEN 'INACTIVO' WHEN 1 THEN 'ACTIVO' END) AS ESTADOUSUARIO, 
				A.CODUNIDAD, 
				(SELECT NOMBRE+' '+APELLIDO FROM USUARIO WHERE RUTUSUARIO = A.DEPENDE) AS NOMBREDEPENDE,
				B.DESCRIPCION,
				C.DESCUNIDAD,
				A.TELEFONO,
				A.DEPENDE
  FROM  USUARIO A
  INNER JOIN ROL B ON A.CODROL = B.CODROL
  INNER JOIN UNIDADES C ON A.CODUNIDAD = C.CODUNIDAD 
  
  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_RolesPrivilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_RolesPrivilegios]

AS

BEGIN
	
SET NOCOUNT ON; 

--SELECT  A.CODPRIVILEGIOS, A.CODROL, A.ESTADOROLPRIVI, B.DESCRIPCION, C.DESCPRIVILEGIOS,
--        (SELECT CASE ESTADOROLPRIVI WHEN '0' THEN 'INACTIVO' WHEN 1 THEN 'ACTIVO' END) AS ESTADOROLESPRIVILEGIOS 
--  FROM  ROLESPRIVILEGIOS A, ROL B, PRIVILEGIOS C
--  WHERE A.CODROL = B.CODROL 
--  AND   A.CODPRIVILEGIOS = C.CODPRIVILEGIOS
  SELECT  A.CODPRIVILEGIOS, 
        A.CODROL, 
        A.ESTADOROLPRIVI, 
        B.DESCRIPCION, 
        C.DESCPRIVILEGIOS,
        (SELECT CASE ESTADOROLPRIVI WHEN '0' THEN 'INACTIVO' WHEN 1 THEN 'ACTIVO' END) AS ESTADOROLESPRIVILEGIOS 
  FROM  ROLESPRIVILEGIOS A, 
        ROL B, PRIVILEGIOS C
  WHERE A.CODROL         = B.CODROL 
  AND   A.CODPRIVILEGIOS = C.CODPRIVILEGIOS

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByCodActividad_FlujoSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByCodActividad_FlujoSolicitud]
(
  @CODACTIVIDAD int 
)

AS

SELECT COUNT(*) AS CANTIDAD
FROM   FLUJOSOLICITUD
WHERE  CODACTIVIDAD = @CODACTIVIDAD
GO
/****** Object:  StoredProcedure [dbo].[sp_get_delete_FlujoSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_get_delete_FlujoSolicitud]
(
   @CODTIPOSOLICITUD INT, 
   @SECUENCIA INT 

)

AS
DELETE FROM FLUJOSOLICITUD
WHERE  CODTIPOSOLICITUD = @CODTIPOSOLICITUD
 AND   SECUENCIA        = @SECUENCIA;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_CpnsultaCodActividad_FlujoSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Get_CpnsultaCodActividad_FlujoSolicitud] 
(
 @CODTIPOSOLICITUD INT,
 @SECUENCIA        INT 
)
AS
BEGIN 
      SELECT CODACTIVIDAD 
      FROM   FLUJOSOLICITUD
      WHERE  CODTIPOSOLICITUD = @CODTIPOSOLICITUD
        AND  SECUENCIA        = @SECUENCIA;      
      
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_ConsultaPrivi_ByTipo_Privilegio]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_ConsultaPrivi_ByTipo_Privilegio]
(
 @CODPRIVILEGIOS int 
)
AS

SELECT COUNT(*) AS CANTIDAD
FROM ROLESPRIVILEGIOS
WHERE CODPRIVILEGIOS  = @CODPRIVILEGIOS;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Existe_ByActividad_FlujoSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Get_Existe_ByActividad_FlujoSolicitud]
(
  @CODACTIVIDAD INT
)
AS
    SELECT COUNT(*) 
        AS CANTIDAD
     FROM  FLUJOSOLICITUD
     WHERE CODACTIVIDAD = @CODACTIVIDAD;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_MaxSecuencia_FlujoSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_get_MaxSecuencia_FlujoSolicitud]
(
     @CODTIPOSOLICITUD INT, 
     @SECUENCIA        INT OUTPUT
)
AS

SELECT @SECUENCIA = ISNULL(MAX(secuencia) + 1,1) from FLUJOSOLICITUD
where CODTIPOSOLICITUD = @CODTIPOSOLICITUD;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_ExisteAnula_Solicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_ExisteAnula_Solicitud]
(
  @FOLIOSOLICITUD int
)
AS 
SELECT COUNT(*) 
   AS  CANTIDAD
from   SOLICITUD
where  FOLIOSOLICITUD = @FOLIOSOLICITUD
 and   CODESTADOSOL   = 4;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_ValidaProcesoEjecucion_Solicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Get_ValidaProcesoEjecucion_Solicitud]
(
  @CODTIPOSOLICITUD INT
)

AS 
  BEGIN 
       SELECT COUNT(*) AS CANTIDAD
       FROM SOLICITUD
       WHERE CODTIPOSOLICITUD = @CODTIPOSOLICITUD
         AND CODESTADOSOL     = 1;
  
  END
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_ByRut_Pasword_Usuario]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Actualiza_ByRut_Pasword_Usuario]
	
	(
	
	@RUTUSUARIO varchar(10),
	@PASSWORD varchar(max)	
	)
	
AS
	UPDATE  USUARIO SET PASSWORD = @PASSWORD 
	WHERE RUTUSUARIO  =@RUTUSUARIO
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_cambioEstado_FlujoSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Set_Actualiza_cambioEstado_FlujoSolicitud]
(
  @CODTIPOSOLICITUD int,
  @SECUENCIA		int
)
AS
UPDATE FLUJOSOLICITUD
SET    ESTADO			 = 0	
WHERE  CODTIPOSOLICITUD  = @CODTIPOSOLICITUD
  AND   SECUENCIA        = @SECUENCIA;
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_RolesPrivilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Actualiza_RolesPrivilegios]
	
	(
	@CODPRIVILEGIOS int,
	@CODROL int
	)
	
AS
	UPDATE ROLESPRIVILEGIOS 
	SET CODPRIVILEGIOS = @CODPRIVILEGIOS, 
	    CODROL = @CODROL
	WHERE CODPRIVILEGIOS = @CODPRIVILEGIOS 
	  AND CODROL = @CODROL
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualizar_flujosolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Actualizar_flujosolicitud]
(
	@SECUENCIA        int,
	@CODTIPOSOLICITUD int,
	@CODACTIVIDAD     int, 
	@CODUNIDAD        int,
	@APROBADOR        INT,
	@BIFURCACION      INT,
	@SECUENCIASI      VARCHAR(02),
	@SECUENCIANO      VARCHAR(02)
	)
	
AS
	UPDATE  FLUJOSOLICITUD 
	    SET   CODUNIDAD          = @CODUNIDAD, 
	          APROBADOR          = @APROBADOR,	
	          CODACTIVIDAD       = @CODACTIVIDAD,  
	          BIFURCACION        = @BIFURCACION,
	          SI                 = @SECUENCIASI,
	          NO                 = @SECUENCIANO
	    WHERE CODTIPOSOLICITUD   = @CODTIPOSOLICITUD
	      AND SECUENCIA          = @SECUENCIA;
	      
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Borra_Usuario]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Borra_Usuario]
	
	(
	@RUTUSUARIO varchar(10)
	
	)
	
AS
	DELETE USUARIO WHERE RUTUSUARIO = @RUTUSUARIO
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Inserta_RolesPrivilegios]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Set_Inserta_RolesPrivilegios]
	
	(
	@CODPRIVILEGIOS int,
	@CODROL int,
	@ESTADOROLPRIVI int
	)
	
AS
	INSERT INTO ROLESPRIVILEGIOS (CODPRIVILEGIOS,CODROL,ESTADOROLPRIVI) 	VALUES (@CODPRIVILEGIOS,@CODROL,@ESTADOROLPRIVI)
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_Usuario]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Set_Actualiza_Usuario]
	
	(
	@RUTUSUARIO varchar(10),
	@CODROL int,
	@NOMBRE varchar(50),
	@APELLIDO varchar(50),
	@EMAILUSUARIO varchar(50),
	@ESTADOUSUARIO int,
	@CODUNIDAD int,
	@DEPENDE varchar(10),
	@TELEFONO varchar(10)
	
		
	)
	
AS
	UPDATE USUARIO 
	SET CODROL        = @CODROL,
	    NOMBRE        = @NOMBRE,
	    APELLIDO      = @APELLIDO,
	    EMAILUSUARIO  = @EMAILUSUARIO,
		ESTADOUSUARIO = @ESTADOUSUARIO,
        CODUNIDAD     = @CODUNIDAD,
        DEPENDE       = @DEPENDE,
		TELEFONO      = @TELEFONO
	WHERE RUTUSUARIO = @RUTUSUARIO
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Inserta_flujosolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Inserta_flujosolicitud]
(
     @SECUENCIA        INT, 
     @CODTIPOSOLICITUD INT, 
     @CODACTIVIDAD     INT,
     @CODUNIDAD        INT,
     @APROBADOR        INT,
     @BIFURCACION      INT,
     @SECUENCIASI      VARCHAR(02),
     @SECUENCIANO      VARCHAR(02) )

AS
   INSERT INTO FLUJOSOLICITUD
   (SECUENCIA,
    CODTIPOSOLICITUD,
    CODACTIVIDAD,
    CODUNIDAD,
    APROBADOR,
	BIFURCACION,
	SI,
	NO )
VALUES 
    (@SECUENCIA,
     @CODTIPOSOLICITUD,
     @CODACTIVIDAD,
     @CODUNIDAD,
     @APROBADOR,
     @BIFURCACION,
     @SECUENCIASI,
     @SECUENCIANO)
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_ValidaCantidad_Solicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Set_ValidaCantidad_Solicitud]
(
 @CODTIPOSOLICITUD INT, 
 @CANTIDAD         INT OUT 
 )
 AS
 
 DECLARE @TIENESOLICITUDES  INT;
 DECLARE @CANTIDADSOLICITUD INT;
 DECLARE @CANTIDADTIPOSOLICITUD INT;
  
 BEGIN 
  
   SET @CANTIDAD = 0;
 
   SELECT @CANTIDADTIPOSOLICITUD  = CANTMAXSOLICITUD 
    FROM  TIPOSOLICITUD
   WHERE  CODTIPOSOLICITUD = @CODTIPOSOLICITUD;

   
   SELECT @CANTIDADSOLICITUD   = COUNT(*) 
   FROM   SOLICITUD
   WHERE  CODTIPOSOLICITUD     = @CODTIPOSOLICITUD
     AND  YEAR(FECHASOLICITUD) = YEAR(GETDATE())
     AND  CODESTADOSOL         =  1;
       
 
         IF @CANTIDADTIPOSOLICITUD < = @CANTIDADSOLICITUD
           BEGIN
               --- No puede hacer mas solicitudes
               SET @CANTIDAD = 1
           END
           ELSE
               SET @CANTIDAD = 0
           END
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Recupera_Contraseña]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[sp_Set_Recupera_Contraseña] 
    
  (

   @RUTUSUARIO varchar(10)
)
as


declare @FOLIOSOLICITUD   int,
        @SECUENCIA        int,         
        @CODACTIVIDAD     int,
        @DURACION         int,
        @FECHAVENCACT     datetime,
        @EMAILALUMNO      varchar(max),
        @EMAILRESPONSABLE  varchar(max),
        @AsuntoResponsable VARCHAR(max) = 'Asignación de Nueva Actividad - Workflow Solicitud',
		@CuerpoResponsable VARCHAR(max),
	    @AsuntoAlumno      VARCHAR(max) = 'Solicitud ',
		@CuerpoAlumno      VARCHAR(max),
		@NombreResponsable VARCHAR(max),
		@FECHAVENCSOL     datetime,
		@DESACTIVIDAD      VARCHAR(max),
		@PASSWORD  varchar (max), 
		@EMAILUSUARIO VARCHAR(50);
 
             

begin 
 select  PASSWORD, EMAILUSUARIO from USUARIO
where RUTUSUARIO =@RUTUSUARIO; 

SET @CuerpoResponsable = '<html>Estimado Sr(a) ' + @NombreResponsable + ' a Usted ha recuperado su contraseña ' + @PASSWORD +  ' Para Mayor Información Visite Workflow Solicitudes';  

print @CuerpoResponsable;
 		
 EXEC msdb.dbo.sp_send_dbmail 
	@recipients  = @EMAILUSUARIO,    
	@subject     = @AsuntoResponsable,
    @body        = @CuerpoResponsable,
    @body_format = 'HTML',
	@profile_name    ='Workflow IP CIISA';	
	
	
	

end
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Inserta_Usuario]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Inserta_Usuario]
	
	(
	@RUTUSUARIO varchar(10),
	@CODROL int,
	@PASSWORD varchar(300),
	@NOMBRE varchar(50),
	@APELLIDO varchar(50),
	@EMAILUSUARIO varchar(50),
	@ESTADOUSUARIO int,
    @CODUNIDAD int,
    @DEPENDE   varchar(10),
	@TELEFONO varchar(10) 
	)
	
AS
	INSERT INTO USUARIO 
	     (RUTUSUARIO, 
	          CODROL,
	          NOMBRE, 
	        APELLIDO, 
	    EMAILUSUARIO,
	    ESTADOUSUARIO,
	    CODUNIDAD,
	    DEPENDE,
		TELEFONO) 
	    VALUES 
	    (@RUTUSUARIO, 
	         @CODROL,
	         @NOMBRE, 
	         @APELLIDO,
	         @EMAILUSUARIO,
	         @ESTADOUSUARIO,
	         @CODUNIDAD,
	         @DEPENDE,
			 @TELEFONO)
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Inserta_Solicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery2.sql|7|0|C:\Users\Administrador\AppData\Local\Temp\~vsDC05.sql
CREATE procedure [dbo].[sp_Set_Inserta_Solicitud]
(
   @CODTIPOSOLICITUD    int,
   @CODCLI              varchar(10), 
   @CODCARR             varchar(30),
   @CELULARDECONTACTO   varchar(10),
   @EMAILCONTACTO       varchar(50), 
   @GLOSASOLICITUD      varchar(500),
   @FOLIOSOLICITUD_OUT  int OUTPUT)
as

declare @FOLIOSOLICITUD   int,
        @CODUNIDAD        int,
        @SECUENCIA        int, 
        @RUTUSUARIO       varchar(50),
        @CODACTIVIDAD     int,
        @DURACION         int,
        @FECHAVENCSOL     datetime,
        @EMAILALUMNO      varchar(max),
        @EMAILRESPONSABLE  varchar(max),
        @AsuntoResponsable VARCHAR(max) = 'Asignación de Nueva Actividad - Workflow Solicitud',
		@CuerpoResponsable VARCHAR(max),
	    @AsuntoAlumno      VARCHAR(max) = 'Solicitud ',
		@CuerpoAlumno      VARCHAR(max),
		@NombreResponsable VARCHAR(max),
		@DESACTIVIDAD      VARCHAR(max),
		@AUXDURACION		   int;
 

DECLARE CursorFlujos CURSOR FOR
	SELECT SECUENCIA, CODACTIVIDAD,CODUNIDAD 
	FROM   FLUJOSOLICITUD
	WHERE  CODTIPOSOLICITUD = @CODTIPOSOLICITUD;

BEGIN 
insert into Solicitud (CODTIPOSOLICITUD,
					   CODCLI, 
					   CODCARR, 
					   CELULARDECONTACTO,
					   EMAILCONTACTO,
					   FECHASOLICITUD, 
					   GLOSASOLICITUD, 
					   CODESTADOSOL)
				values (@CODTIPOSOLICITUD,
						@CODCLI, 
						@CODCARR, 
						@CELULARDECONTACTO,
						@EMAILCONTACTO,
						GETDATE(), 
						@GLOSASOLICITUD,
						1)
						
    SELECT @FOLIOSOLICITUD = @@IDENTITY;
    
    OPEN CursorFlujos;
    FETCH NEXT FROM CursorFlujos INTO
    @SECUENCIA, @CODACTIVIDAD,@RUTUSUARIO 
    
    WHILE @@FETCH_STATUS=0
    BEGIN
           SELECT @DURACION     = DURACION,
                  @DESACTIVIDAD = DESCRIPCION  
			FROM   ACTIVIDAD
			WHERE CODACTIVIDAD  = @CODACTIVIDAD;
		
		    SELECT @AUXDURACION	= @AUXDURACION + @DURACION;
		    
		    PRINT @AUXDURACION

			SELECT @FECHAVENCSOL =GETDATE() + @AUXDURACION;



			INSERT INTO DETALLESOLICITUD
			(FOLIOSOLICITUD,
			 SECUENCIA,
			 CODTIPOSOLICITUD,
			 CODACTIVIDAD,
			 CODUNIDAD,
			 FECHAVENCSOL,			 
			 DIASATRASO,
			 CODESTADO) 
			 VALUES 
			 (@FOLIOSOLICITUD,
			   @SECUENCIA,
			   @CODTIPOSOLICITUD,
			   @CODACTIVIDAD,
			   @CODUNIDAD,
			   @FECHAVENCSOL,
			   0,
			   5);
			   
			   FETCH NEXT FROM CursorFlujos INTO @SECUENCIA, @CODACTIVIDAD,@RUTUSUARIO 
		     
			END
            CLOSE CursorFlujos
            DEALLOCATE CursorFlujos
    
    
    SET @FOLIOSOLICITUD_OUT = @FOLIOSOLICITUD;
  		
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Insertar_Solicitudes]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Set_Insertar_Solicitudes] 
(
   @CODTIPOSOLICITUD    int,
   @CODCLI              varchar(10), 
   @CODCARR             varchar(30),
   @CELULARDECONTACTO   varchar(10),
   @EMAILCONTACTO       varchar(50), 
   @GLOSASOLICITUD      varchar(500),
   @ORIGEN              varchar(1),	
   @FOLIOSOLICITUD_OUT  int OUTPUT,
   @FECHAVENCSOL_OUT datetime OUTPUT )

as


declare @FOLIOSOLICITUD   int,
        @SECUENCIA        int, 
        @RUTUSUARIO       varchar(50),
        @CODUNIDAD        int,
        @CODACTIVIDAD     int,
        @DURACION         int,
        @FECHAVENCACT     datetime,
        @EMAILALUMNO      varchar(max),
        @EMAILRESPONSABLE  varchar(max),
        @AsuntoResponsable VARCHAR(max) = 'Asignación de Nueva Actividad - Workflow Solicitud',
		@CuerpoResponsable VARCHAR(max),
	    @AsuntoAlumno      VARCHAR(max) = 'Solicitud ',
		@CuerpoAlumno      VARCHAR(max),
		@NombreResponsable VARCHAR(max),
		@FECHAVENCSOL     datetime,
		@DESACTIVIDAD      VARCHAR(max);
 
             

begin 

SET @FECHAVENCSOL  = dbo.GetFechaVencimientoFlujoSolicitud(GETDATE(),@CODTIPOSOLICITUD)

insert into Solicitud (CODTIPOSOLICITUD,
					   CODCLI, 
					   CODCARR, 
					   CELULARDECONTACTO,
					   EMAILCONTACTO,
					   FECHASOLICITUD, 
					   GLOSASOLICITUD, 
					   CODESTADOSOL,
					   FECHAESTIMADARESOL,
					   ORIGEN)
				values (@CODTIPOSOLICITUD,
						@CODCLI, 
						@CODCARR, 
						@CELULARDECONTACTO,
						@EMAILCONTACTO,
						GETDATE(), 
						@GLOSASOLICITUD,
						1, 
						@FECHAVENCSOL,
						@ORIGEN)
						
    SELECT @FOLIOSOLICITUD = @@IDENTITY				

	SELECT @SECUENCIA    = SECUENCIA,
	       @CODACTIVIDAD = CODACTIVIDAD,
	       @CODUNIDAD    = CODUNIDAD 
	FROM  FLUJOSOLICITUD
	WHERE  CODTIPOSOLICITUD = @CODTIPOSOLICITUD
	AND    SECUENCIA IN (SELECT MIN(SECUENCIA) FROM FLUJOSOLICITUD
						 WHERE CODTIPOSOLICITUD = @CODTIPOSOLICITUD);


    SELECT @DURACION    = DURACION,
		   @DESACTIVIDAD = DESCRIPCION  
    FROM   ACTIVIDAD
    WHERE  CODACTIVIDAD = @CODACTIVIDAD;


	SET @FECHAVENCACT = dbo.GetFechaVencimientoActividad(getdate(),@CODACTIVIDAD)

	INSERT INTO DETALLESOLICITUD
	(FOLIOSOLICITUD,
	 SECUENCIA,
	 CODTIPOSOLICITUD,
	 CODACTIVIDAD,
	 CODUNIDAD,
	 FECHAVENCSOL,
	 FECHARECEP,
	 DIASATRASO,
	 CODESTADO, 
	 ETAPA) 
	 
	 VALUES 
	 (@FOLIOSOLICITUD,
	   @SECUENCIA,
	   @CODTIPOSOLICITUD,
	   @CODACTIVIDAD,
	   @CODUNIDAD,
	   @FECHAVENCACT,
	   GETDATE(), 
	   0,
	   5,
	   1)
 
DECLARE 
@dtmFechaVencimientoSol varchar(10),
@dtmFechaVeciminientoAct varchar(10);

Set @dtmFechaVencimientoSoL = CONVERT(varchar(10),@FECHAVENCSOL ,105)
Set @dtmFechaVeciminientoAct = CONVERT(varchar(10),@FECHAVENCACT , 105)



IF ((SELECT ORIGEN FROM TIPOSOLICITUD WHERE CODTIPOSOLICITUD = @CODTIPOSOLICITUD  ) = 'E')
		SET @CuerpoAlumno = '<html>Estimado Alumno(a) la Solicitud fue realizada existosamente, con número de folio '+ STR(@FOLIOSOLICITUD) + ' su fecha estimada de resolucion es el '+ @dtmFechaVencimientoSol+' para mayor información del estado de Solicitud visite sistema de solicitudes';
		ELSE
		SET @CuerpoAlumno = '<html>Estimado Usuario (a) la Solicitud Interna fue realizada existosamente, con número de folio '+ STR(@FOLIOSOLICITUD) + ' su fecha estimada de resolucion es el '+  @dtmFechaVencimientoSol +' para mayor información del estado de Solicitud visite sistema de solicitudes';

 		
 EXEC msdb.dbo.sp_send_dbmail 
	@recipients  = @EMAILCONTACTO,    
    @subject     = @AsuntoAlumno,
    @body        = @CuerpoAlumno,
    @body_format = 'HTML',
@profile_name    ='Workflow IP CIISA';		
 
 DECLARE email_cursor CURSOR FOR 		
 Select NOMBRE + ' ' + APELLIDO, 
        EMAILUSUARIO  
 from   USUARIO
 WHERE  CODUNIDAD = @CODUNIDAD
 
     OPEN email_cursor
     FETCH NEXT FROM email_cursor 
     INTO @NombreResponsable, @EMAILRESPONSABLE
  
     WHILE @@FETCH_STATUS = 0
     BEGIN
		 SET @CuerpoResponsable = '<html>Estimado Sr(a) ' + UPPER(@NombreResponsable) + ' a Usted se la asignado la actividad de trabajo :' + UPPER(@DESACTIVIDAD) + ' .La cual tiene fecha de vencimiento :'+ @dtmFechaVeciminientoAct + ' .Para Mayor Información Visite Workflow Solicitudes';  
		 print @CuerpoResponsable;
		 EXEC msdb.dbo.sp_send_dbmail 
			@recipients   = @EMAILRESPONSABLE,    
			@subject      = @AsuntoResponsable,
			@body         = @CuerpoResponsable,
			@body_format  = 'HTML',
		    @profile_name ='Workflow IP CIISA';		
		    
		    FETCH NEXT FROM email_cursor 
            INTO @NombreResponsable, @EMAILRESPONSABLE
      END 

CLOSE email_cursor;
DEALLOCATE email_cursor;
	
SET @FOLIOSOLICITUD_OUT = @FOLIOSOLICITUD;
SET @FECHAVENCSOL_OUT = @FECHAVENCSOL;
  		
end;
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Inserta_Errores]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Set_Inserta_Errores]
(
  @RUTUSARIO            VARCHAR(10),
  @NOMBREPROCEDIMIENTO  VARCHAR(100),
  @CODERROR             VARCHAR(100),
  @GLOSAERROR           VARCHAR(MAX),
  @OBSERVACION          VARCHAR(MAX),
  @METODO               VARCHAR(MAX)   
)
AS 
  INSERT INTO ERRORES  
  (RUTUSUARIO,
   NOMBREPROCEDIMIENTO,
   CODERROR,
   GLOSAERROR,
   OBSERVACION,
   FECHA,
   METODO)
   VALUES 
  (@RUTUSARIO,
   @NOMBREPROCEDIMIENTO,
   @CODERROR,
   @GLOSAERROR,
   @OBSERVACION,
   GETDATE(),
   @METODO)
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Inserta_Auditoria]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Set_Inserta_Auditoria]
(
  @RUTUSUARIO   VARCHAR(10),
  @IP            VARCHAR(MAX),
  @MODULO        VARCHAR(MAX),
  @ACCION        VARCHAR(MAX),
  @OBSERVACION   VARCHAR(MAX),
  @DISPOSITIVO   VARCHAR(MAX),
  @NOMBREMAQUINA VARCHAR(MAX),
  @MACADDRESS    VARCHAR(MAX)
)

AS
INSERT INTO AUDITORIA 
           (RUTUSUARIO,
            FECHA,
            IP,
            MODULO,
            ACCION,
            OBSERVACION,
            DISPOSITIVO,
            NOMBREMAQUINA,
            MACADDRESS)
 VALUES 
 (         @RUTUSUARIO,
           GETDATE(), 
           @IP,
           @MODULO,
           @ACCION,
           @OBSERVACION,
           @DISPOSITIVO,
           @NOMBREMAQUINA,
           @MACADDRESS)
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Inserta_Adjunto]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Inserta_Adjunto]
	
	(
	@FOLIOSOLICITUD int,
	@NOMBREARCHIVO varchar(50),
	@ARCHIVOPDF varbinary (MAX),
	@TIPOADJUNTO varchar (1),
	@SECUENCIA int
	)
	
AS
	INSERT INTO ADJUNTOS(FOLIOSOLICITUD, NOMBREARCHIVO, ARCHIVOPDF,TIPOADJUNTO,SECUENCIA) VALUES (@FOLIOSOLICITUD, @NOMBREARCHIVO, @ARCHIVOPDF, @TIPOADJUNTO,@SECUENCIA)
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Envio_Send_Emails_Tasks]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Set_Envio_Send_Emails_Tasks]				


AS
BEGIN	
	SET NOCOUNT ON;
DECLARE @FOLIOSOLICITUD INT;
DECLARE @CODACTIVIDAD INT;
DECLARE @EMAILUSUARIO VARCHAR(max);
DECLARE @NOMBRE VARCHAR(max);
DECLARE @FECHAVENCSOL DATETIME;
DECLARE @DESCRIPCION VARCHAR (max);
 
DECLARE @Asunto VARCHAR(max) = 'Actividad Atrasada Workflow IP CIISA';
DECLARE @Cuerpo VARCHAR(max);
 
DECLARE CursorMails CURSOR FOR
SELECT DET.FOLIOSOLICITUD, DET.CODACTIVIDAD,ACT.DESCRIPCION, US.EMAILUSUARIO, US.NOMBRE, DET.FECHAVENCSOL
FROM USUARIO US
 JOIN DETALLESOLICITUD DET ON (DET.RUTUSUARIO = US.RUTUSUARIO)
 JOIN ACTIVIDAD ACT ON (DET.CODACTIVIDAD = ACT.CODACTIVIDAD)
WHERE DET.FECHAVENCSOL <= convert(datetime,convert(varchar(10),getdate(),102),102)
	AND DET.CODESTADO = 5 OR DET.CODESTADO = 6 

	
OPEN CursorMails;
FETCH NEXT FROM CursorMails INTO 
@FOLIOSOLICITUD,  @CODACTIVIDAD,  @DESCRIPCION, @EMAILUSUARIO , @NOMBRE, @FECHAVENCSOL;


WHILE @@FETCH_STATUS=0
BEGIN
 
SET @Cuerpo = 
--'<html><Estimado(a) ' + @NOMBRE + ' 
	
		
--			<form id="form1" runat="server">
--				<div>

--				</div>
--				 </form>
--<table style="width:100%;">
--    <tr>
--        <td class="style2">
--            Numero Solicitud</td>
--        <td class="style3">
--            '+ @FOLIOSOLICITUD +'folio solicitud</td>
--    </tr>
--    <tr>
--        <td class="style2">
--            Actividad</td>
--        <td class="style3">
--            '+ @DESCRIPCION +'tipo</td>
--    </tr>
--    <tr>
--        <td class="style1">
--            Fecha de Vencimeinto</td>
--        <td>
--            '+ @FECHAVENCSOL +'</td>
      
--    </tr>
--</table></html>'


'<html><Estimado(a) ' + @NOMBRE + ' , la tarea: "'+ @DESCRIPCION +'" ya se encuentra vencida.
Favor revisar en sistema de solicitudes.'



EXEC msdb.dbo.sp_send_dbmail 
	@recipients=@EMAILUSUARIO,    
    @subject = @Asunto,
    @body = @Cuerpo,
    @body_format = 'HTML',
@profile_name='Workflow IP CIISA';
 
FETCH NEXT FROM CursorMails INTO 
@FOLIOSOLICITUD, @CODACTIVIDAD,@DESCRIPCION , @EMAILUSUARIO, @NOMBRE, @FECHAVENCSOL ;

END
 
CLOSE CursorMails;
DEALLOCATE CursorMails;
 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualizar_ByCodestado_Detallesolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Set_Actualizar_ByCodestado_Detallesolicitud]
	-- Add the parameters for the stored procedure here

AS
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 
	
	
	BEGIN TRAN
    -- Insert statements for procedure here
    
	SELECT * FROM DETALLESOLICITUD
	WHERE CODESTADO IN (5,6)
	
	UPDATE DETALLESOLICITUD
	SET CODESTADO = 6, 
		DIASATRASO = dbo.GetDiasLaborales((FECHAVENCSOL+1),GETDATE())
						-(SELECT COUNT(*)DESCRIPCIONFERIADO 
							FROM FERIADOFINSEMANAS
							WHERE DESCRIPCIONFERIADO = 'FERIADO'
							AND FECHAFERIADO BETWEEN FECHAVENCSOL AND  CONVERT(VARCHAR(19),GETDATE(),12 ))
		WHERE CODESTADO IN (5,6)AND DATEDIFF(DAY,FECHAVENCSOL, GETDATE())>0
	
	SELECT * FROM DETALLESOLICITUD

	--ROLLBACK TRAN
	COMMIT TRAN
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_ActualizaByFolioEstaAprobada]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Set_ActualizaByFolioEstaAprobada]
(
  @FOLIOSOLICITUD INT, 
  @SECUENCIA INT 
 )
 AS
  UPDATE DETALLESOLICITUD
     SET ESTAAPROBADO = 1,
         SECUENCIA    = @SECUENCIA
   WHERE FOLIOSOLICITUD = @FOLIOSOLICITUD;
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_ByUnidad_DetalleSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Set_Actualiza_ByUnidad_DetalleSolicitud]
(
  @FOLIOSOLICITUD     int, 
  @SECUENCIA          int,
  @CODTIPOSOLICITUD   int, 
  @CODESTADOSOL       int,
  @GLOSADETALLESOL    varchar(500),
  @CODACTIVIDAD       int,
  @CODUNIDAD          int,
  @SIGUIENTESECUENCIA int
)

AS

declare @SECUENCIANUEVA int, 
        @RUTUSUARIO     varchar(50),
        @RUTALUMNO      varchar(max),
        @AsuntoResponsable VARCHAR(max) = 'Asignación de Nueva Actividad - Workflow Solicitud',
		@CuerpoResponsable VARCHAR(max),
		@AsuntoAlumno      VARCHAR(max) = 'Resolución Solicitud Workflow Solicitud Ciisa',
		@CuerpoAlumno      VARCHAR(max),
		@NombreResponsable VARCHAR(max),
		@EMAILRESPONSABLE  VARCHAR(max),
		@EMAILCONTACTO     VARCHAR(max), 
		@DURACION		   INT,
        @FECHAVENCACT     datetime,
		@FECHAVENCSOL      DATETIME,
		@DESACTIVIDAD      VARCHAR(max),
		@AUXDURACION		int,
		@ETAPA				int;
   
      
    SELECT @DURACION    = DURACION,
		   @DESACTIVIDAD = DESCRIPCION  
    FROM   ACTIVIDAD
    WHERE  CODACTIVIDAD = @CODACTIVIDAD;

      
  SELECT @FECHAVENCSOL =GETDATE() + @DURACION;
  
  SET @SECUENCIANUEVA = @SECUENCIA + 1;
 
     UPDATE DETALLESOLICITUD
        SET FECHARESOLUCION = GETDATE(), 
            GLOSADETALLESOL = @GLOSADETALLESOL,
			CODESTADO       = 8
	 WHERE  FOLIOSOLICITUD  = @FOLIOSOLICITUD
	    AND SECUENCIA       = @SECUENCIA; 
	
	  SELECT @ETAPA = MAX(ETAPA)+1 
	  FROM   DETALLESOLICITUD
	  WHERE  FOLIOSOLICITUD=@FOLIOSOLICITUD;
	
		   INSERT INTO  DETALLESOLICITUD
						(FOLIOSOLICITUD,
						 SECUENCIA,
	 					 CODTIPOSOLICITUD,
						 CODACTIVIDAD,
						 CODUNIDAD,
						 FECHAVENCSOL,
						 FECHARECEP,
						 DIASATRASO,
						 CODESTADO,
						 ETAPA) 
					 VALUES 
						(@FOLIOSOLICITUD,
						 @SIGUIENTESECUENCIA,
						 @CODTIPOSOLICITUD,
						 @CODACTIVIDAD,
						 @CODUNIDAD,
						 @FECHAVENCSOL,
						 GETDATE(),
						 0,
						 5,
						 @ETAPA)


DECLARE 
@dtmFechaVencimientoSol varchar(10),
@dtmFechaVeciminientoAct varchar(10);

SET @FECHAVENCACT = dbo.GetFechaVencimientoActividad(getdate(),@CODACTIVIDAD)

Set @dtmFechaVencimientoSoL = CONVERT(varchar(10),@FECHAVENCSOL ,105)
Set @dtmFechaVeciminientoAct = CONVERT(varchar(10),@FECHAVENCACT , 105)



 DECLARE email_cursor CURSOR FOR 		
 Select NOMBRE + ' ' + APELLIDO, 
        EMAILUSUARIO  
 from   USUARIO
 WHERE  CODUNIDAD = @CODUNIDAD
 
     OPEN email_cursor
     FETCH NEXT FROM email_cursor 
     INTO @NombreResponsable, @EMAILRESPONSABLE
  
     WHILE @@FETCH_STATUS = 0
     BEGIN
		 SET @CuerpoResponsable = '<html>Estimado Sr(a) ' + UPPER(@NombreResponsable) + ' a Usted se la asignado la actividad de trabajo :' + UPPER(@DESACTIVIDAD) + ' .La cual tiene fecha de vencimiento :'+ @dtmFechaVeciminientoAct + ' Para Mayor Información Visite Workflow Solicitudes';  
		 print @CuerpoResponsable;
		 EXEC msdb.dbo.sp_send_dbmail 
			@recipients   = @EMAILRESPONSABLE,    
			@subject      = @AsuntoResponsable,
			@body         = @CuerpoResponsable,
			@body_format  = 'HTML',
		    @profile_name ='Workflow IP CIISA';		
		    
		    FETCH NEXT FROM email_cursor 
            INTO @NombreResponsable, @EMAILRESPONSABLE
      END 

CLOSE email_cursor;
DEALLOCATE email_cursor;
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Actualiza_ByFechaTomaActividad_DetalleSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Set_Actualiza_ByFechaTomaActividad_DetalleSolicitud]
(
  @FOLIOSOLICITUD INT,
  @SECUENCIA      INT,
  @RUTUSUARIO     varchar(10)  
)

as

UPDATE DETALLESOLICITUD
   SET FECHAEJECACTIVIDAD = GETDATE(),
       RUTUSUARIO         = @RUTUSUARIO
WHERE  FOLIOSOLICITUD     = @FOLIOSOLICITUD
  AND  SECUENCIA          = @SECUENCIA;
GO
/****** Object:  StoredProcedure [dbo].[Sp_GetConsultaSolicitudes]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_GetConsultaSolicitudes] as
SELECT A.FOLIOSOLICITUD, 
	   A.CODTIPOSOLICITUD,
       B.DESCTIPOSOLICITUD,
       A.CODCLI,        
       A.CODCARR,
       D.NOMBRE_C,
       A.FECHASOLICITUD, 
       C.DESCESTADO,
       A.GLOSASOLICITUD,
       A.OBSSOLUCION,
	   A.FECHARESOLUCION,	
       A.OPCION 
FROM   SOLICITUD A, 
       TIPOSOLICITUD B, 
       ESTADOS C,
       TestUmasNet.dbo.MT_CARRER  D
WHERE A.CODTIPOSOLICITUD   = B.CODTIPOSOLICITUD
  AND A.CODESTADOSOL       = C.CODESTADO
  AND A.CODCARR            = D.CODCARR
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_ValidaExisteDetSoli_Actividad]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Get_ValidaExisteDetSoli_Actividad]
(
  @CODACTIVIDAD int 
)
AS
BEGIN 
     SELECT COUNT(*) AS EXISTE
     FROM   DETALLESOLICITUD
     WHERE  CODACTIVIDAD = @CODACTIVIDAD;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_tareasPendientesByCodUnidad]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_tareasPendientesByCodUnidad]
(
@CODUNIDAD INT
)
AS
SELECT A.FOLIOSOLICITUD,   
       B.DESCTIPOSOLICITUD,
       C.FECHASOLICITUD,
       A.SECUENCIA,
       D.DESCRIPCION,
       A.FECHAVENCSOL,
       A.FECHARESOLUCION,
       A.DIASATRASO,
       E.DESCESTADO,
       A.ETAPA       
FROM   DETALLESOLICITUD A,
       TIPOSOLICITUD B,
       SOLICITUD C,
       ACTIVIDAD D,
       ESTADOS   E
WHERE  A.CODTIPOSOLICITUD = B.CODTIPOSOLICITUD
  AND  A.CODACTIVIDAD     = D.CODACTIVIDAD
  AND  A.FOLIOSOLICITUD   = C.FOLIOSOLICITUD
  AND  A.CODESTADO        = E.CODESTADO
  AND  A.CODESTADO IN (5,6,7)
  AND  A.CODUNIDAD = @CODUNIDAD;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_tareasPendientes]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_tareasPendientes]
(
  @RUTUSUARIO VARCHAR(10)
)
AS

SELECT A.FOLIOSOLICITUD,   
       B.DESCTIPOSOLICITUD,
       C.FECHASOLICITUD,
       A.SECUENCIA,
       D.DESCRIPCION,
       A.FECHAVENCSOL,
       A.FECHARESOLUCION,
       A.DIASATRASO,
       E.DESCESTADO       
FROM   DETALLESOLICITUD A,
       TIPOSOLICITUD B,
       SOLICITUD C,
       ACTIVIDAD D,
       ESTADOS   E              
WHERE  A.CODTIPOSOLICITUD = B.CODTIPOSOLICITUD
  AND  A.CODACTIVIDAD     = D.CODACTIVIDAD
  AND  A.FOLIOSOLICITUD   = C.FOLIOSOLICITUD
  AND  A.CODESTADO        = E.CODESTADO
  AND  A.CODESTADO IN (5,6,7)
  AND  A.RUTUSUARIO       = @RUTUSUARIO;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Existe_ByFolio_Adjuntos]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Get_Existe_ByFolio_Adjuntos]
(
 @FOLIO int,
 @EXISTE int OUTPUT
)
As 
  Select @EXISTE = COUNT(*) 
  From  ADJUNTOS
  where FOLIOSOLICITUD = @FOLIO;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_EstaTomada_Solicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_get_EstaTomada_Solicitud]
(
 @FOLIOSOLICITUD int 
)
as
Begin 
select Count(*) as CANTIDAD
 from  DETALLESOLICITUD
where FOLIOSOLICITUD = @FOLIOSOLICITUD
  and SECUENCIA       = 1 
  and FECHAEJECACTIVIDAD is null;
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_ConsultaByEstaAprobado_DetalleSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Get_ConsultaByEstaAprobado_DetalleSolicitud]
(
  @FOLIOSOLICITUD INT 
)
AS
SELECT COUNT(*) AS CANTIDAD
FROM   DETALLESOLICITUD
WHERE  FOLIOSOLICITUD = @FOLIOSOLICITUD
   AND ESTAAPROBADO = 1;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_Solicitudes]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Get_Consulta_Solicitudes]
(
 @CODCLI varchar(10)
)
AS
SELECT A.FOLIOSOLICITUD, 
	   A.CODTIPOSOLICITUD,
       B.DESCTIPOSOLICITUD,
       A.CODCLI,        
       A.CODCARR,
       D.NOMBRE_C,
       A.FECHASOLICITUD, 
       C.DESCESTADO,
       A.GLOSASOLICITUD,
       A.OBSSOLUCION,
	   A.FECHARESOLUCION,	
       A.OPCION 
FROM   SOLICITUD A, 
       TIPOSOLICITUD B, 
       ESTADOS C,
       TestUmasNet.dbo.MT_CARRER D
WHERE A.CODTIPOSOLICITUD   = B.CODTIPOSOLICITUD
  AND A.CODESTADOSOL       = C.CODESTADO
  AND A.CODCARR            = D.CODCARR
  AND A.CODCLI             = @CODCLI
  ORDER BY 1 DESC;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_Mt_Carrera]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Get_Consulta_Mt_Carrera]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT  CODCARR, NOMBRE_L 
	FROM TestUmasNet.dbo.MT_CARRER 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByIDArchivo_Adjuntos]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByIDArchivo_Adjuntos]
	(
	 @IDARCHIVO INT
	 
	)
AS
BEGIN
	
	SET NOCOUNT ON;

    
	SELECT IDARCHIVO,FOLIOSOLICITUD, NOMBREARCHIVO, ARCHIVOPDF 
	FROM  ADJUNTOS
    WHERE IDARCHIVO   =  IDARCHIVO;


	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByFoliosolicitud_Detallesolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByFoliosolicitud_Detallesolicitud]
(
  @FOLIOSOLICITUD INT
 )
AS
BEGIN
	SET NOCOUNT ON;
 SELECT A.FOLIOSOLICITUD, 
         A.SECUENCIA, 
         A.CODTIPOSOLICITUD,
         B.DESCRIPCION,
         A.CODACTIVIDAD,
         A.RUTUSUARIO,
         C.NOMBRE, 
         C.APELLIDO,    
         A.FECHAVENCSOL,
         A.CODESTADO,
         A.DIASATRASO,
         D.DESCESTADO,
         A.FECHARESOLUCION,
         A.FECHARECEP,
         A.FECHAEJECACTIVIDAD,
         A.GLOSADETALLESOL,
         A.CODUNIDAD,  
         upper(E.DESCUNIDAD) DESCUNIDAD,
         A.ETAPA       
    FROM DETALLESOLICITUD A
    INNER JOIN   ACTIVIDAD B ON A.CODACTIVIDAD = B.CODACTIVIDAD
    FULL OUTER JOIN USUARIO C ON A.RUTUSUARIO = C.RUTUSUARIO
    INNER JOIN  ESTADOS D ON A.CODESTADO      = D.CODESTADO
    INNER JOIN  UNIDADES E ON A.CODUNIDAD      = E.CODUNIDAD
  WHERE A.FOLIOSOLICITUD = @FOLIOSOLICITUD
  ORDER BY A.ETAPA
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByFolioHistoria_Detallesolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByFolioHistoria_Detallesolicitud]
(
  @FOLIOSOLICITUD INT
 )
AS
BEGIN
	SET NOCOUNT ON;
 SELECT A.FOLIOSOLICITUD, 
         A.SECUENCIA, 
         A.CODTIPOSOLICITUD,
         B.DESCRIPCION,
         A.CODACTIVIDAD,
         A.RUTUSUARIO,
         C.NOMBRE, 
         C.APELLIDO,    
         A.FECHAVENCSOL,
         A.CODESTADO,
         A.DIASATRASO,
         D.DESCESTADO,
         A.FECHARESOLUCION,
         A.FECHARECEP,
         A.FECHAEJECACTIVIDAD,
         A.GLOSADETALLESOL,
         A.CODUNIDAD,  
         upper(E.DESCUNIDAD) DESCUNIDAD,
         A.ETAPA       
    FROM DETALLESOLICITUD A
    INNER JOIN   ACTIVIDAD B ON A.CODACTIVIDAD = B.CODACTIVIDAD
    FULL OUTER JOIN USUARIO C ON A.RUTUSUARIO = C.RUTUSUARIO
    INNER JOIN  ESTADOS D ON A.CODESTADO      = D.CODESTADO
    INNER JOIN  UNIDADES E ON A.CODUNIDAD      = E.CODUNIDAD
  WHERE A.FOLIOSOLICITUD = @FOLIOSOLICITUD
    AND A.CODESTADO = 8
  ORDER BY A.ETAPA
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByFolio_Tipo_Adjuntos_Secuencia]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Get_Consulta_ByFolio_Tipo_Adjuntos_Secuencia] 
(
 
 @FOLIOSOLICITUD INT, 
 @TIPOADJUNTO VARCHAR(1),
 @SECUENCIA	INT
 )
as 
BEGIN
SET NOCOUNT ON;
SELECT  IDARCHIVO, FOLIOSOLICITUD, NOMBREARCHIVO, ARCHIVOPDF,TIPOADJUNTO
FROM  ADJUNTOS
WHERE FOLIOSOLICITUD = @FOLIOSOLICITUD  
  AND TIPOADJUNTO = @TIPOADJUNTO
  AND SECUENCIA = @SECUENCIA
	
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByFolio_Tipo_Adjuntos]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[sp_Get_Consulta_ByFolio_Tipo_Adjuntos] 
(
 
 @FOLIOSOLICITUD INT,
 @TIPOADJUNTO VARCHAR(1)
 )
as 
BEGIN
SET NOCOUNT ON;
SELECT  IDARCHIVO, FOLIOSOLICITUD, NOMBREARCHIVO, ARCHIVOPDF,TIPOADJUNTO
FROM  ADJUNTOS
WHERE FOLIOSOLICITUD = @FOLIOSOLICITUD  
  AND TIPOADJUNTO = @TIPOADJUNTO
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByFolio_Solicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByFolio_Solicitud] 
(
  @FOLIOSOLICITUD int
  
)
AS

SELECT 
		A.FOLIOSOLICITUD, 
		A.CODTIPOSOLICITUD,
		B.DESCTIPOSOLICITUD,
		A.CODCLI,        
		A.CODCARR,
		D.NOMBRE_C,
		A.FECHASOLICITUD, 
		C.DESCESTADO,
		A.GLOSASOLICITUD,
		A.OBSSOLUCION,
		A.FECHARESOLUCION,	
		A.OPCION,
		A.CELULARDECONTACTO,
		A.EMAILCONTACTO,
		A.ORIGEN 
FROM SOLICITUD A
	INNER JOIN TIPOSOLICITUD B ON A.CODTIPOSOLICITUD = B.CODTIPOSOLICITUD
	INNER JOIN ESTADOS C ON A.CODESTADOSOL = C. CODESTADO
	FULL OUTER JOIN  TestUmasNet.dbo.MT_CARRER D ON A.CODCARR = D.CODCARR
	WHERE A.FOLIOSOLICITUD = @FOLIOSOLICITUD;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByFolio_DetalleSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        <Author,,Name>
-- Create date: <Create Date,,>
-- Description:    <Description,,>
-- =============================================
CREATE  PROCEDURE [dbo].[sp_Get_Consulta_ByFolio_DetalleSolicitud]
    -- Add the parameters for the stored procedure here
(@FOLIO int)
AS
BEGIN


    -- Insert statements for procedure here
    SELECT A.FOLIOSOLICITUD, A.SECUENCIA,A.FECHARESOLUCION,B.NOMBRE,B.APELLIDO,A.GLOSADETALLESOL
    FROM    DETALLESOLICITUD A
    FULL OUTER JOIN USUARIO B  ON A.RUTUSUARIO = B.RUTUSUARIO
    WHERE A.FOLIOSOLICITUD = @FOLIO
      AND A.FECHARESOLUCION IS NOT NULL

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByEstado_DetalleSol]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        <Author,,Name>
-- Create date: <Create Date,,>
-- Description:    <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByEstado_DetalleSol]
    -- Add the parameters for the stored procedure here

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

SELECT DISTINCT B.CODESTADO, ( B.DESCESTADO) AS ESTADO  FROM DETALLESOLICITUD A
INNER JOIN ESTADOS B ON A.CODESTADO = B.CODESTADO


END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_ByDispositivo_Auditoria]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Get_Consulta_ByDispositivo_Auditoria]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT DISTINCT DISPOSITIVO FROM AUDITORIA
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Consulta_byCodcli_Mt_Alumno]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_Consulta_byCodcli_Mt_Alumno] 
(  
 @CODCLI              varchar(30)
 ) 

AS 
BEGIN 
SELECT A.CODCLI,
       A.RUT,
       A.JORNADA,
       B.NOMBRE,
       B.PATERNO,
       B.MATERNO,
       C.CODCARR,
       C.NOMBRE_L
FROM TestUmasNet.dbo.MT_ALUMNO A,
     TestUmasNet.dbo.MT_CLIENT B,
    TestUmasNet.dbo.MT_CARRER C
WHERE A.RUT   = B.CODCLI     
  AND A.CODCARPR = C.CODCARR
  AND A.CODCLI  = @CODCLI;
  END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_anula_solicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_anula_solicitud]
(
 @FOLIOSOLICITUD INT 
)
AS
UPDATE SOLICITUD
SET    OBSSOLUCION      = 'ANULADO POR ALUMNO', 
       FECHARESOLUCION  = GETDATE(),
       OPCION           = 'AN',
       CODESTADOSOL     = 4
WHERE  FOLIOSOLICITUD = @FOLIOSOLICITUD;

UPDATE DETALLESOLICITUD
SET CODESTADO = 4,
    FECHARESOLUCION = GETDATE(),
    GLOSADETALLESOL = 'ANULADO POR ALUMNO'    
WHERE FOLIOSOLICITUD = @FOLIOSOLICITUD;
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Actualiza_ByCierraFlujo_DetalleSolicitud]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Get_Actualiza_ByCierraFlujo_DetalleSolicitud]
(
   @FOLIOSOLICITUD   int, 
   @SECUENCIA        int,
   @CODESTADOSOL     int,
   @CODESTADOACT     int,
   @GLOSADETALLESOL  varchar(500)
)
AS

declare @SECUENCIANUEVA int, 
        @RUTUSUARIO     varchar(50),
        @RUTALUMNO      varchar(max),
        @AsuntoResponsable VARCHAR(max) = 'Asignación de Nueva Actividad - Workflow Solicitud',
		@CuerpoResponsable VARCHAR(max),
		@AsuntoAlumno      VARCHAR(max) = 'Resolución Solicitud Workflow Solicitud Ciisa',
		@CuerpoAlumno      VARCHAR(max),
		@NombreResponsable VARCHAR(max),
		@EMAILRESPONSABLE  VARCHAR(max),
		@EMAILCONTACTO     VARCHAR(max), 
		@DURACION		   INT,
		@FECHAVENCSOL      DATETIME,
		@DESACTIVIDAD      VARCHAR(max);


UPDATE SOLICITUD
SET   CODESTADOSOL    = @CODESTADOSOL,				     
      FECHARESOLUCION = GETDATE()
WHERE FOLIOSOLICITUD  = @FOLIOSOLICITUD;


UPDATE DETALLESOLICITUD
   SET FECHARESOLUCION = GETDATE(),
       GLOSADETALLESOL = @GLOSADETALLESOL,
	   CODESTADO       = @CODESTADOACT					   
WHERE  FOLIOSOLICITUD  = @FOLIOSOLICITUD
  AND  SECUENCIA       = @SECUENCIA;
GO
/****** Object:  StoredProcedure [dbo].[sp_actualiza_flujoActividad]    Script Date: 08/11/2015 23:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_actualiza_flujoActividad]
(
  @FOLIOSOLICITUD   int, 
  @SECUENCIA        int,
  @CODTIPOSOLICITUD int, 
  @CODESTADOSOL     int,
  @GLOSADETALLESOL  varchar(500),  
  @APROBADOR        int 
)

AS

declare @SECUENCIANUEVA int, 
        @RUTUSUARIO     varchar(50),
        @CODUNIDAD       int,
        @RUTALUMNO      varchar(max),
        @CODACTIVIDAD   int,
        @AsuntoResponsable VARCHAR(max) = 'Asignación de Nueva Actividad - Workflow Solicitud',
		@CuerpoResponsable VARCHAR(max),
		@AsuntoAlumno      VARCHAR(max) = 'Resolución Solicitud Workflow Solicitud Ciisa',
		@CuerpoAlumno      VARCHAR(max),
		@NombreResponsable VARCHAR(max),
		@EMAILRESPONSABLE  VARCHAR(max),
		@EMAILCONTACTO     VARCHAR(max), 
		@DURACION		   INT,
		@FECHAVENCSOL      DATETIME,
		@DESACTIVIDAD      VARCHAR(max);
        

    
   SET @SECUENCIANUEVA = @SECUENCIA + 1

    SELECT @CODACTIVIDAD    = CODACTIVIDAD,
	       @CODUNIDAD       = CODUNIDAD 
	FROM  FLUJOSOLICITUD
	WHERE  CODTIPOSOLICITUD = @CODTIPOSOLICITUD
	AND    SECUENCIA        = @SECUENCIANUEVA;
	
	--- Aca entra a cerrar la Solicitud por que no 
	--- quedan mas flujos por crear
	--IF @@ROWCOUNT = 0
	IF @APROBADOR = 1  
	BEGIN 		
		IF @CODESTADOSOL = 3
		   BEGIN 
			SELECT @CODACTIVIDAD    = CODACTIVIDAD,
				   @CODUNIDAD       = CODUNIDAD 			   
			 FROM  FLUJOSOLICITUD
			WHERE  CODTIPOSOLICITUD = @CODTIPOSOLICITUD
			AND    SECUENCIA        = @SECUENCIA;
		
				SELECT @DESACTIVIDAD = DESCRIPCION,
					   @DURACION     = DURACION 
				  FROM  ACTIVIDAD
				WHERE  CODACTIVIDAD = @CODACTIVIDAD;
		
				select @EMAILCONTACTO = EMAILCONTACTO 
				FROM   SOLICITUD
				WHERE  FOLIOSOLICITUD  = @FOLIOSOLICITUD
		   
				UPDATE SOLICITUD
				   SET CODESTADOSOL    = @CODESTADOSOL,				       
					   FECHARESOLUCION = GETDATE()
				 WHERE FOLIOSOLICITUD  = @FOLIOSOLICITUD; 
				 
				UPDATE DETALLESOLICITUD
				   SET FECHARESOLUCION = GETDATE(),
					   GLOSADETALLESOL = @GLOSADETALLESOL,
					   CODESTADO       = 8					   
				WHERE  FOLIOSOLICITUD  = @FOLIOSOLICITUD
				  AND  SECUENCIA       = @SECUENCIA 
				  
				UPDATE SOLICITUD
				   SET CODESTADOSOL    = @CODESTADOSOL,				       
					   FECHARESOLUCION = GETDATE()
				 WHERE FOLIOSOLICITUD  = @FOLIOSOLICITUD;  
				 
					 SET @CuerpoAlumno = '<html>Estimado Alumno(a) la Solicitud fue rechazada, con número de folio '+ STR(@FOLIOSOLICITUD) + ' para mayor información del estado de Solicitud visite sistema de solicitudes';
					 		
					 EXEC msdb.dbo.sp_send_dbmail 
						@recipients  = @EMAILCONTACTO,    
						@subject     = @AsuntoAlumno,
						@body        = @CuerpoAlumno,
						@body_format = 'HTML',
					@profile_name    ='Workflow IP CIISA';		
			END
	
			IF @CODESTADOSOL = 2
		        BEGIN 
		
				UPDATE SOLICITUD
				   SET CODESTADOSOL    = @CODESTADOSOL,				       
					   FECHARESOLUCION = GETDATE()
				 WHERE FOLIOSOLICITUD  = @FOLIOSOLICITUD; 
		
		        	UPDATE DETALLESOLICITUD
					   SET FECHARESOLUCION = GETDATE(),
						   GLOSADETALLESOL = @GLOSADETALLESOL,
						   CODESTADO       = 8
					WHERE  FOLIOSOLICITUD  = @FOLIOSOLICITUD
					  AND SECUENCIA        = @SECUENCIA; 
				  
				    SET @FECHAVENCSOL = GETDATE() + @DURACION;
				    SET @SECUENCIANUEVA = @SECUENCIA + 1;
		
		
					SELECT @CODACTIVIDAD    = CODACTIVIDAD,
						   @CODUNIDAD       = CODUNIDAD 			   
					 FROM  FLUJOSOLICITUD
					WHERE  CODTIPOSOLICITUD = @CODTIPOSOLICITUD
					AND    SECUENCIA        = @SECUENCIANUEVA;
				    
				  IF @@ROWCOUNT > 0
					  BEGIN 
					  SELECT @DESACTIVIDAD = DESCRIPCION,
				   			 @DURACION     = DURACION 
						FROM  ACTIVIDAD
					   WHERE  CODACTIVIDAD = @CODACTIVIDAD;
					  
					  
					    --Incorporar logica para mandar correo a la unidad
						--SELECT @NombreResponsable = NOMBRE + ' ' + APELLIDO, 
						--	   @EMAILRESPONSABLE  = EMAILUSUARIO  
						--from   USUARIO
						--WHERE  RUTUSUARIO = @RUTUSUARIO

	         
					   INSERT INTO DETALLESOLICITUD
						(FOLIOSOLICITUD,
						 SECUENCIA,
	 					 CODTIPOSOLICITUD,
						 CODACTIVIDAD,
						 CODUNIDAD,
						 FECHAVENCSOL,
						 FECHARECEP,
						 DIASATRASO,
						 CODESTADO) 
					 VALUES 
						(@FOLIOSOLICITUD,
						 @SECUENCIANUEVA,
						 @CODTIPOSOLICITUD,
						 @CODACTIVIDAD,
						 @CODUNIDAD,
						 @FECHAVENCSOL,
						 GETDATE(),
						 0,
						 5)
					 
					    SET @CuerpoResponsable = '<html>Estimado Sr(a) ' + @NombreResponsable + ' a Usted se la asignado la actividad de trabajo ' + @DESACTIVIDAD + ' Para Mayor Información Visite Workflow Solicitudes';  

					    EXEC msdb.dbo.sp_send_dbmail 
						@recipients    = @EMAILRESPONSABLE,    
						@subject       = @AsuntoResponsable,
						@body          = @CuerpoResponsable,
						@body_format   = 'HTML',
						@profile_name  ='Workflow IP CIISA';
				END
		    END
	END
	ELSE
	 BEGIN 
		SELECT @DESACTIVIDAD = DESCRIPCION,
		       @DURACION     = DURACION 
          FROM  ACTIVIDAD
        WHERE  CODACTIVIDAD = @CODACTIVIDAD;
	
		SET @FECHAVENCSOL = GETDATE() + @DURACION;
	
	      --   Incorporar logica para mandar correo a la unidad
	      --   Select @NombreResponsable = NOMBRE + ' ' + APELLIDO, 
          --           @EMAILRESPONSABLE  = EMAILUSUARIO  
		  --   from   USUARIO
		  --   WHERE  RUTUSUARIO = @RUTUSUARIO
	   
	    UPDATE DETALLESOLICITUD
           SET CODESTADO       = @CODESTADOSOL,
               GLOSADETALLESOL = @GLOSADETALLESOL,
               FECHARESOLUCION = GETDATE()
		 WHERE FOLIOSOLICITUD  = @FOLIOSOLICITUD
		   AND SECUENCIA       = @SECUENCIA; 

		   INSERT INTO DETALLESOLICITUD
			(FOLIOSOLICITUD,
			 SECUENCIA,
	 		 CODTIPOSOLICITUD,
			 CODACTIVIDAD,
			 CODUNIDAD,
			 FECHAVENCSOL,
			 FECHARECEP,
			 DIASATRASO,
			 CODESTADO) 
		 VALUES 
			(@FOLIOSOLICITUD,
			 @SECUENCIANUEVA,
			 @CODTIPOSOLICITUD,
			 @CODACTIVIDAD,
			 @CODUNIDAD,
			 @FECHAVENCSOL,
			 GETDATE(),
			 0,
			 5)

	     SET @CuerpoResponsable = '<html>Estimado Sr(a) ' + @NombreResponsable + ' a Usted se la asignado la actividad de trabajo ' + @DESACTIVIDAD + ' Para Mayor Información Visite Workflow Solicitudes';  

		 EXEC msdb.dbo.sp_send_dbmail 
			@recipients  = @EMAILRESPONSABLE,    
			@subject     = @AsuntoResponsable,
			@body        = @CuerpoResponsable,
			@body_format = 'HTML',
		    @profile_name    ='Workflow IP CIISA';
	
	END;
GO
