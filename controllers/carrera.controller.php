<?php

require_once '../models/carrera.model.php';

if (isset($_POST['operacion'])){

  $carrera = new Carrera();

  if ($_POST['operacion'] == 'listar'){
    $datos = $carrera->listarCarreras();

    if($datos){
      echo json_encode($datos);
    }
  }

  if($_POST['operacion'] == 'listarcarrera'){
    //Ejecutamos el metodo y guardamos el resultado
    $datos = $carrera->listarCarrera();

    if($datos){
      echo json_encode($datos);
    }
  }

  if($_POST['operacion'] == 'registrarcarrera'){
    $datosGuardar = [
      "idcurso"          => $_POST['idcurso'],
      "nombrecarrera"    => $_POST['nombrecarrera'],
      "duracion"         => $_POST['duracion']
    ];

    $respuesta = $carrera->registrarCarrera($datosGuardar);
    echo json_encode($respuesta );
  }

  if($_POST['operacion'] == 'obtenercarrera'){
    $respuesta = $carrera->obtenerCarrera($_POST['idcarrera']);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'actualizarcarrera'){
    $datosActualizar = [
      "idcarrera"          => $_POST['idcarrera'],
      "idcurso"            => $_POST['idcurso'],
      "nombrecarrera"      => $_POST['nombrecarrera'],
      "duracion"           => $_POST['duracion']
    ];

    $respuesta = $carrera->actualizarCarrera($datosActualizar);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'eliminarcarrera'){
    $respuesta = $curso->eliminarCarrera($_POST['idcarrera']);
    echo json_encode($respuesta);
  }
}
