document.addEventListener('DOMContentLoaded', () => {

    // URLs de la api
    const API_BASE_URL = 'http://localhost:3000/api';

    // Función principal para iniciar la carga de datos
    async function inicializarApp() {
        try {
            // Cargar todos los datos en paralelo para mayor eficiencia
            await Promise.all([
                cargarDatosEmprendimiento(),
                cargarServicios(),
                cargarCategorias(),
                cargarProductos()
            ]);
        } catch (error) {
            console.error("Error al inicializar la aplicación:", error);
        }
    }
    //EVENT LISTENER PARA DESPLEGAR SUBCATEGORÍAS
const categoriasListaElement = document.getElementById('categorias-lista');
categoriasListaElement.addEventListener('click', (evento) => {
    // Buscamos si el clic fue dentro de un cabezal de categoría
    const header = evento.target.closest('.category-header');
    if (header) {
        // Obtenemos el li padre
        const categoriaPadre = header.parentElement;
        if (categoriaPadre.classList.contains('has-subcategories')) {
            categoriaPadre.classList.toggle('open');
            const subList = categoriaPadre.querySelector('.subcategory-list');
            if (subList) {
                subList.classList.toggle('show');
            }
        }
    }
});
    //FUNCIONES DE CARGA DE DATOS 

    async function cargarDatosEmprendimiento() {
        const res = await fetch(`${API_BASE_URL}/emprendimiento`);
        const data = await res.json();
        
        // Actualizar el DOM con los datos del emprendimiento
        document.getElementById('header-contacto').innerText = data.contacto;
        document.getElementById('emprendimiento-nombre').innerText = data.nombre;
        document.getElementById('emprendimiento-descripcion').innerText = data.descripcion;
        document.getElementById('footer-descripcion').innerText = data.descripcion;
        document.getElementById('footer-contacto').innerText = `Email: ${data.contacto}`;
        document.getElementById('footer-direccion').innerText = `Dirección: ${data.direccion || 'No especificada'}`;
        document.getElementById('mision-texto').innerText = data.mision;
    }
// Función para cargar y mostrar servicios
    async function cargarServicios() {
        const res = await fetch(`${API_BASE_URL}/servicios`);
        const servicios = await res.json();
        const listaServicios = document.getElementById('servicios-lista');
        listaServicios.innerHTML = ''; 
        if (servicios.length === 0) {
            listaServicios.innerHTML = "<p>No hay servicios disponibles en este momento.</p>";
            return;
        }

        servicios.forEach(servicio => {
            const card = document.createElement('div');
            card.className = 'card';
            card.innerHTML = `
                <h3>${servicio.nombre}</h3>
                <p>${servicio.descripcion}</p>
                <div class="card-price">$${parseFloat(servicio.precio).toFixed(2)}</div>
            `;
            listaServicios.appendChild(card);
        });
    }
// Función para cargar y mostrar categorías de forma anidada
async function cargarCategorias() {
    const res = await fetch(`${API_BASE_URL}/categorias`);
    const categorias = await res.json();
    const listaCategorias = document.getElementById('categorias-lista');
    listaCategorias.innerHTML = '';

    categorias.forEach(categoria => {
        const li = document.createElement('li');
        li.dataset.id = categoria.id_categoria;

        if (categoria.subcategorias && categoria.subcategorias.length > 0) {
            li.classList.add('has-subcategories');
            li.innerHTML = `<div class="category-header">
                                <span>${categoria.nombre}</span>
                                <span class="arrow">›</span>
                            </div>`;

            const subUl = document.createElement('ul');
            subUl.className = 'subcategory-list';
            categoria.subcategorias.forEach(sub => {
                const subLi = document.createElement('li');
                subLi.textContent = sub.nombre;
                subLi.dataset.id = sub.id_categoria;
                subUl.appendChild(subLi);
            });
            li.appendChild(subUl);
        } else {
            li.textContent = categoria.nombre;
        }
        listaCategorias.appendChild(li);
    });
}
 // Función para cargar y mostrar productos
    async function cargarProductos() {
        const res = await fetch(`${API_BASE_URL}/productos`);
        const productos = await res.json();
        const listaProductos = document.getElementById('productos-lista');
        listaProductos.innerHTML = '';

        if (productos.length === 0) {
            listaProductos.innerHTML = "<p>No hay productos disponibles en este momento.</p>";
            return;
        }

        productos.forEach(producto => {
            const card = document.createElement('div');
            card.className = 'card';
            card.innerHTML = `
                <h3>${producto.nombre}</h3>
                <p>${producto.descripcion}</p>
                <div class="card-stock">Stock: ${producto.stock}</div>
                <div class="card-price">$${parseFloat(producto.precio).toFixed(2)}</div>
            `;
            listaProductos.appendChild(card);
        });
    }

    // Iniciar la aplicación
    inicializarApp();
});