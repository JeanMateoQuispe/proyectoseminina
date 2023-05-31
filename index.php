<?php
session_start();

//Si el usario ya tiene una sesión activa ... entonces no debe estar aqui!!!
if(isset($_SESSION['seguridad'])){
  if($_SESSION['seguridad']['login']){
    header('Location:views/matricula.php');
  }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>

  <!--Bootstrap 5-->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

</head>
<body class="d-flex justify-content-center align-items-center vh-100">
 
    <style>
        .bold{
            font-weight: bold;
        }
    </style>
    
    <div class="bg-white p-5 rounded-5  text-secondary" style="width: 25rem; border-width: 1px; border-style: solid; border-color: black;">
        <div class="text-center fs-4 fw-bold">Iniciar Sesión</div>
        <div class="d-flex justify-content-center">
            <img src="image/images.png" alt="Logo" style="height: 50%;">
        </div class="">
        <div class="input-group mt-4 mb-3">
            <div class="input-group-text">
                <img src="https://img.icons8.com/ultraviolet/40/null/user.png" alt="logo" style="height: 1rem;"/>
            </div>
            <input class="form-control bg-light" type="email" placeholder="Usuario" id="email">
        </div>

        <div class="input-group mt-1">
            <div class="input-group-text">
                <img src="https://img.icons8.com/ultraviolet/40/null/password.png" alt="logo" style="height: 1rem;"/>
            </div>
            <input class="form-control bg-light" type="password" placeholder="Contraseña" id="password">
        </div>

        <div class="justify-content-around mt-1">
            <div class="d-flex align-items-center gap-2 form-check form-switch">
                <input class="form-check-input " type="checkbox" >
                <div class="pt-1"style="font-size: 0.9rem;">Recordar mi cuenta</div>
            </div>
            <div class="pt-1">
                <a href="#" class="text-decoration-none text-info fw-semibold fst-italic" style="font-size: 0.9rem;">¿Olvidaste tu contraseña?</a>
            </div>
        </div>
            <div class="">
                <button type="button" class="btn btn-success text-white w-100 mt-3" id="iniciar-sesion">Iniciar</button> 
            <div class="d-flex justify-content-center mt-1">
                <div style="margin-right: 0.50rem;">No tengo una cuenta</div>
                <a href="./views/registrarusuario.view.html" class="text-decoration-none text-info fw-semibold">Registrarse</a>
            </div>
            <div>
                <div class="p-3">
                    <div class="border-bottom text-center" style="height: 0.9rem";>
                        <span class="bg-light px-3">o</span>
                    </div>
                </div>
                <div class="btn d-flex gap-2 justify-content-center border mt-2">
                    <img src="assets/icons8-google.svg" alt="logo"  style="width: 1.6rem;">
                    <div class="fw-semibold">Continuar con Google</div>
                </div>
            </div>
        </div> 
    </div>
  <!--jquery-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

  <script>
    $(document).ready(function (){

      function login(){
        const datos= {
        "operacion"     : "iniciarSesion",
        "nombreusuario" : $("#email").val(),
        "clave"         : $("#password").val()
        };

        $.ajax({
        url: './controllers/usuario.controller.php',
        type: 'GET',
        data: datos,
        dataType: 'JSON',
        success: function (result){
            if (result.login){
            alert(`Bienvenido: ${result.nombres} ${result.apellidos} `);
            window.location.href = `./views/matricula.php`;
            }else{
            alert(result.mensaje);
            }
        }
        });
      }

      $("#iniciar-sesion").click(login);

      $("#password").keypress(function (evt){
        if(evt.keyCode == 13){
          login();
        }
      });

    });
  </script>
  
</body>
</html>