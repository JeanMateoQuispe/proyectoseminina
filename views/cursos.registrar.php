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
    <title>Registrar Curso</title>
    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
    <div class="cuerpo">

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
                                <li><a class="dropdown-item" href="./matriculas.php">Listar</a></li>
                                <li><a class="dropdown-item" href="./matricula.registrar.php">Registrar</a></li>
                                <li><a class="dropdown-item" href="#">Editar</a></li>
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
                                <li><a class="dropdown-item" href="#">Editar</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link " href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Docentes
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="./docentes.php">Listar</a></li>
                                <li><a class="dropdown-item" href="./docentes.registrar.php">Registrar</a></li>
                                <li><a class="dropdown-item" href="#">Editar</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link " href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Cursos
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="./cursos.php">Listar</a></li>
                                <li><a class="dropdown-item" href="./cursos.registrar.php">Registrar</a></li>
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
    <div class="container mt-3 col-4">
        <div class="card">
            <div class="card-header bg-success-subtle text-black">
                <h4 class="text-center">DATOS DEL CURSO</h4>
            </div>
            <div class="card-body" >
                <form action="" id="form-cursos">
                <div class="row">
                        <div class="col-lg-12" >
                            <label for="curso" class="form-label">Curso:</label>
                            <div class="input-group mb-3 ">
                                <span class="input-group-text" id="basic-addon1"><i class='bx bxs-note' ></i></span>
                                <input type="text" class="form-control" placeholder="Escriba..." aria-label="Username" aria-describedby="basic-addon1" id="curso">
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <label for="creditos" class="form-label">Creditos:</label>
                            <div class="input-group mb-3 ">
                                <span class="input-group-text" id="basic-addon1"><i class='bx bx-timer' ></i></span>
                                <input type="text" class="form-control"  placeholder="Escriba..." aria-label="Username" aria-describedby="basic-addon1" id="creditos">
                            </div>
                        </div>

                    </div>
                </form>
            </div>
            <div class="card-footer text-muted">
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <button class="btn btn-primary " type="button" id="registrar">Registrar</button>
                    <button class="btn btn-secondary" type="button" id="cancelar">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Alert Sweet -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        document.addEventListener("DOMContentLoaded", () => {

            const btnregistrar = document.querySelector("#registrar");
            const cancelar = document.querySelector("#cancelar");

            function registrar(){
                if(confirm("¿Está seguro de registrar?")){
                    const parametros = new URLSearchParams();
                    parametros.append("operacion","registrar");

                    //Enviar datos 
                    parametros.append("curso",document.querySelector("#curso").value);
                    parametros.append("creditos",document.querySelector("#creditos").value);
                    
                    
                    fetch("../controllers/curso.php",{
                        method: 'POST',
                        body: parametros
                    })
                    .then(respuesta => respuesta.json())
                    .then(datos =>{
                        if(datos.status){
                            Swal.fire({
                                icon: 'success',
                                title: 'Registrado Correctamente',
                                showConfirmButton: false,
                                timer: 1500
                            })
                            document.querySelector("#form-cursos").reset();
                            document.querySelector("#curso").focus();
                        }else{
                            Swal.fire({
                                icon: "error",
                                title: (datos.message),
                                showConfirmButton: false,
                                timer: 1500
                            })
                        }
                    });
                }
            }

            function Limpiarformulario(){
                document.querySelector("#form-cursos").reset();
                documentq.querySelector("#curso").focus();
            }
            // eventos
            btnregistrar.addEventListener("click",registrar);
            cancelar.addEventListener("click",Limpiarformulario);

        });
    </script>
    
 
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js" integrity="sha384-fbbOQedDUMZZ5KreZpsbe1LCZPVmfTnH7ois6mU1QK+m14rQ1l2bGBq41eYeM/fS" crossorigin="anonymous"></script>
</body>
</html>