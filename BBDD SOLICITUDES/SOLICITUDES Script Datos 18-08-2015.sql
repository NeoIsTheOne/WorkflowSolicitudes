USE [SOLICITUDES]
GO
/****** Object:  Table [dbo].[FERIADOFINSEMANAS]    Script Date: 08/18/2015 23:16:52 ******/
SET IDENTITY_INSERT [dbo].[FERIADOFINSEMANAS] ON
INSERT [dbo].[FERIADOFINSEMANAS] ([CODFERIADO], [DESCRIPCIONFERIADO], [FECHAFERIADO]) VALUES (1, N'Dia del trabajador', CAST(0x0000A48B00000000 AS DateTime))
INSERT [dbo].[FERIADOFINSEMANAS] ([CODFERIADO], [DESCRIPCIONFERIADO], [FECHAFERIADO]) VALUES (2, N'Fiestas Patrias', CAST(0x0000A51700000000 AS DateTime))
INSERT [dbo].[FERIADOFINSEMANAS] ([CODFERIADO], [DESCRIPCIONFERIADO], [FECHAFERIADO]) VALUES (3, N'Dia de la independencia de EEUU', CAST(0x0000A47600000000 AS DateTime))
INSERT [dbo].[FERIADOFINSEMANAS] ([CODFERIADO], [DESCRIPCIONFERIADO], [FECHAFERIADO]) VALUES (4, N'Dia de la madre', CAST(0x0000A49400000000 AS DateTime))
INSERT [dbo].[FERIADOFINSEMANAS] ([CODFERIADO], [DESCRIPCIONFERIADO], [FECHAFERIADO]) VALUES (5, N'Convate naval de Iquique', CAST(0x0000A49F00000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[FERIADOFINSEMANAS] OFF
/****** Object:  Table [dbo].[ESTADOS]    Script Date: 08/18/2015 23:16:52 ******/
INSERT [dbo].[ESTADOS] ([CODESTADO], [DESCESTADO]) VALUES (1, N'EN CURSO')
INSERT [dbo].[ESTADOS] ([CODESTADO], [DESCESTADO]) VALUES (2, N'APROBADA')
INSERT [dbo].[ESTADOS] ([CODESTADO], [DESCESTADO]) VALUES (3, N'RECHAZADA')
INSERT [dbo].[ESTADOS] ([CODESTADO], [DESCESTADO]) VALUES (4, N'ANULADA')
INSERT [dbo].[ESTADOS] ([CODESTADO], [DESCESTADO]) VALUES (5, N'EN EJECUCION')
INSERT [dbo].[ESTADOS] ([CODESTADO], [DESCESTADO]) VALUES (6, N'ATRASADA')
INSERT [dbo].[ESTADOS] ([CODESTADO], [DESCESTADO]) VALUES (7, N'FINALIZADA')
INSERT [dbo].[ESTADOS] ([CODESTADO], [DESCESTADO]) VALUES (8, N'COMPLETADA')
INSERT [dbo].[ESTADOS] ([CODESTADO], [DESCESTADO]) VALUES (9, N'EN ESPERA')
/****** Object:  Table [dbo].[ROL]    Script Date: 08/18/2015 23:16:52 ******/
SET IDENTITY_INSERT [dbo].[ROL] ON
INSERT [dbo].[ROL] ([CODROL], [DESCRIPCION], [ESTADOROL]) VALUES (1, N'ADMINISTRADOR', 1)
INSERT [dbo].[ROL] ([CODROL], [DESCRIPCION], [ESTADOROL]) VALUES (2, N'RESOLUTOR', 1)
INSERT [dbo].[ROL] ([CODROL], [DESCRIPCION], [ESTADOROL]) VALUES (9, N'GESTOR', 0)
INSERT [dbo].[ROL] ([CODROL], [DESCRIPCION], [ESTADOROL]) VALUES (10, N'OTRO', 0)
SET IDENTITY_INSERT [dbo].[ROL] OFF
/****** Object:  Table [dbo].[PRIVILEGIOS]    Script Date: 08/18/2015 23:16:52 ******/
SET IDENTITY_INSERT [dbo].[PRIVILEGIOS] ON
INSERT [dbo].[PRIVILEGIOS] ([CODPRIVILEGIOS], [DESCPRIVILEGIOS], [NOMPRIVILEGIOS], [ESTADOPRIVILEGIOS]) VALUES (1, N'Mantenedor de Actividades', N'MantActividades.aspx', 1)
INSERT [dbo].[PRIVILEGIOS] ([CODPRIVILEGIOS], [DESCPRIVILEGIOS], [NOMPRIVILEGIOS], [ESTADOPRIVILEGIOS]) VALUES (2, N'Mantenedor de Flujo Solicitudes', N'MantFlujoSolicitudes.aspx', 1)
INSERT [dbo].[PRIVILEGIOS] ([CODPRIVILEGIOS], [DESCPRIVILEGIOS], [NOMPRIVILEGIOS], [ESTADOPRIVILEGIOS]) VALUES (3, N'Mantenedor de Tipo Solicitudes', N'MantTipoSolicitudes.aspx', 1)
INSERT [dbo].[PRIVILEGIOS] ([CODPRIVILEGIOS], [DESCPRIVILEGIOS], [NOMPRIVILEGIOS], [ESTADOPRIVILEGIOS]) VALUES (4, N'Consulta Solicitudes', N'ConsultaSolicitudes.aspx', 1)
INSERT [dbo].[PRIVILEGIOS] ([CODPRIVILEGIOS], [DESCPRIVILEGIOS], [NOMPRIVILEGIOS], [ESTADOPRIVILEGIOS]) VALUES (5, N'Mantenedor de  Rol', N'MantRol.aspx', 1)
INSERT [dbo].[PRIVILEGIOS] ([CODPRIVILEGIOS], [DESCPRIVILEGIOS], [NOMPRIVILEGIOS], [ESTADOPRIVILEGIOS]) VALUES (6, N'Mantenedor de Privilegios', N'MantPrivilegios.aspx', 1)
INSERT [dbo].[PRIVILEGIOS] ([CODPRIVILEGIOS], [DESCPRIVILEGIOS], [NOMPRIVILEGIOS], [ESTADOPRIVILEGIOS]) VALUES (8, N'Mantenedor de Rol Privilegios', N'MantRolesPrivilegios.aspx', 1)
INSERT [dbo].[PRIVILEGIOS] ([CODPRIVILEGIOS], [DESCPRIVILEGIOS], [NOMPRIVILEGIOS], [ESTADOPRIVILEGIOS]) VALUES (16, N'Mantenedor de Usuarios', N'MantUsuarios.aspx', 1)
INSERT [dbo].[PRIVILEGIOS] ([CODPRIVILEGIOS], [DESCPRIVILEGIOS], [NOMPRIVILEGIOS], [ESTADOPRIVILEGIOS]) VALUES (17, N'Mantenedor de Feriados', N'MantFeriados.aspx', 1)
INSERT [dbo].[PRIVILEGIOS] ([CODPRIVILEGIOS], [DESCPRIVILEGIOS], [NOMPRIVILEGIOS], [ESTADOPRIVILEGIOS]) VALUES (18, N'Mantenedor de Unidades', N'MantUnidades.aspx', 1)
INSERT [dbo].[PRIVILEGIOS] ([CODPRIVILEGIOS], [DESCPRIVILEGIOS], [NOMPRIVILEGIOS], [ESTADOPRIVILEGIOS]) VALUES (19, N'Resuelve Actividad', N'resuelve.aspx', 1)
SET IDENTITY_INSERT [dbo].[PRIVILEGIOS] OFF
/****** Object:  Table [dbo].[UNIDADES]    Script Date: 08/18/2015 23:16:52 ******/
SET IDENTITY_INSERT [dbo].[UNIDADES] ON
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (1, N'Consejo Superior', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (2, N'Rectoría', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (3, N'Vicerrectoría Academica', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (4, N'Dirección de Calidad', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (5, N'Dirección de Admisión, Extensión y Comunicaciones', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (6, N'Dirección de Asuntos Estudiantiles', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (7, N'Dirección de Administracion y Finanzas', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (8, N'Dirección de TI', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (9, N'Comercial de Capacitación', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (10, N'Asistencia de Admisión y Difución', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (11, N'Coordinación de Admisión  y Comunicaciones', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (12, N'Asistencia de Admisión', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (13, N'Biblioteca', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (14, N'Registro Curricular', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (15, N'Dirección de Área Conectividad y Redes', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (16, N'Dirección de Área Informática', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (17, N'Direccion de Área Industrial', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (18, N'Asistencia de Contabilidad', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (19, N'Recaludación y Cobranzas', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (20, N'Sistemas', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (21, N'Laboratorios', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (22, N'Secretariado Académico de Campus', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (23, N'Coordinación de Ingles', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (24, N'Coordinación de TI', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (25, N'Coordinación de Matematicas', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (26, N'Coordinación de Área Conectividad y Redes', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (27, N'Coordinación de Circulo de Egresados ', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (28, N'Docencia', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (29, N'Pañoleros Área Industrial', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (30, N'Mayordomía Campus', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (31, N'Guardias Camupus', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (32, N'Auxiliares de Serviciio', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (33, N'Soporte de Laboratorios', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (34, N'Comite de Calidad', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (35, N'Comite de Gestión', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (36, N'Consejo de Titulación', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (37, N'UTP', 1)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (38, N'aaaaa', 1)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (39, N'EEEEE', 1)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (40, N'ABC', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (41, N'BGB', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (42, N'DSDS', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (43, N'Prueba', 1)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (44, N'prob', 1)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (45, N'una nueva', 0)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (46, N'otra mas', 1)
INSERT [dbo].[UNIDADES] ([CODUNIDAD], [DESCUNIDAD], [ESTADOUNIDAD]) VALUES (47, N'Director de Área', 0)
SET IDENTITY_INSERT [dbo].[UNIDADES] OFF
/****** Object:  Table [dbo].[TIPOSOLICITUD]    Script Date: 08/18/2015 23:16:52 ******/
SET IDENTITY_INSERT [dbo].[TIPOSOLICITUD] ON
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (1, N'CAMBIO DE SECCION', 0, CAST(0x0000A43200000000 AS DateTime), CAST(0x0000A4D200000000 AS DateTime), 4, N'I', 2)
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (2, N'DEVOLUCIÓN DE PAGARÉ', 1, CAST(0x0000A4EF00000000 AS DateTime), CAST(0x0000A52300000000 AS DateTime), 3, N'E', 3)
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (3, N'CAMBIO DE JORNADA VESPERTINO A DIURNO', 0, CAST(0x0000A43200000000 AS DateTime), CAST(0x0000A4C700000000 AS DateTime), 4, N'E', 1)
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (4, N'CAMBIO DE JORNADA DIURNO A VESPERTINO', 1, CAST(0x0000A43300000000 AS DateTime), CAST(0x0000A46C00000000 AS DateTime), 3, N'E', 1)
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (5, N'SUSPENSION ACADEMICA', 1, CAST(0x0000A43200000000 AS DateTime), CAST(0x0000A52300000000 AS DateTime), 99, N'E', 1)
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (6, N'AGREGAR ASIGNATURA EN CARGA ACADEMICA', 1, CAST(0x0000A43300000000 AS DateTime), CAST(0x0000A46C00000000 AS DateTime), 5, N'E', 1)
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (7, N'ELIMINAR ASIGNATURAS', 1, CAST(0x0000A43200000000 AS DateTime), CAST(0x0000A46B00000000 AS DateTime), 3, N'E', 1)
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (8, N'REINCORPORACION', 1, CAST(0x0000A41300000000 AS DateTime), CAST(0x0000A46C00000000 AS DateTime), 3, N'E', 1)
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (9, N'OTROS (Detallar en Obs tipo solicitud)', 1, CAST(0x0000A41400000000 AS DateTime), CAST(0x0000A48A00000000 AS DateTime), 2, N'E', 1)
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (11, N'SOLICITUD DE MATERIALES', 1, CAST(0x0000A49200000000 AS DateTime), CAST(0x0000A62200000000 AS DateTime), 99, N'I', 1)
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (12, N'SOLICITUD DE VACACIONES', 0, CAST(0x0000A49400000000 AS DateTime), CAST(0x0000A63500000000 AS DateTime), 20, N'I', 15)
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (15, N'CERTIFICADOS', 1, CAST(0x0000A49F00000000 AS DateTime), CAST(0x0000A4A900000000 AS DateTime), 3, N'E', 4)
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (16, N'INSCRIPCION DE RAMOS', 1, CAST(0x0000A49E00000000 AS DateTime), CAST(0x0000A4BA00000000 AS DateTime), 5, N'E', 6)
INSERT [dbo].[TIPOSOLICITUD] ([CODTIPOSOLICITUD], [DESCTIPOSOLICITUD], [ESTADOSOLICITUD], [FECHAINICIO], [FECHAFIN], [CANTMAXSOLICITUD], [ORIGEN], [CANTMAXDOC]) VALUES (17, N'CAMBIO DE CARRERA', 1, CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A52A00000000 AS DateTime), 5, N'E', 3)
SET IDENTITY_INSERT [dbo].[TIPOSOLICITUD] OFF
/****** Object:  Table [dbo].[ACTIVIDAD]    Script Date: 08/18/2015 23:16:52 ******/
SET IDENTITY_INSERT [dbo].[ACTIVIDAD] ON
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (1, N'¿Tiene avance academico?', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (2, N'¿Se coordinó entrevista?', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (3, N'¿La entrevista fue efectuada?', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (4, N'¿Es un motivo de fuerza mayor?', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (5, N'¿El alumno está seguro de continuar con la suspens', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (6, N'Cambiar estado académico a estudiante suspendido', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (7, N'¿Falta Información?', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (8, N'¿Cumple requisito?', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (9, N'Preparar informe de ficha de caso', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (10, N'Anular arancel', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (11, N'¿Desea continuar?', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (12, N'¿Acepta el cambio de carrera ?', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (13, N'Generar nuevo contrato', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (14, N'Anular pagaré carrera origen y rebaja cuota', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (15, N'¿Estudiante tiene todo cancelado en el sistema U+?', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (16, N'Autoriza Devolución de Pagaré', 1, 1)
INSERT [dbo].[ACTIVIDAD] ([CODACTIVIDAD], [DESCRIPCION], [DURACION], [ESTADOACTIVIDAD]) VALUES (17, N'me creo uno nuevo ', 123123, 0)
SET IDENTITY_INSERT [dbo].[ACTIVIDAD] OFF
/****** Object:  Table [dbo].[USUARIO]    Script Date: 08/18/2015 23:16:52 ******/
INSERT [dbo].[USUARIO] ([RUTUSUARIO], [CODROL], [CODUNIDAD], [ESTADOUSUARIO], [PASSWORD], [NOMBRE], [APELLIDO], [TELEFONO], [EMAILUSUARIO], [DEPENDE], [FOTO], [FOTOXL]) VALUES (N'13259953-K', 1, 7, 1, N'bdf23f9139433ca661970c88b407f1ca', N'patricio', N'Caro Arias', N'1111111', N'pcaro29@gmail.com', N'13259953-K', NULL, NULL)
INSERT [dbo].[USUARIO] ([RUTUSUARIO], [CODROL], [CODUNIDAD], [ESTADOUSUARIO], [PASSWORD], [NOMBRE], [APELLIDO], [TELEFONO], [EMAILUSUARIO], [DEPENDE], [FOTO], [FOTOXL]) VALUES (N'13462700-k', 2, 4, 0, N'fd3b27ae825d6fdb3d7ea10b51ba7482', N'CARLOS', N'ESPINOSA', N'88888888', N'CESPIN45@GMAIL.COM', N'2-7', NULL, NULL)
INSERT [dbo].[USUARIO] ([RUTUSUARIO], [CODROL], [CODUNIDAD], [ESTADOUSUARIO], [PASSWORD], [NOMBRE], [APELLIDO], [TELEFONO], [EMAILUSUARIO], [DEPENDE], [FOTO], [FOTOXL]) VALUES (N'1-9', 1, 47, 1, N'fd04388f764dacab1c68e63a542fb4b8', N'CARLOS', N'ESPINOSA', N'123', N'pcaro29@gmail.com', N'2-7', NULL, NULL)
INSERT [dbo].[USUARIO] ([RUTUSUARIO], [CODROL], [CODUNIDAD], [ESTADOUSUARIO], [PASSWORD], [NOMBRE], [APELLIDO], [TELEFONO], [EMAILUSUARIO], [DEPENDE], [FOTO], [FOTOXL]) VALUES (N'19929923-9', 9, 4, 1, N'fd04388f764dacab1c68e63a542fb4b8', N'CARLOS', N'ESPINOSA', N'8888777', N'CESPIN45@GMAIL.COM', N'19929923-9', NULL, NULL)
INSERT [dbo].[USUARIO] ([RUTUSUARIO], [CODROL], [CODUNIDAD], [ESTADOUSUARIO], [PASSWORD], [NOMBRE], [APELLIDO], [TELEFONO], [EMAILUSUARIO], [DEPENDE], [FOTO], [FOTOXL]) VALUES (N'2-7', 1, 6, 1, N'fd04388f764dacab1c68e63a542fb4b8', N'EDUARDO', N'FUENTES', N'33333333', N'pcaro29@gmail.com', N'2-7', NULL, NULL)
INSERT [dbo].[USUARIO] ([RUTUSUARIO], [CODROL], [CODUNIDAD], [ESTADOUSUARIO], [PASSWORD], [NOMBRE], [APELLIDO], [TELEFONO], [EMAILUSUARIO], [DEPENDE], [FOTO], [FOTOXL]) VALUES (N'3-5', 1, 14, 1, N'fd04388f764dacab1c68e63a542fb4b8', N'PATRICIO CARO', N'ARIAS', N'44444444', N'pcaro29@gmail.com', N'2-7', NULL, NULL)
INSERT [dbo].[USUARIO] ([RUTUSUARIO], [CODROL], [CODUNIDAD], [ESTADOUSUARIO], [PASSWORD], [NOMBRE], [APELLIDO], [TELEFONO], [EMAILUSUARIO], [DEPENDE], [FOTO], [FOTOXL]) VALUES (N'6444800-5', 2, 1, 1, N'fd3b27ae825d6fdb3d7ea10b51ba7482', N'Gonzalo', N'Caroca', N'8787878877', N'agarrido@ciisa.cl', N'19929923-9', NULL, NULL)
/****** Object:  Table [dbo].[SOLICITUD]    Script Date: 08/18/2015 23:16:52 ******/
/****** Object:  Table [dbo].[ROLESPRIVILEGIOS]    Script Date: 08/18/2015 23:16:52 ******/
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (2, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (3, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (4, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (2, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (3, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (4, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (5, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (6, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (8, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (5, 2, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 1, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 1, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 1, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (16, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (17, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (4, 9, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (18, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (18, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (6, 2, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (6, 9, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 1, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 1, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 9, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (8, 9, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 1, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 1, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 1, 1)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 1, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (5, 2, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (5, 2, 0)
INSERT [dbo].[ROLESPRIVILEGIOS] ([CODPRIVILEGIOS], [CODROL], [ESTADOROLPRIVI]) VALUES (1, 10, 0)
/****** Object:  Table [dbo].[FLUJOSOLICITUD]    Script Date: 08/18/2015 23:16:52 ******/
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (1, 2, 15, 19, 1, NULL, N'2', N'0', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (1, 5, 1, 47, 0, NULL, N'2', N'0', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (1, 17, 12, 47, 1, NULL, N'2', N'0', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (2, 2, 13, 5, 0, NULL, N'3', N'', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (2, 5, 2, 47, 0, NULL, N'3', N'', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (2, 17, 13, 5, 0, NULL, N'3', N'', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (3, 2, 14, 19, 0, 0, N'0', N'0', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (3, 5, 3, 47, 0, NULL, N'4', N'0', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (3, 17, 14, 19, 0, NULL, N'0', N'0', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (4, 5, 4, 47, 0, NULL, N'7', N'5', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (5, 5, 5, 6, 0, NULL, N'6', N'0', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (6, 5, 6, 14, 1, NULL, N'0 ', N'0', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (7, 5, 7, 6, 0, NULL, N'8', N'10', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (8, 5, 2, 6, 0, NULL, N'9', N'0', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (9, 5, 3, 6, 0, NULL, N'10', N'0', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (10, 5, 8, 6, 0, NULL, N'11', N'5', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (11, 5, 9, 6, 0, NULL, N'12', N'', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (12, 5, 8, 7, 1, NULL, N'13', N'14', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (13, 5, 10, 7, 0, NULL, N'6', N'', 0)
INSERT [dbo].[FLUJOSOLICITUD] ([SECUENCIA], [CODTIPOSOLICITUD], [CODACTIVIDAD], [CODUNIDAD], [APROBADOR], [ESTADO], [SI], [NO], [BIFURCACION]) VALUES (14, 5, 11, 7, 0, NULL, N'6', N'0', 0)
/****** Object:  Table [dbo].[ERRORES]    Script Date: 08/18/2015 23:16:52 ******/
/****** Object:  Table [dbo].[DETALLESOLICITUD]    Script Date: 08/18/2015 23:16:52 ******/
/****** Object:  Table [dbo].[AUDITORIA]    Script Date: 08/18/2015 23:16:52 ******/
/****** Object:  Table [dbo].[ADJUNTOS]    Script Date: 08/18/2015 23:16:52 ******/
