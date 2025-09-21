-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-09-2025 a las 22:56:49
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ernaga_consolidated`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `id_emprendimiento` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre`, `descripcion`, `id_emprendimiento`, `parent_id`) VALUES
(1, 'Hardware', 'Componentes y equipos informáticos', 1, NULL),
(2, 'Periféricos', 'Accesorios y dispositivos externos para computadoras', 1, NULL),
(3, 'Servicios Profesionales', 'Asesoría y soporte técnico especializado', 1, NULL),
(4, 'Almacenamiento', NULL, 1, 1),
(5, 'Memorias RAM', NULL, 1, 1),
(6, 'Motherboard', NULL, 1, 1),
(7, 'Placas de Video', NULL, 1, 1),
(8, 'Procesadores', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emprendimiento`
--

CREATE TABLE `emprendimiento` (
  `id_emprendimiento` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `contacto` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `mision` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `emprendimiento`
--

INSERT INTO `emprendimiento` (`id_emprendimiento`, `nombre`, `descripcion`, `contacto`, `direccion`, `mision`) VALUES
(1, 'ERNAGA CONSOLIDATED', 'Excelencia y seguridad en gestión informática.', 'contacto@ernaga.com', 'Thorne 1005', 'Proveer soluciones informáticas integrales y seguras que impulsen el crecimiento y la eficiencia de nuestros clientes, estableciendo relaciones de confianza a largo plazo basadas en la excelencia y el compromiso.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `id_categoria` int(11) DEFAULT NULL,
  `id_emprendimiento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_emprendimiento`) VALUES
(1, 'PC de Oficina Intel i5', 'Equipo optimizado para tareas de ofimática y navegación web.', 250000.00, 10, 1, 1),
(2, 'Monitor LED 24\" Full HD', 'Monitor con panel IPS para colores vibrantes y amplios ángulos de visión.', 85000.00, 15, 2, 1),
(3, 'Kit Teclado y Mouse Inalámbrico', 'Combo de teclado y mouse ergonómico de bajo perfil.', 25000.00, 30, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id_servicio` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `id_emprendimiento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id_servicio`, `nombre`, `descripcion`, `precio`, `id_emprendimiento`) VALUES
(1, 'Soporte Técnico Remoto (Hora)', 'Asistencia técnica inmediata para solucionar problemas de software y configuración.', 15000.00, 1),
(2, 'Backup y Recuperación de Datos', 'Servicio de copia de seguridad y restauración de información crítica.', 30000.00, 1),
(3, 'Consultoría de Seguridad Informática', 'Análisis de vulnerabilidades y recomendaciones para proteger su infraestructura.', 50000.00, 1);

--
--
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`),
  ADD KEY `id_emprendimiento` (`id_emprendimiento`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indices de la tabla `emprendimiento`
--
ALTER TABLE `emprendimiento`
  ADD PRIMARY KEY (`id_emprendimiento`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_emprendimiento` (`id_emprendimiento`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id_servicio`),
  ADD KEY `id_emprendimiento` (`id_emprendimiento`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `emprendimiento`
--
ALTER TABLE `emprendimiento`
  MODIFY `id_emprendimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 
--

--
-- Filtros para la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD CONSTRAINT `categorias_ibfk_1` FOREIGN KEY (`id_emprendimiento`) REFERENCES `emprendimiento` (`id_emprendimiento`) ON DELETE CASCADE,
  ADD CONSTRAINT `categorias_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `categorias` (`id_categoria`) ON DELETE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE SET NULL,
  ADD CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`id_emprendimiento`) REFERENCES `emprendimiento` (`id_emprendimiento`) ON DELETE CASCADE;

--
-- Filtros para la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD CONSTRAINT `servicios_ibfk_1` FOREIGN KEY (`id_emprendimiento`) REFERENCES `emprendimiento` (`id_emprendimiento`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
