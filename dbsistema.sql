-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-08-2021 a las 04:05:42
-- Versión del servidor: 10.4.11-MariaDB-log
-- Versión de PHP: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbsistema`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `condicion` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `articulo`
--

INSERT INTO `articulo` (`idarticulo`, `idcategoria`, `codigo`, `nombre`, `stock`, `descripcion`, `imagen`, `condicion`) VALUES
(6, 7, '00458', 'Ligheter', 25, 'Modelo Lighter de MICRONICS', '1535417422.jpg', 1),
(7, 9, '0040kl', 'Disco Sólido', 57, 'Disco Sólido marca KINGSTONE', '1535417431.jfif', 1),
(8, 9, 'HJL-OP', 'Kingstone DataTravel', 107, 'USB de 16gb', '1535417452.jpg', 1),
(10, 14, 'HGF50026', 'Renta de servicio', 2147483645, 'Mensualidad sobre renta de servicio de internet', '1604960138.jpg', 1),
(11, 15, 'dfgh56', 'Antenas Litebeam M5', 48, 'Equipo de enlaces PP', '1615769136', 1),
(12, 9, 'DSA1T', 'Disco Sólido marca ADATA 1T', 59, 'Disco Sólido marca ADATA de 1 terabyte (1000 Gigabytes)', '1616983574', 1),
(14, 7, 'CK68', 'Corsair K68', 30, 'Teclado mecánico marca Corsair modelo K68 con Cherry Red MX', '1699875234', 1),
(17, 12, 'MS144', 'Monitor marca Samsung', 60, 'Monitor marca Samsung de 144hz Full HD', '1713265718', 1),
(18, 7, 'LG213', 'Teclado gamer marca Logitech modelo G213', 30, 'Teclado Gamer Logitech G213 Prodigy LED RGB, Alámbrico, Negro', '1699911245', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `condicion` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nombre`, `descripcion`, `condicion`) VALUES
(7, 'Teclados', 'Teclados Gamer', 1),
(8, 'CPU\'s', 'CPUs Gamer de alta gamma', 1),
(9, 'Discos', 'Discos Duros y Sólidos', 1),
(12, 'Monitores', 'Monitores 144hz', 1),
(14, 'Renta de servicio', 'Mensualidad sobre renta de servicio de internet', 1),
(15, 'Antenas Telecomunicaciones', 'Equipo de enlaces PP', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ingreso`
--

CREATE TABLE `detalle_ingreso` (
  `iddetalle_ingreso` int(11) NOT NULL,
  `idingreso` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` decimal(11,2) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_ingreso`
--

INSERT INTO `detalle_ingreso` (`iddetalle_ingreso`, `idingreso`, `idarticulo`, `cantidad`, `precio_compra`, `precio_venta`) VALUES
(16, 6, 6, 10, '20.00', '30.00'),
(17, 6, 7, 5, '200.00', '250.00'),
(18, 7, 8, 10, '16.00', '25.00'),
(19, 8, 7, 10, '250.00', '300.00'),
(20, 9, 8, 50, '20.00', '30.00'),
(21, 10, 6, 10, '25.00', '30.00'),
(22, 11, 7, 15, '250.00', '300.00'),
(23, 12, 10, 2147483647, '250.00', '250.00'),
(24, 13, 11, 25, '1000.00', '1500.00');

--
-- Disparadores `detalle_ingreso`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockIngreso` AFTER INSERT ON `detalle_ingreso` FOR EACH ROW BEGIN
UPDATE articulo SET stock=stock + NEW.cantidad
WHERE articulo.idarticulo = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `iddetalle_venta` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`iddetalle_venta`, `idventa`, `idarticulo`, `cantidad`, `precio_venta`, `descuento`) VALUES
(12, 10, 6, 10, '30.00', '5.00'),
(13, 10, 7, 10, '250.00', '10.00'),
(14, 11, 6, 1, '30.00', '0.00'),
(15, 11, 7, 1, '250.00', '0.00'),
(16, 12, 7, 4, '250.00', '0.00'),
(17, 13, 7, 1, '250.00', '10.00'),
(18, 14, 7, 2, '250.00', '10.00'),
(19, 15, 6, 1, '30.00', '10.00'),
(20, 16, 7, 1, '250.00', '5.00'),
(21, 17, 7, 1, '250.00', '5.00'),
(22, 18, 6, 1, '30.00', '0.00'),
(23, 19, 7, 1, '250.00', '2.00'),
(24, 20, 8, 2, '25.00', '0.00'),
(25, 21, 6, 1, '30.00', '5.00'),
(26, 22, 6, 1, '30.00', '0.00'),
(27, 22, 7, 1, '300.00', '0.00'),
(28, 22, 8, 1, '30.00', '0.00'),
(29, 23, 9, 1, '280.00', '0.00'),
(30, 24, 9, 1, '250.00', '0.00'),
(31, 25, 10, 1, '250.00', '0.00'),
(32, 26, 11, 2, '1500.00', '0.00'),
(33, 26, 7, 1, '300.00', '0.00'),
(34, 27, 10, 1, '250.00', '0.00');

