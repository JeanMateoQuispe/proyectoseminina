<?php

require_once '../models/docente.model.php';

if (isset($_POST['operacion'])){

  $docente = new Docente();

  if ($_POST['operacion'] == 'listar'){
    $datos = $docente->listarDocentes();

    if($datos){
      echo json_encode($datos);
    }
  }

  //si la operacion es listar
  if($_POST['operacion'] == 'listardocentes'){
    //Ejecutamos el metodo y guardamos el resultado
    $datos = $docente->listarDocen();

    if($datos){
      echo json_encode($datos);
    }
  }

  if($_POST['operacion'] == 'registrardocente'){
    $datosGuardar = [
      "docente"            => $_POST['docente'],
      "fechanac"           => $_POST['fechanac'],
      "numdoc"             => $_POST['numdoc'],
      "especialidad"       => $_POST['especialidad'],
      "idcurso"            => $_POST['idcurso'],
      "idcarrera"          => $_POST['idcarrera']
    ];

    $respuesta = $docente->registrarDocente($datosGuardar);
    echo json_encode($respuesta );
  }

  if($_POST['operacion'] == 'obtenerdocente'){
    $respuesta = $docente->obtenerdocente($_POST['iddocente']);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'actualizardocente'){
    $datosActualizar = [
      "iddocente"          => $_POST['iddocente'],
      "docente"            => $_POST['docente'],
      "fechanac"           => $_POST['fechanac'],
      "numdoc"             => $_POST['numdoc'],
      "especialidad"       => $_POST['especialidad'],
      "idcurso"            => $_POST['idcurso'],
      "idcarrera"          => $_POST['idcarrera']
    ];

    $respuesta = $docente->actualizardocente($datosActualizar);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'eliminardocente'){
    $respuesta = $docente->eliminardocente($_POST['iddocente']);
    echo json_encode($respuesta);
  }

}
