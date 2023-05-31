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
  <title>Document</title>

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
  integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
</head>

<body>
  <div class="container">
    <nav class="navbar navbar-light bg-primary fixed-top ">
      <div class="container-fluid">
        <a class="navbar-brand text-white" href="./matricula.php">Carreras</a>
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
        <form action="" autocomplete="off" id="form-carreras">
          <div class="card">
            <div class="card-header">
              <h5 class="text-center">REGISTRO DE CARRERAS</h5>
            </div>
            <div class="card-body">
              <div class="mb-3">
                <label for="curs" class="form-label">Cursos:</label>
                <select class="form-select" aria-label="Default select example" id="curs">
                  <option selected>Seleccione</option>
                  <!-- <option value=""></option> -->
                </select>
              </div>
              <div class="mb-3">
                  <label for="nomcarr" class="form-label">Carrera:</label>
                  <input type="text" id="nomcarr"  class="form-control form-control-sm" placeholder="Escriba">
              </div>
              <div class="mb-3">
                  <label for="durac" class="form-label">Duración:</label>
                  <input type="text" id="durac"  class="form-control form-control-sm" placeholder="Escriba">
              </div>
            </div>

            <div class="card-footer text-muted">
              <div class="d-grid gap-2">
                <button class="btn btn-sm btn-success" id="registrarcarrera" type="button" >Registrar</button>
                <button class="btn btn-sm btn-primary" id="actualizarcarrera" type="button" >Actualizar</button>
                <button class="btn btn-sm btn-secondary" id="reiniciar" type="reset" >Reiniciar</button>
              </div>
            </div> <!-- fin del footer  -->
            
          </div> <!--Fin del card-->
        </form> <!--Fin del formulario-->
    </div> <!--Fin col-md-4-->


    <div class="col-md-8">
      <table class="table table-sm table-striped" id="tabla-carreras">
          <colgroup>
              <col width="5%">
              <col width="30%">
              <col width="30%">
              <col width="15%">
              <col width="20%">
          </colgroup>
          <thead>
              <tr>
                <th>ID</th>
                <th>Cursos</th>
                <th>Carreras</th>
                <th>Duración</th>
                <th>Operación</th>
              </tr>
          </thead>
  
          <tbody>
  
          </tbody>
      </table>
    </div>

  </div>

  <script>
    document.addEventListener("DOMContentLoaded", () =>{
      const tabla = document.querySelector("#tabla-carreras");
      const cuerpotabla = document.querySelector("tbody");
      const cursos = document.querySelector("#curs");
      const registrar = document.querySelector("#registrarcarrera");
      const actualizar = document.querySelector("#actualizarcarrera");

      function mostrarCursos(){
        const parametros = new  URLSearchParams();
        parametros.append("operacion","listar");

        fetch('../controllers/curso.controller.php',{
          method: 'POST',
          body: parametros
        })
        .then(respuesta => respuesta.json())
        .then(datos => {
          datos.forEach(element => {
            const optionTag = document.createElement("option");
            optionTag.value = element[0];
            optionTag.text = element[1]
            cursos.appendChild(optionTag);
          });
        })
      }

      function obtenerCarreras(){
        const parametros = new URLSearchParams();
        parametros.append("operacion","listarcarrera");

        fetch('../controllers/carrera.controller.php',{
          method: 'POST',
          body: parametros
        })
        .then(respuesta => respuesta.json())
        .then(datos => {
          cuerpotabla.innerHTML=``;
          datos.forEach(element => {
            const fila =`
            <tr>
              <td>${element.idcarrera}</td>
              <td>${element.nombrecurso}</td>
              <td>${element.nombrecarrera}</td>
              <td>${element.duracion}</td>
              <td>
                <a href='#' class='eliminar btn btn-danger btn-sm' data-idcarrera='${element.idcarrera}'>Eliminar</a> 
                <a href='#' class='editar btn btn-info btn-sm' data-idcarrera='${element.idcarrera}'>Editar</a>
              </td>
            </tr>
            `;
            cuerpotabla.innerHTML += fila;
          });
        })
        .catch(error => {
          cuerpotabla.innerHTML =``;
          alert('No encontramos datos')
        })
      }

      function carreraRegister(){
        if(confirm("¿Está seguro de registrar")){
          const parametros = new URLSearchParams();
          parametros.append("operacion","registrarcarrera");

          //Enviar datos 
          parametros.append("idcurso",document.querySelector("#curs").value);
          parametros.append("nombrecarrera",document.querySelector("#nomcarr").value);
          parametros.append("duracion",document.querySelector("#durac").value);

          fetch("../controllers/carrera.controller.php",{
            method: 'POST',
            body: parametros
          })
          .then(response => response.json())
          .then(datos => {
            if(datos.status){
              obtenerCarreras();
              document.querySelector("#form-carreras").reset();
              document.querySelector("#curs").focus();
            }else{
              alert(datos.message);
            }
          });
        }
      }

      function carreraActualizar(){
        if(confirm("¿Está seguro de actualizar?")){
          const parametros = new URLSearchParams();
          parametros.append("operacion","actualizarcarrera");

          //Enviar los datos
          parametros.append("idcarrera",idcarrera);
          parametros.append("idcurso", document.querySelector("#curs").value);
          parametros.append("nombrecarrera", document.querySelector("#nomcarr").value);
          parametros.append("duracion", document.querySelector("#durac").value);

          fetch("../controllers/carrera.controller.php",{
            method: 'POST',
            body: parametros
          })
          .then(response => response.json())
          .then(datos =>{
            if(datos.status){
              obtenerCarreras();
              document.querySelector("#form-carreras").reset();
              document.querySelector("#curs").focus();
            }else{
              alert(datos.message);
            }
          })

        }
      }

      //Proceso Eliminacion
      cuerpotabla.addEventListener("click",(event) => {
        if(event.target.classList[0] === 'eliminar'){
          if(confirm("¿Está seguro de eliminar?")){
            idcarrera = parseInt(event.target.dataset.idcarrera);

            const parametros = new URLSearchParams();
            parametros.append("operacion","eliminarcarrera");
            parametros.append("idcarrera", idcarrera);

            fetch("../controllers/carrera.controller.php",{
              method: 'POST',
              body: parametros
            })
            .then(response => response.json())
            .then(datos => {
              if(datos.status){
                obtenerCarreras();
              }else{
                alert(datos.message)
              }
            });
          }
        }
      })

      //Proceso Editar
      cuerpotabla.addEventListener("click",(event) => {
        if(event.target.classList[0] === 'editar'){
          idcarrera = parseInt(event.target.dataset.idcarrera);

          const parametros = new URLSearchParams();
          parametros.append("operacion","obtenercarrera");
          parametros.append("idcarrera", idcarrera);

          fetch("../controllers/carrera.controller.php", {
            method: 'POST',
            body: parametros
          })
          .then(response => response.json())
          .then(datos => {
            document.querySelector("#curs").value = datos.idcurso;
            document.querySelector("#nomcarr").value = datos.nombrecarrera;
            document.querySelector("#durac").value = datos.duracion;
          });
        }
      })
      //evento
      registrar.addEventListener("click", carreraRegister);
      actualizar.addEventListener("click", carreraActualizar);
      mostrarCursos();
      obtenerCarreras();
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