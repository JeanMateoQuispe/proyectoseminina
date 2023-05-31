<?php
//Incorporamos el modelo (logica)
require_once '../models/matricula.model.php';

//si existe alguna operacion en curso
if(isset($_POST['operacion'])){
  //instaciamos la clase matricula
  $matricula = new Matricula();

  //si la operacion es listar
  if($_POST['operacion'] == 'listar'){
    //Ejecutamos el metodo y guardamos el resultado
    $datos = $matricula->listarMatriculas();

    if($datos){
      echo json_encode($datos);
    }
  }

  if($_POST['operacion'] == 'registrarmatricula'){
    $datosGuardar = [
      "alumno"            => $_POST['alumno'],
      "fechanac"          => $_POST['fechanac'],
      "numdoc"            => $_POST['numdoc'],
      "iddocente"         => $_POST['iddocente'],
      "idcarrera"         => $_POST['idcarrera'],
      "periodo"           => $_POST['periodo'],
      "semestre"          => $_POST['semestre'],
      "fechainicio"       => $_POST['fechainicio'],
      "fechafinal"        => $_POST['fechafinal'],
      "pago"              => $_POST['pago']
    ];

    $respuesta = $matricula->registrarMatriculas($datosGuardar);
    echo json_encode($respuesta );
  }

  if($_POST['operacion'] == 'obtener'){
    $respuesta = $matricula->obtener($_POST['idmatricula']);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'actualizar'){
    $datosActualizar = [
      "idmatricula"       => $_POST['idmatricula'],
      "alumno"            => $_POST['alumno'],
      "fechanac"          => $_POST['fechanac'],
      "numdoc"            => $_POST['numdoc'],
      "iddocente"         => $_POST['iddocente'],
      "idcarrera"         => $_POST['idcarrera'],
      "periodo"           => $_POST['periodo'],
      "semestre"          => $_POST['semestre'],
      "fechainicio"       => $_POST['fechainicio'],
      "fechafinal"        => $_POST['fechafinal'],
      "pago"              => $_POST['pago']
    ];

    $respuesta = $matricula->actualizar($datosActualizar);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'eliminar'){
    $respuesta = $matricula->eliminar($_POST['idmatricula']);
    echo json_encode($respuesta);
  }

}