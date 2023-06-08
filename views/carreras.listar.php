<?php
session_start();

//comprobamos si el usuario realmente inicio sesión..
if(!isset($_SESSION['seguridad']) || $_SESSION['seguridad']['login'] == false){
    //cambiar a otra url
    header('Location:../index.php');
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carreras</title>
    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <!-- DataTable -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.2.0/css/bootstrap.min.css">
    <link href="https://cdn.datatables.net/1.13.1/css/dataTables.bootstrap5.min.css" rel="stylesheet">
</head>
<body>
    <div>

        <nav class="navbar navbar-expand-lg bg-dark-subtle">
            <div class="container-fluid">
                <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAXNSR0IArs4c6QAAAMdJREFUWEftltENwjAMBa8b0ElhA2AENmUDUCSKipvGsSWjVHL+mjrx69kv6cRgYxpMD4cS9AqmV4XRIpSCSkW0HroB10/p7kB59ozufVIQ0CTtJbRXAuv8pvwpKKpkVqelyzRibkJl4Rk4VTKs7Wp10zpebv0ALsukdFnr/ooS9ATmkQT9XGFeQlrPyPetkqWgQuBvhPZMIFshBckmTkILkewh6wHojf/2nOWk9ibrWXccQT1fExqj/eSHJq9tnoI05ElII/QGmt1uJUuPxyEAAAAASUVORK5CYII="/><a class="navbar-brand" href="#">Institución</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link " href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Matriculas
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="./matriculas.php">Mostrar</a></li>
                                <li><a class="dropdown-item" href="./matricula.registrar.php">Registrar</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link " href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Carreras
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="./carreras.detalles.php">Detalles de carrreas</a></li>
                                <li><a class="dropdown-item" href="./carreras.registrar.php">Registrar</a></li>
                                <li><a class="dropdown-item" href="./carreras.listar.php">Carreras</a></li>

                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link " href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Estudiantes
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="./estudiantes.php">Listar</a></li>
                                <li><a class="dropdown-item" href="#">Registrar</a></li>
                
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link " href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Docentes
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="./docentes.php">Listar</a></li>
                                <li><a class="dropdown-item" href="./carreras.registrar.php">Registrar</a></li>

                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link " href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Cursos
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="./cursos.php">Listar</a></li>
                                <li><a class="dropdown-item" href="./cursos.registrar.php">Registrar</a></li>
                                <li><a class="dropdown-item" href="#">Editar</a></li>
                            </ul>
                        </li>
                        
                    </ul>
                    <form class="d-flex" role="search">
                        
                        <div class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <span><?= $_SESSION['seguridad']['nombres']?> <?= $_SESSION['seguridad']['apellidos']?></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="../controllers/usuario.php?operacion=destroy">Cerrar Sesión</a></li>
                            </ul>
                        </div>
                    </form>
                </div>
            </div>
        </nav>
    </div>
   
        
    
    <div class="container">
        
        <div class="table-responsive">
        <h3 class="text-center mt-2">Lista de Carreras</h3>
            <hr>
            <!-- <div class="row"> -->
                <form action="">
                    <table class="table table-striped" id="tabla-carreras">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Carrera</th>
                                <th>Duración</th>
                                <th>Costo</th>
                                <th>Operación</th>
                            </tr>
                        </thead>
                        <tbody>
                           
                        </tbody>
                    </table>
                </form>
            <!-- </div> -->
        </div>
    </div>

    
    
    <!-- Modal buscar matriculas -->
    <!-- if you want to close by clicking outside the modal, delete the last endpoint:data-bs-backdrop and data-bs-keyboard -->
    <div class="modal fade" id="md-carreras" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">Editar Carrera</h5>
                <!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
            </div>
            <div class="modal-body">
            <form action="" id="registro-matricula">
                <div class="row">
                    <div class="mb-3 col-lg-6">
                        <label for="carrera" class="form-label">Carrera:</label>
                        <input type="text" class="form-control" id="carrera" placeholder="Año-01">
                    </div>
                    <div class="mb-3 col-lg-6">
                        <label for="duracion" class="form-label">Duración:</label>
                        <input type="text" class="form-control" id="duracion" placeholder="Año-01">
                    </div>
                    <div class="mb-3 col-lg-6">
                        <label for="costo" class="form-label">Costo:</label>
                        <input type="text" class="form-control" id="costo" placeholder="S/." >
                    </div> 
                </div>
                
            </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="actualizarcarreras">Actualizar</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
        </div>
    </div>

    <!-- Alert Sweet -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- AJAX = JavaScript asincrónico-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

    <!-- datatable-->
    <script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.1/js/dataTables.bootstrap5.min.js"></script>

    <!-- opcional-->
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
   
    
    <script>
        document.addEventListener("DOMContentLoaded", () => {

            const tabla = document.querySelector("#tabla-carreras");
            const cuerpo = document.querySelector("tbody");
            const carreras = document.querySelector("#carrera");
            
            const btnactualizar = document.querySelector("#actualizarcarreras");
            const modal = new bootstrap.Modal(document.querySelector("#md-carreras"));

            function obtenerCarreras(){
                const parametros = new  URLSearchParams();
                    parametros.append("operacion","listar");

                    fetch('../controllers/carrera.php',{
                        method: 'POST',
                        body: parametros
                    })
                    .then(respuesta => respuesta.json())
                    .then(datos => {
                    datos.forEach(element => {
                        const optionTag = document.createElement("option");
                        optionTag.value = element[0];
                        optionTag.text = element[1]
                        carreras.appendChild(optionTag);
                    });
                })
            }


            function Mostrarcarreras(){
                const parametros = new URLSearchParams();
                parametros.append("operacion","listarcar");

                fetch('../controllers/carrera.php', {
                    method: 'POST',
                    body: parametros
                })
                .then(response => response.json())
                .then(datos => {
                    cuerpo.innerHTML=``;
                    datos.forEach(element => {
                        const fila = `
                         <tr>
                            <td>${element.idcarrera}</td>
                            <td>${element.carrera}</td>
                            <td>${element.duracion}</td>
                            <td>${element.costo}</td>
                            
                            <td >
                                <a href='#' class='eliminar btn btn-outline-danger btn-sm' data-idcarrera='${element.idcarrera}'>Eliminar</a> 
                                <a href='#' class='editar btn btn-outline-info btn-sm' data-bs-toggle='modal' data-bs-target='#md-carreras' data-idcarrera ='${element.idcarrera}'>Editar</a>
                            </td>
                        </tr>
                        `;
                        cuerpo.innerHTML += fila;
                    });
                })
            }

            function actualizar(){
                // if(confirm("¿Está seguro de actualizar?")){
                    const parametros = new URLSearchParams();
                    parametros.append("operacion","actualizarcar");

                    //Enviar los datos del formulario (que se encuentra en el modal)
                    parametros.append("idcarrera", idcarrera);
                    parametros.append("carrera",document.querySelector("#carrera").value);
                    parametros.append("duracion",document.querySelector("#duracion").value);
                    parametros.append("costo",document.querySelector("#costo").value);
                   

                    fetch("../controllers/carrera.php",{
                        method: 'POST',
                        body: parametros
                    })
                    .then(response => response.json())
                    .then(datos =>{
                        if(datos.status){
                            Swal.fire({
                                icon: 'success',
                                title: 'Actualizado Correctamente',
                                showConfirmButton: false,
                                timer: 1500
                            })
                            modal.toggle();
                            Mostrarcarreras();
                        }else{
                            alert(datos.message);
                        }
                    })
                // }
            }

            //Proceso edicion
            cuerpo.addEventListener("click", (event) => {
                if(event.target.classList[0] === 'editar'){
                    idcarrera = parseInt(event.target.dataset.idcarrera);

                    const parametros = new URLSearchParams();
                    parametros.append("operacion", "obtenercar");
                    parametros.append("idcarrera",idcarrera);

                    fetch("../controllers/carrera.php",{
                        method: 'POST',
                        body: parametros
                    })
                    .then(response => response.json())
                    .then(datos => {
                        document.querySelector("#carrera").value = datos.carrera;
                        document.querySelector("#duracion").value = datos.duracion;
                        document.querySelector("#costo").value = datos.costo;
                       
                    modal.toggle();
                    });
                }
            })

            //Proceso eliminación
            cuerpo.addEventListener("click",(event) => {
                if(event.target.classList[0] === 'eliminar'){
                    if(confirm("¿Está seguro de eliminar?")){
                        idcarrera = parseInt(event.target.dataset.idcarrera);

                        const parametros = new URLSearchParams();
                        parametros.append("operacion","eliminarcar");
                        parametros.append("idcarrera", idcarrera);

                        fetch("../controllers/carrera.php",{
                            method: 'POST',
                            body: parametros
                        })
                        .then(response => response.json())
                        .then(datos => {
                            if(datos.status){
                                Swal.fire({
                                icon: 'success',
                                title: 'Eliminado correctamente',
                                showConfirmButton: false,
                                timer: 1500
                                })
                                Mostrarcarreras();
                            }else{
                                alert(datos.message);
                            }
                        });
                    }
                }
            })
            btnactualizar.addEventListener("click",actualizar);
            obtenerCarreras();
            Mostrarcarreras();
        });
    </script>
 
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js" integrity="sha384-fbbOQedDUMZZ5KreZpsbe1LCZPVmfTnH7ois6mU1QK+m14rQ1l2bGBq41eYeM/fS" crossorigin="anonymous"></script>
</body>
</html>