--
-- Disparadores `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `tr_udpStockVenta` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
UPDATE articulo SET stock = stock - NEW.cantidad
WHERE articulo.idarticulo = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `idingreso` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_compra` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ingreso`
--

INSERT INTO `ingreso` (`idingreso`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_compra`, `estado`) VALUES
(6, 7, 1, 'Factura', '001', '0001', '2018-08-20 00:00:00', '18.00', '1200.00', 'Aceptado'),
(7, 7, 1, 'Factura', '001', '008', '2018-08-21 00:00:00', '18.00', '160.00', 'Aceptado'),
(8, 7, 1, 'Boleta', '0002', '0004', '2018-08-22 00:00:00', '0.00', '2500.00', 'Aceptado'),
(9, 9, 1, 'Factura', '001', '0005', '2018-08-23 00:00:00', '18.00', '1000.00', 'Aceptado'),
(10, 10, 1, 'Factura', '001', '0006', '2018-08-25 00:00:00', '18.00', '250.00', 'Aceptado'),
(11, 10, 1, 'Factura', '001', '0007', '2018-08-27 00:00:00', '18.00', '3750.00', 'Aceptado'),
(12, 9, 1, 'Boleta', '50', '20', '2020-11-09 00:00:00', '0.00', '999999999.99', 'Aceptado'),
(13, 14, 1, 'Boleta', '100', '10', '2020-11-10 00:00:00', '0.00', '25000.00', 'Aceptado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

CREATE TABLE `permiso` (
  `idpermiso` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`idpermiso`, `nombre`) VALUES
(1, 'Escritorio'),
(2, 'Almacen'),
(3, 'Compras'),
(4, 'Ventas'),
(5, 'Acceso'),
(6, 'Consulta Compras'),
(7, 'Consulta Ventas'),
(8, 'Ubicacion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL,
  `tipo_persona` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `num_documento` varchar(20) DEFAULT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`) VALUES
(7, 'Proveedor', 'INKA-PC S.R.L', 'RUC', '12587845254', 'Av. los pinos 201', '54328730', 'inkapc@hotmail.com'),
(8, 'Cliente', 'Publico General', 'DNI', '30224520', 'Av.jose olaya 215', '54325230', 'public@hotmail.com'),
(9, 'Proveedor', 'TECNO-PC', 'RUC', '20485248751', 'Calle los naranjales 245', '054587852', 'tecno@gmail.com'),
(10, 'Proveedor', 'INFONET', 'RUC', '40485245824', 'Av. quiñones 102', '054789854', 'infonet@hotmail.com'),
(11, 'Cliente', 'pedro', 'DNI', '458521748', 'Simon bolivar 120', '78954263', 'pedro@gmailcom'),
(12, 'Cliente', 'Emanuel Rodriguez', 'DNI', '001', 'Paseo los Nogales #35', '7721199200', 'emanuelapp30@gmail.com'),
(14, 'Proveedor', 'UBIQUITI', 'RUC', '30115425', 'calle los jirasoles 450', '7721199200', 'juan@hotmail.com'),
(15, 'Cliente', 'Ximena Ortega', 'CEDULA', '025416', 'calle los jirasoles 450', '5432523058', 'Xim@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `cargo` varchar(20) DEFAULT NULL,
  `login` varchar(20) NOT NULL,
  `clave` varchar(64) NOT NULL,
  `imagen` varchar(50) NOT NULL,
  `condicion` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `cargo`, `login`, `clave`, `imagen`, `condicion`) VALUES
(1, 'Administrador', 'DNI', '72154871', 'Calle los alpes 210', '547821', 'admin@gmail.com', 'Administrador', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '1535417472.jpg', 1),
(2, 'Norma', 'DNI', '30115425', 'calle los jirasoles 450', '054789521', 'norma@hotmail.com', 'empleado', 'Norma', '36000f64f617a4bdd4992bebb0d68370c16378462d8673ad10a0bc83869a680e', '1535417486.jpg', 1),
(3, 'Dueño', 'DNI', '1664', 'Calle Buena Vista S/N', '7721123456', 'admin@gmail.com', 'Administrador', 'dueño', 'e8bf3ef1f889147143d8560944cc4ab901b73a61f253775138d69b7223c1fe1b', '', 1),
(4, 'cliente1', 'DNI', '21231123', 'sadfsafasf', '56145615156', 'asfdasd@sdasd.com', 'Cliente', 'cliente1', 'caae655b2617405e721d27d433331d27adb871354ce6c9be45acc90866df24f4', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_permiso`
--

CREATE TABLE `usuario_permiso` (
  `idusuario_permiso` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idpermiso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario_permiso`
--

INSERT INTO `usuario_permiso` (`idusuario_permiso`, `idusuario`, `idpermiso`) VALUES
(101, 2, 1),
(102, 2, 4),
(103, 3, 1),
(104, 3, 2),
(105, 3, 3),
(106, 3, 4),
(107, 3, 5),
(108, 3, 6),
(109, 3, 7),
(110, 3, 8),
(111, 1, 1),
(112, 1, 2),
(113, 1, 3),
(114, 1, 4),
(115, 1, 5),
(116, 1, 6),
(117, 1, 7),
(118, 1, 8),
(119, 4, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `idventa` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) DEFAULT NULL,
  `total_venta` decimal(11,2) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`idventa`, `idcliente`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_venta`, `estado`) VALUES
(10, 8, 1, 'Boleta', '001', '0001', '2018-01-08 00:00:00', '0.00', '11800.15', 'Aceptado'),
(11, 8, 1, 'Factura', '001', '0002', '2018-03-05 00:00:00', '18.00', '3800.00', 'Aceptado'),
(12, 8, 1, 'Ticket', '001', '0001', '2018-04-17 00:00:00', '0.00', '1000.00', 'Aceptado'),
(13, 8, 1, 'Factura', '001', '0002', '2018-06-09 00:00:00', '18.00', '240.00', 'Aceptado'),
(14, 8, 1, 'Factura', '20', '30', '2018-07-24 00:00:00', '18.00', '490.00', 'Aceptado'),
(15, 8, 1, 'Factura', '001', '0008', '2018-08-26 00:00:00', '18.00', '20.00', 'Aceptado'),
(16, 8, 1, 'Boleta', '001', '0070', '2018-08-26 00:00:00', '0.00', '245.00', 'Aceptado'),
(17, 8, 1, 'Factura', '002', '0004', '2018-08-26 00:00:00', '18.00', '245.00', 'Aceptado'),
(18, 8, 1, 'Boleta', '001', '0006', '2018-08-26 00:00:00', '0.00', '30.00', 'Aceptado'),
(19, 8, 1, 'Factura', '001', '0009', '2018-08-26 00:00:00', '18.00', '248.00', 'Aceptado'),
(20, 8, 1, 'Factura', '001', '002', '2018-08-26 00:00:00', '18.00', '50.00', 'Aceptado'),
(21, 8, 1, 'Factura', '001', '0004', '2018-08-27 00:00:00', '18.00', '25.00', 'Aceptado'),
(22, 11, 1, 'Ticket', '001', '0004', '2018-08-27 00:00:00', '0.00', '360.00', 'Aceptado'),
(23, 12, 1, 'Ticket', '', '1', '2020-10-02 00:00:00', '0.00', '280.00', 'Aceptado'),
(24, 12, 1, 'Boleta', '58', '57', '2020-11-09 00:00:00', '0.00', '250.00', 'Anulado'),
(25, 11, 1, 'Boleta', '58', '1', '2020-11-09 00:00:00', '0.00', '250.00', 'Anulado'),
(26, 12, 1, 'Ticket', '', '5', '2020-11-10 00:00:00', '0.00', '3300.00', 'Aceptado'),
(27, 8, 1, 'Ticket', '100', '57', '2020-11-13 00:00:00', '0.00', '250.00', 'Aceptado');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`idarticulo`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  ADD KEY `fk_articulo_categoria_idx` (`idcategoria`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indices de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD PRIMARY KEY (`iddetalle_ingreso`),
  ADD KEY `fk_detalle_ingreso_idx` (`idingreso`),
  ADD KEY `fk_detalle_articulo_idx` (`idarticulo`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`iddetalle_venta`),
  ADD KEY `fk_detalle_venta_venta_idx` (`idventa`),
  ADD KEY `fk_detalle_venta_articulo_idx` (`idarticulo`);

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `fk_ingreso_persona_idx` (`idproveedor`),
  ADD KEY `fk_ingreso_usuario_idx` (`idusuario`);

--
-- Indices de la tabla `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`idpermiso`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `login_UNIQUE` (`login`);

--
-- Indices de la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  ADD PRIMARY KEY (`idusuario_permiso`),
  ADD KEY `fk_u_permiso_usuario_idx` (`idusuario`),
  ADD KEY `fk_usuario_permiso_idx` (`idpermiso`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `fk_venta_persona_idx` (`idcliente`),
  ADD KEY `fk_venta_usuario_idx` (`idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulo`
--
ALTER TABLE `articulo`
  MODIFY `idarticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `iddetalle_ingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `iddetalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `idingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `idpermiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  MODIFY `idusuario_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fk_articulo_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD CONSTRAINT `fk_detalle_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_ingreso` FOREIGN KEY (`idingreso`) REFERENCES `ingreso` (`idingreso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ingreso_persona` FOREIGN KEY (`idproveedor`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ingreso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
