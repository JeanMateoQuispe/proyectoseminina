<?php
session_start();

//comprobamos si el usuario realmente inicio sesión..
if(!isset($_SESSION['seguridad']) || $_SESSION['seguridad']['login'] == false){
    //cambiar a otra url
    header('Location:../index.php');
}
?>

<!doctype html>
<html lang="es">

<head>
  <title>Matriculados</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
  
</head>

<body>
  
  <div class="container mt-5">
    
    <nav class="navbar navbar-light bg-primary fixed-top ">
      <div class="container-fluid">
        <a class="navbar-brand text-white" href="#">Panel de Inicio</a>
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

    <div class="col-12">
      <div class="card">
        <div class="card-header">
          <h3 class="text-center">Información de Matriculas</h3>
        </div>
        <div class="card-body">
          <div class="col-12">
            <div class="row">
              <div class="mb-3 col-8">
                <label for="buscarmatricula" class="form-label">Buscar Matricula:</label>
                <input type="text" class="form-control" id="buscarmatricula" placeholder="Escriba aqui">
              </div>
               <div class="col-4">
                <div class="d-grid gap-2 col-6 mx-auto">
                  <button class="btn btn-primary" type="button">Buscar</button>
                  <button class="btn btn-secondary" type="button">Reiniciar</button>
                </div>
               </div>
            </div>
          </div>
        </div>
      </div>
      <div class="mb-3 mt-3">
        <!-- Modal trigger button -->
        <button class="btn btn-success" type="button" data-bs-toggle="modal" data-bs-target="#modal-matricula">Registrar matricula</button>
        <!-- Modal Body -->
        <!-- if you want to close by clicking outside the modal, delete the last endpoint:data-bs-backdrop and data-bs-keyboard -->
        <div class="modal fade" id="modal-matricula" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
          <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="modalTitleId">Registrar Matricula</h5>
                  <!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
              </div>
              <div class="modal-body">
                <form action="" id="registro-matricula">
                  <div class="row">
                    <div class="mb-3 col-lg-6">
                      <label for="matriculado" class="form-label">Nombres:</label>
                      <input type="text" class="form-control" id="matriculado" placeholder="Escriba..." maxlength="100">
                    </div>
                    <div class="mb-3 col-lg-6">
                      <label for="nacimiento" class="form-label">Fecha nacimiento:</label>
                      <input type="date" class="form-control" id="nacimiento" placeholder="Escriba...">
                    </div>
                    <div class="mb-3 col-lg-6">
                      <label for="documento" class="form-label">N° Documento:</label>
                      <input type="text" class="form-control" id="documento" placeholder="Escriba..." maxlength="8">
                    </div>
                    <div class="mb-3 col-lg-6">
                      <label for="docente" class="form-label">Docentes:</label>
                      <select class="form-select" aria-label="Default select example" id="docente">
                        <option selected>Seleccione</option>
                        <!-- <option value=""></option> -->
                      </select>
                    </div>
                    <div class="mb-3 col-lg-6">
                      <label for="carrera" class="form-label">Carreras:</label>
                      <select class="form-select" aria-label="Default select example" id="carrera">
                        <option selected>Seleccione</option>
                        <!-- <option value=""></option> -->
                      </select>
                    </div>
                    <div class="mb-3 col-lg-6">
                      <label for="periodo" class="form-label">Periodo:</label>
                      <input type="text" class="form-control" id="periodo" placeholder="Escriba...">
                    </div>
                    <div class="mb-3 col-lg-6">
                      <label for="semestre" class="form-label">Semestre:</label>
                      <input type="text" class="form-control" id="semestre" placeholder="Escriba...">
                    </div>
                    <div class="mb-3 col-lg-6">
                      <label for="fechainicio" class="form-label">Fecha inicio:</label>
                      <input type="date" class="form-control" id="fechainicio" placeholder="Escriba...">
                    </div>
                    <div class="mb-3 col-lg-6">
                      <label for="fechafin" class="form-label">Fecha final:</label>
                      <input type="date" class="form-control" id="fechafinal" placeholder="Escriba...">
                    </div>
                    <div class="mb-3 col-lg-6">
                      <label for="pago" class="form-label">Pago:</label>
                      <input type="text" class="form-control" id="pago" placeholder="S/00.00">
                    </div>
                  </div>
                </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-success" id="registrarmatricula">Guardar</button>
                <button type="button" class="btn btn-primary" id="actualizarmatricula">Actualizar</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
              </div>
            </div>
          </div>
        </div>
        
      </div>
      <div class="row">
        <div class="table-responsive">
          <table class="table table-striped" id="tabla-matricula">
            <thead>
              <tr>
                <th>ID</th>
                <th>Matriculado</th>
                <!-- <th>N° Documento</th> -->
                <th>Docente</th>
                <th>Carrera</th>
                <th>Periodo</th>
                <th>Semestre</th>
                <th>Fecha Inicio</th>
                <th>Fecha Final</th>
                <th>Pago</th>
                <th>Operación</th>
              </tr>
            </thead>
            <tbody>
              
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

   
  <script>
   

    document.addEventListener("DOMContentLoaded", () =>{
     
      const tabla = document.querySelector("#tabla-matricula");
      const cuerpoTabla = document.querySelector("tbody");
      const lista= document.querySelector("#docente");
      const carrera = document.querySelector("#carrera");
      const btnregistrar = document.querySelector("#registrarmatricula");
      const btnactualizar = document.querySelector("#actualizarmatricula");
      const modal = new bootstrap.Modal(document.querySelector("#modal-matricula"));

      function ObtenerDatos(){
        const parametros = new URLSearchParams();
        parametros.append("operacion","listar");
        
        fetch('../controllers/matricula.controller.php',{
          method: 'POST',
          body: parametros
        })
        .then(respuesta => respuesta.json())
        .then(datos => {
          cuerpoTabla.innerHTML=``;
          datos.forEach(element => {
            const fila = `
            <tr>
              <td>${element.idmatricula}</td>
              <td>${element.alumno}</td>
              <td>${element.docente}</td>
              <td>${element.nombrecarrera}</td>
              <td>${element.periodo}</td>
              <td class="text-center">${element.semestre}</td>
              <td>${element.fechainicio}</td>
              <td>${element.fechafinal}</td>
              <td>${element.pago}</td>
              <td>
                  <a href='#' class='eliminar btn btn-danger btn-sm' data-idmatricula='${element.idmatricula}'>Eliminar</a> 
                  <a href='#' class='editar btn btn-info btn-sm' data-idmatricula='${element.idmatricula}'>Editar</a>
              </td>
            `;
            cuerpoTabla.innerHTML += fila;
          });
        })
        .catch(error => {
          cuerpoTabla.innerHTML =``;
          alert('No encontramos datos')
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
            carrera.appendChild(optionTag);
          }); 
        });
      }

      function Obtenerdocentes(){
        const parametros = new URLSearchParams();
        parametros.append("operacion","listar");
        
        fetch('../controllers/docente.controller.php',{
          method: 'POST',
          body: parametros
        })
        .then(respuesta => respuesta.json())
        .then(datos =>{
          datos.forEach(element => {
            const optionTag = document.createElement("option");
            optionTag.value = element[0];
            optionTag.text = element[1];
            lista.appendChild(optionTag);
          }); 
        });
      }

      function registrar(){
        if(confirm("¿Está seguro de registrar?")){
          const parametros = new URLSearchParams();
          parametros.append("operacion","registrarmatricula");

          //Enviar datos 
          parametros.append("alumno",document.querySelector("#matriculado").value);
          parametros.append("fechanac",document.querySelector("#nacimiento").value);
          parametros.append("numdoc",document.querySelector("#documento").value);
          parametros.append("iddocente",document.querySelector("#docente").value);
          parametros.append("idcarrera",document.querySelector("#carrera").value);
          parametros.append("periodo",document.querySelector("#periodo").value);
          parametros.append("semestre",document.querySelector("#semestre").value);
          parametros.append("fechainicio",document.querySelector("#fechainicio").value);
          parametros.append("fechafinal",document.querySelector("#fechafinal").value);
          parametros.append("pago",document.querySelector("#pago").value);

          fetch("../controllers/matricula.controller.php",{
            method: 'POST',
            body: parametros
          })
          .then(response => response.json())
          .then(datos=>{
              if(datos.status){
                ObtenerDatos();
                document.querySelector("#registro-matricula").reset();
                document.querySelector("#matriculado").focus();
              }else{
                alert(datos.message);
              }
          });
        }
      }

      function actualizar(){
        if(confirm("¿Está seguro de actualizar?")){
          const parametros = new URLSearchParams();
          parametros.append("operacion","actualizar");

          //Enviar los datos del formulario (que se encuentra en el modal)
          parametros.append("idmatricula", idmatricula);
          parametros.append("alumno",document.querySelector("#matriculado").value);
          parametros.append("fechanac",document.querySelector("#nacimiento").value);
          parametros.append("numdoc",document.querySelector("#documento").value);
          parametros.append("iddocente",document.querySelector("#docente").value);
          parametros.append("idcarrera",document.querySelector("#carrera").value);
          parametros.append("periodo",document.querySelector("#periodo").value);
          parametros.append("semestre",document.querySelector("#semestre").value);
          parametros.append("fechainicio",document.querySelector("#fechainicio").value);
          parametros.append("fechafinal",document.querySelector("#fechafinal").value);
          parametros.append("pago",document.querySelector("#pago").value);

          fetch("../controllers/matricula.controller.php",{
            method: 'POST',
            body: parametros
          })
            .then(response => response.json())
            .then(datos =>{
              if(datos.status){
                ObtenerDatos();
                modal.toggle();
              }else{
                alert(datos.message);
              }
          })
        }
      }

      //Proceso edicion
      cuerpoTabla.addEventListener("click", (event) => {
        if(event.target.classList[0] === 'editar'){
          idmatricula = parseInt(event.target.dataset.idmatricula);

          const parametros = new URLSearchParams();
          parametros.append("operacion", "obtener");
          parametros.append("idmatricula",idmatricula);

          fetch("../controllers/matricula.controller.php",{
            method: 'POST',
            body: parametros
          })
            .then(response => response.json())
            .then(datos => {
              document.querySelector("#matriculado").value = datos.alumno;
              document.querySelector("#nacimiento").value = datos.fechanac;
              document.querySelector("#documento").value = datos.numdoc;
              document.querySelector("#docente").value = datos.iddocente;
              document.querySelector("#carrera").value = datos.idcarrera;
              document.querySelector("#periodo").value = datos.periodo;
              document.querySelector("#semestre").value = datos.semestre;
              document.querySelector("#fechainicio").value = datos.fechainicio;
              document.querySelector("#fechafinal").value = datos.fechafinal;
              document.querySelector("#pago").value = datos.pago;

              modal.toggle();
            });
        }
      })

      //Proceso eliminación
      cuerpoTabla.addEventListener("click",(event) => {
        if(event.target.classList[0] === 'eliminar'){
          if(confirm("¿Está seguro de eliminar?")){
            idmatricula = parseInt(event.target.dataset.idmatricula);

            const parametros = new URLSearchParams();
            parametros.append("operacion","eliminar");
            parametros.append("idmatricula", idmatricula);

            fetch("../controllers/matricula.controller.php",{
              method: 'POST',
              body: parametros
            })
              .then(response => response.json())
              .then(datos => {
                // console.log(datos);
                if(datos.status){
                  ObtenerDatos();
                }else{
                  alert(datos.message);
                }
              });
          }
        }
      })

        //Eventos
        btnregistrar.addEventListener("click", registrar);
        btnactualizar.addEventListener("click",actualizar);
        ObtenerDatos();
        Obtenerdocentes();
        ObtenerCarreras();
    })
  </script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
  integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous">
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
  integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz" crossorigin="anonymous">
</script>
</body>

</html>