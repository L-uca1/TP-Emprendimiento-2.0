// 1. IMPORTS
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

// 2. INICIALIZACIÓN Y MIDDLEWARE
const app = express();
app.use(cors()); // Permite que el frontend se comunique con el backend
app.use(express.json()); // Permite al servidor entender datos en formato JSON

// 3. CONFIGURACIÓN DE LA CONEXIÓN A LA BASE DE DATOS
const db = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: '', 
    database: 'ernaga_consolidated' 
});

// 4. ESTABLECER LA CONEXIÓN
db.connect(err => {
    if (err) {
        console.error('Error al conectar a la base de datos MySQL:', err);
        return;
    }
    console.log('Conectado exitosamente a la base de datos MySQL.');
});

// 5. RUTA DE PRUEBA
app.get('/', (req, res) => {
    res.send('¡El servidor de ERNAGA CONSOLIDATED está funcionando!');
});

// Endpoint para obtener los datos del emprendimiento
app.get('/api/emprendimiento', (req, res) => {
    const sql = 'SELECT * FROM emprendimiento LIMIT 1'; 
    db.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al consultar la tabla emprendimiento:', err);
            return res.status(500).json({ error: 'Error interno del servidor' });
        }
        if (resultados.length > 0) {
            res.json(resultados[0]); // 
        } else {
            res.status(404).json({ message: 'No se encontraron datos del emprendimiento.' });
        }
    });
});

// Endpoint para obtener todas las categorías de forma ANIDADA
app.get('/api/categorias', (req, res) => {
    const sql = 'SELECT * FROM categorias ORDER BY nombre';
    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error al consultar la tabla categorias:', err);
            return res.status(500).json({ error: 'Error interno del servidor' });
        }
        
        // Lógica para anidar las categorías
        const categoriasAnidadas = [];
        const categoriasMap = {}; // para acceso rápido por ID

        // Primero preparamos cada categoría en un mapa
        results.forEach(categoria => {
            categoriasMap[categoria.id_categoria] = { ...categoria, subcategorias: [] };
        });

        // Segundo construimos el árbol
        results.forEach(categoria => {
            if (categoria.parent_id !== null) {
                // Si la categoría tiene un padre, la añadimos al array 'subcategorias' de su padre
                const padre = categoriasMap[categoria.parent_id];
                if (padre) {
                    padre.subcategorias.push(categoriasMap[categoria.id_categoria]);
                }
            } else {
                // Si no tiene padre, es una categoría principal. La añadimos al resultado final
                categoriasAnidadas.push(categoriasMap[categoria.id_categoria]);
            }
        });
        
        // Nos aseguramos de enviar el array completo de categorías principales
        res.json(categoriasAnidadas);
    });
});

// Endpoint para obtener todos los productos
app.get('/api/productos', (req, res) => {
    const sql = 'SELECT * FROM productos';
    db.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al consultar la tabla productos:', err);
            return res.status(500).json({ error: 'Error interno del servidor' });
        }
        res.json(resultados);
    });
});

// Endpoint para obtener todos los servicios
app.get('/api/servicios', (req, res) => {
    const sql = 'SELECT * FROM servicios';
    db.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al consultar la tabla servicios:', err);
            return res.status(500).json({ error: 'Error interno del servidor' });
        }
        res.json(resultados); 
    });
});

// 6. INICIAR EL SERVIDOR
const port = 3000;
app.listen(port, () => {
    console.log(`Servidor escuchando en http://localhost:${port}`);
});