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
    <title>Docentes</title>

    <!-- Bootstrap CSS v5.2.1 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <nav class="navbar navbar-light bg-primary fixed-top ">
            <div class="container-fluid">
              <a class="navbar-brand text-white" href="./matricula.php">Docentes</a>
              <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
                aria-controls="offcanvasNavbar">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar"
                aria-labelledby="offcanvasNavbarLabel">
                <div class="offcanvas-header">
                  <h5><?= $_SESSION['seguridad']['nombres']?> <?= $_SESSION['seguridad']['apellidos']?></h5>
                  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                  
                  <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                      <form class="d-flex">
                          <input class="form-control me-2" type="search" placeholder="Escriba.." aria-label="Search">
                          <button class="btn btn-outline-success" type="submit">Buscar</button>
                      </form>
                      <li class="nav-item ">
                        <a class="nav-link" href="./matricula.php">Inicio</a>
                      </li>
                      <li class="nav-item ">
                          <a class="nav-link" href="./registrarusuario.view.html">Usuarios</a>
                      </li>
                      <li class="nav-item">
                          <a class="nav-link " aria-current="page" href="./docente.view.php">Docentes</a>
                      </li>
                      <li class="nav-item">
                          <a class="nav-link" href="./carrera.view.php">Carreras</a>
                      </li>
                      <li class="nav-item ">
                          <a class="nav-link" href="./curso.view.php">Cursos</a>
                      </li>
                      <li class="nav-item">
                          <a class="nav-link" href="../controllers/usuario.controller.php?operacion=destroy">Cerrar sesión</a>
                      </li>
                  </ul>
                  
                </div>
              </div>
            </div>
        </nav>

        <br>

        <div class="row mt-5">
          <!-- formulario -->
          <div class="col-md-4">
            <form action="" autocomplete="off" id="form-docentes">
              <div class="card">
                <div class="card-header">
                <h5 class="text-center">REGISTRO DE DOCENTES</h5>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label for="nomdoc" class="form-label">Docente :</label>
                        <input type="text" id="nomdoc"  class="form-control form-control-sm" placeholder="Escriba">
                    </div>
                    <div class="mb-3">
                        <label for="nacimiento" class="form-label">Fecha Nacimiento:</label>
                        <input type="date" id="nacimiento"  class="form-control form-control-sm">
                    </div>
                    <div class="mb-3">
                        <label for="documento" class="form-label">N° Documento :</label>
                        <input type="text" id="documento" class="form-control form-control-sm"  placeholder="Número DNI">
                    </div>
                    <div class="mb-3">
                        <label for="especialidad" class="form-label">Especialidad:</label>
                        <input type="text" id="especialidad" class="form-control form-control-sm"  placeholder="Escriba">
                    </div>
                    <div class="mb-3">
                        <label for="curso" class="form-label"> Curso:</label>
                        <select id="curso" class="form-select form-select-sm" autofocus>
                            <option selected>Seleccione</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="carrera" class="form-label"> Carrera:</label>
                        <select id="carrera" class="form-select form-select-sm" autofocus>
                            <option selected>Seleccione</option>
                        </select>
                    </div>

                </div>
    
                <div class="card-footer text-muted">
                  <div class="d-grid gap-2">
                    <button class="btn btn-sm btn-success" id="registrardocente" type="button" >Registrar</button>
                    <button class="btn btn-sm btn-primary" id="actualizardocente" type="button" >Actualizar</button>
                    <button class="btn btn-sm btn-secondary" id="reiniciar" type="reset" >Reiniciar</button>
                  </div>
                </div> <!-- fin del footer  -->
                
              </div> <!--Fin del card-->
            </form> <!--Fin del formulario-->
        </div> <!--Fin col-md-4-->
          
        <div class="modal fade" id="modal-docente" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-info text-light">
                        <h5 class="modal-title" id="modalTitleId">Actualizar datos</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="nomdoc" class="form-label">Docente :</label>
                            <input type="text" id="nomdoc"  class="form-control form-control-sm" placeholder="Escriba">
                        </div>
                        <div class="mb-3">
                            <label for="md-nacimiento" class="form-label">Fecha Nacimiento:</label>
                            <input type="date" id="md-nacimiento"  class="form-control form-control-sm">
                        </div>
                        <div class="mb-3">
                            <label for="md-documento" class="form-label">N° Documento :</label>
                            <input type="text" id="md-documento" class="form-control form-control-sm"  placeholder="Número DNI">
                        </div>
                        <div class="mb-3">
                            <label for="md-especialidad" class="form-label">Especialidad:</label>
                            <input type="text" id="md-especialidad" class="form-control form-control-sm"  placeholder="Escriba">
                        </div>
                        <div class="mb-3">
                            <label for="md-curso" class="form-label"> Curso:</label>
                            <select id="md-curso" class="form-select form-select-sm" autofocus>
                                <option selected>Seleccione</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="md-carrera" class="form-label"> Carrera:</label>
                            <select id="md-carrera" class="form-select form-select-sm" autofocus>
                                <option selected>Seleccione</option>
                            </select>
                        </div>
                        <div class="modal-footer ">
                            <div class="d-grid gap-2">
                                
                                <button class="btn btn-sm btn-secondary" id="cancelar" type="reset" >Riniciar</button>
                            </div>
                        </div> <!-- fin del footer  -->
                    </div>
                </div>
            </div>
        </div>

        <!-- Aqui se construye la tabla -->
        <div class="col-md-8">
            <table class="table table-sm table-striped" id="tabla-docentes">
                <colgroup>
                    <col width="5%">
                    <col width="30%">
                    <col width="25%">
                    <col width="20%">
                    <col width="20%">
                </colgroup>
                <thead>
                    <tr>
                    <th>ID</th>
                    <th>Docente</th>
                    <!-- <th>F. Nac</th> -->
                    <!-- <th>N° DNI</th> -->
                    <th>Especialidad</th>
                    <th>Curso</th>
                    <!-- <th>Carrera</th> -->
                    <th>Operación</th>
                    </tr>
                </thead>
        
                <tbody>
        
                </tbody>
            </table>
        </div>
    </div> <!--fin conteiner -->

    <script>
        document.addEventListener("DOMContentLoaded", () => {
            //variable
            let iddocente = ``;
            // obejtos
            const tabla = document.querySelector("#tabla-docentes");
            const cuerpoTabla = document.querySelector("tbody");
            const btnRegistrar = document.querySelector("#registrardocente");
            const carreras = document.querySelector("#carrera");
            const cursos = document.querySelector("#curso");
            const btnActualizar = document.querySelector("#actualizardocente");

            const modal = new bootstrap.Modal(document.querySelector("#modal-docente"));
            // const modal = new bootstrap.Modal(document.querySelector("#modal-docentes"));

            // funciones
            function ObtenerCursos(){
                const parametros = new URLSearchParams();
                parametros.append("operacion","listar");
                
                fetch('../controllers/curso.controller.php',{
                    method: 'POST',
                    body: parametros
                })
                    .then(respuesta => respuesta.json())
                    .then(datos =>{
                    datos.forEach(element => {
                        const optionTag = document.createElement("option");
                        optionTag.value = element[0];
                        optionTag.text = element[1]
                        cursos.appendChild(optionTag);
                    }); 
                });
            }

            function ObtenerCarreras(){
                const parametros = new URLSearchParams();
                parametros.append("operacion","listar");
                
                fetch('../controllers/carrera.controller.php',{
                    method: 'POST',
                    body: parametros
                })
                    .then(respuesta => respuesta.json())
                    .then(datos =>{
                    datos.forEach(element => {
                        const optionTag = document.createElement("option");
                        optionTag.value = element[0];
                        optionTag.text = element[2]
                        carreras.appendChild(optionTag);
                    }); 
                });
            }

            

            //obtiene los datos de la tabla y los muestra en esta seccion tbody
            function MostrarDocentes(){
                //construimos un obejto conteniendo la informacion a enviar
                const parametros = new URLSearchParams();
                parametros.append("operacion","listardocentes");
        
                fetch("../controllers/docente.controller.php",{
                method: 'POST',
                body: parametros
                })
                .then(response => response.json())
                .then(datos => {
                    cuerpoTabla.innerHTML = ``;
                    // let numeroFila = 1;
                    datos.forEach(registro => {
                    const fila = `
                    <tr>
                        <td>${registro.iddocente}</td>
                        <td>${registro.docente}</td>
                        <td>${registro.especialidad}</td>
                        <td>${registro.nombrecurso}</td>          
                        <td>
                            <a href='#' class='eliminar btn btn-danger btn-sm' data-iddocente='${registro.iddocente}'>Eliminar</a> 
                            <a href='#' class='editar btn btn-info btn-sm' data-iddocente='${registro.iddocente}'>Editar</a>
                        </td>
                    </tr>
                    `;
                    cuerpoTabla.innerHTML +=fila;
                    // numeroFila++;
                    });
                });
            }
        
            function docenteRegister(){
            if(confirm("¿Está seguro de registrar?")){
                const parametros = new URLSearchParams();
                parametros.append("operacion","registrardocente");
    
                //Enviar datos al formulario
                parametros.append("docente",document.querySelector("#nomdoc").value);
                parametros.append("fechanac",document.querySelector("#nacimiento").value);
                parametros.append("numdoc",document.querySelector("#documento").value);
                parametros.append("especialidad",document.querySelector("#especialidad").value);
                parametros.append("idcurso",document.querySelector("#curso").value);
                parametros.append("idcarrera",document.querySelector("#carrera").value);
    
                fetch("../controllers/docente.controller.php",{
                method: 'POST',
                body: parametros
                })
                .then(response => response.json())
                .then(datos =>{
                    if(datos.status){
                    MostrarDocentes();
                    document.querySelector("#form-docentes").reset();
                    document.querySelector("#nomdoc").focus();
                    }else{
                    alert(datos.message);
                    }
                });
                }
            }
        
            function docentelUpdate(){
            if(confirm("¿Está seguro de actualizar?")){
                const parametros = new URLSearchParams();
                parametros.append("operacion","actualizardocente");
    
                //Enviar los datos al formulario
                parametros.append("iddocente",iddocente);
                parametros.append("docente",document.querySelector("#nomdoc").value);
                parametros.append("fechanac",document.querySelector("#nacimiento").value);
                parametros.append("numdoc",document.querySelector("#documento").value);
                parametros.append("especialidad",document.querySelector("#especialidad").value);
                parametros.append("idcurso",document.querySelector("#curso").value);
                parametros.append("idcarrera",document.querySelector("#carrera").value);
    
                fetch("../controllers/docente.controller.php",{
                    method: 'POST',
                    body: parametros
                })
                .then(response => response.json())
                .then(datos =>{
                    if(datos.status){
                    MostrarDocentes();
                    // modal.toggle();
                    document.querySelector("#form-docentes").reset();
                    document.querySelector("#nomdoc").focus();
                    }else{
                    alert(datos.message);
                    }
                })
            }
            }
        
            //Proceso eliminación
            cuerpoTabla.addEventListener("click",(event) => {
            if(event.target.classList[0] === 'eliminar'){
                if(confirm("¿Está seguro de eliminar?")){
                iddocente = parseInt(event.target.dataset.iddocente);
    
                const parametros = new URLSearchParams();
                parametros.append("operacion","eliminardocente");
                parametros.append("iddocente", iddocente);
    
                fetch("../controllers/docente.controller.php",{
                    method: 'POST',
                    body: parametros
                })
                    .then(response => response.json())
                    .then(datos => {
                    // console.log(datos);
                    if(datos.status){
                        renderData();
                    }else{
                        alert(datos.message);
                    }
                    });
                }
            }
            })
        
                //Proceso edicion
                cuerpoTabla.addEventListener("click", (event) => {
                if(event.target.classList[0] === 'editar'){
                    iddocente = parseInt(event.target.dataset.iddocente);
        
                    const parametros = new URLSearchParams();
                    parametros.append("operacion","obtenerdocente");
                    parametros.append("iddocente",iddocente);
        
                    fetch("../controllers/docente.controller.php",{
                    method: 'POST',
                    body: parametros
                    })
                    .then(response => response.json())
                    .then(datos => {
                        document.querySelector("#nomdoc").value = datos.docente;
                        document.querySelector("#nacimiento").value = datos.fechanac;
                        document.querySelector("#documento").value = datos.numdoc;
                        document.querySelector("#especialidad").value = datos.especialidad;
                        document.querySelector("#curso").value = datos.idcurso;
                        document.querySelector("#carrera").value = datos.idcarrera;
        
                        // modal.toggle();
                    });
                }
            })
        
            //Eventos
            btnRegistrar.addEventListener("click", docenteRegister);
            btnActualizar.addEventListener("click",docentelUpdate);
            MostrarDocentes();
            ObtenerCursos();
            ObtenerCarreras();
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
    integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous">
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
    integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz" crossorigin="anonymous">
    </script>
</body>
</html>