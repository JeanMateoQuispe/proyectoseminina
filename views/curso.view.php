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
        <a class="navbar-brand text-white" href="./matricula.php">Cursos</a>
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
        <form action="" autocomplete="off" id="form-cursos">
          <div class="card">
            <div class="card-header">
            <h5 class="text-center">REGISTRO DE CURSOS</h5>
            </div>
            <div class="card-body">
              <div class="mb-3">
                  <label for="nomcur" class="form-label">Nombre del Curso:</label>
                  <input type="text" id="nomcur"  class="form-control form-control-sm" placeholder="Escriba">
              </div>
              <div class="mb-3">
                  <label for="credit" class="form-label">Creditos:</label>
                  <input type="text" id="credit"  class="form-control form-control-sm" placeholder="Escriba">
              </div>
            </div>

            <div class="card-footer text-muted">
              <div class="d-grid gap-2">
                <button class="btn btn-sm btn-success" id="registrarcurso" type="button" >Registrar</button>
                <button class="btn btn-sm btn-primary" id="actualizarcurso" type="button" >Actualizar</button>
                <button class="btn btn-sm btn-secondary" id="reiniciar" type="reset" >Reiniciar</button>
              </div>
            </div> <!-- fin del footer  -->
            
          </div> <!--Fin del card-->
        </form> <!--Fin del formulario-->
    </div> <!--Fin col-md-4-->

    <!-- Aqui se construye la tabla -->
    <div class="col-md-8">
      <table class="table table-sm table-striped" id="tabla-cursos">
          <colgroup>
              <col width="10%">
              <col width="30%">
              <col width="30%">
              <col width="30%">
          </colgroup>
          <thead>
              <tr>
                <th>ID</th>
                <th>Curso</th>
                <th>Creditos</th>
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
      // creo variable
      let idcurso = ``;

      // objetos
      const tabla = document.querySelector("#tabla-cursos");
      const tablacuerpo = document.querySelector("tbody");
      const btnregistrar = document.querySelector("#registrarcurso");
      const btnactualizar = document.querySelector("#actualizarcurso");

      function mostrarCursos(){
        const parametros = new URLSearchParams();
        parametros.append("operacion","listarcursos");

        fetch("../controllers/curso.controller.php",{
          method: 'POST',
          body: parametros
        })
        .then(response => response.json())
        .then(datos =>{
          tablacuerpo.innerHTML = ``,
          datos.forEach(element => {
            const fila = `
            <tr>
              <td>${element.idcurso}</td>
              <td>${element.nombrecurso}</td>
              <td>${element.creditos}</td>
              <td>
                <a href='#' class='eliminar btn btn-danger btn-sm' data-idcurso='${element.idcurso}'>Eliminar</a> 
                <a href='#' class='editar btn btn-info btn-sm' data-idcurso='${element.idcurso}'>Editar</a>
              </td>
            </tr>
            `;
            tablacuerpo.innerHTML += fila;
          });
        })
      }

      function cursoRegister(){
        if(confirm("¿Está seguro de registrar?")){
          const parametros = new URLSearchParams();
            parametros.append("operacion","registrarcurso");

            //Enviar datos al formulario
            parametros.append("nombrecurso",document.querySelector("#nomcur").value);
            parametros.append("creditos",document.querySelector("#credit").value);

            fetch("../controllers/curso.controller.php",{
              method: 'POST',
              body: parametros
            })
            .then(response => response.json())
            .then(datos =>{
                if(datos.status){
                mostrarCursos();
                document.querySelector("#form-cursos").reset();
                document.querySelector("#nomcur").focus();
                }else{
                alert(datos.message);
                }
            });
        }
      }

      function cursoActualizar(){
        if(confirm("¿Está seguro de actualizar")){
          const parametros = new URLSearchParams();
          parametros.append("operacion","actualizarcurso");

          //Enviar los datos del formulario(campos)
          parametros.append("idcurso", idcurso);
          parametros.append("nombrecurso",document.querySelector("#nomcur").value);
          parametros.append("creditos",document.querySelector("#credit").value);

          fetch("../controllers/curso.controller.php", {
            method: 'POST',
            body: parametros
          })
          .then(response => response.json())
          .then(datos =>{
            if(datos.status){
              mostrarCursos();
              document.querySelector("#form-cursos").reset();
              document.querySelector("#nomcur").focus();
            }else{
              alert(datos.message);
            }
          })
        }
      }

      //proceso eliminar
      tablacuerpo.addEventListener("click",(event) =>{
      if(event.target.classList[0] === 'eliminar'){
        if(confirm("¿Está seguro de eliminar?")){
          idcurso = parseInt(event.target.dataset.idcurso);

          const parametros = new URLSearchParams();
          parametros.append("operacion","eliminarcurso");
          parametros.append("idcurso", idcurso);

          fetch("../controllers/curso.controller.php",{
            method: 'POST',
            body: parametros
          })
          .then(response => response.json())
          .then(datos =>{
            if(datos.status){
              mostrarCursos();
            }else{
              alert(datos.message);
            }
          })
        }
      }
      })

      //proceso editar
      tablacuerpo.addEventListener("click",(event) => {
        if(event.target.classList[0] === 'editar'){
          idcurso = parseInt(event.target.dataset.idcurso);

          const parametros = new URLSearchParams();
          parametros.append("operacion","obtenercurso");
          parametros.append("idcurso", idcurso);

          fetch("../controllers/curso.controller.php", {
            method: 'POST',
            body: parametros
          })
          .then(response => response.json())
          .then(datos => {
            document.querySelector("#nomcur").value = datos.nombrecurso;
            document.querySelector("#credit").value = datos.creditos;
          });
        }
      })
      // eventos
      btnregistrar.addEventListener("click", cursoRegister);
      btnactualizar.addEventListener("click",cursoActualizar);
      mostrarCursos();
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