<?php

//Llamamos el modelo de matricula(logica)
require_once '../models/estudiante.php';

//Si existe alguna operación en curso
if(isset($_POST['operacion'])){
  //Instancia de la clase Matricula
  $estudiante = new Estudiante();

  //Si la operación es listar
  if($_POST['operacion'] == 'listar'){
    //Ejecutamos el método y guardamos el resultado
    $datos = $estudiante->Listar();
    
    // if($datos){
    //   // echo json_encode($datos);
    //   foreach($datos as $registro){
    //     echo "
    //         <tr>
    //             <td>{$registro['idestudiante']}</td>
    //             <td>{$registro['nombres']}</td>
    //             <td>{$registro['carrera']}</td>
    //             <td>{$registro['curso']}</td>
    //             <td>{$registro['fechanac']}</td>
    //             <td>{$registro['telefono']}</td>
    //             <td>{$registro['correo']}</td>
    //             <td>{$registro['direccion']}</td>
    //             <td >
    //               <a href='#' class='eliminar btn btn-outline-danger btn-sm' data-idestudiante='{$registro['idestudiante']}'>Eliminar</a> 
    //               <a href='#' class='editar btn btn-outline-info btn-sm' data-bs-toggle='modal' data-bs-target='#modal-estudiantes' data-idestudiante ='{$registro['idestudiante']}'>Editar</a>
    //             </td>
    //         </tr>
    //     ";
    //   }
    // }
  }

  if($_POST['operacion'] == 'registrar'){
    $datosGuardar = [
        "nombres"            => $_POST['nombres'],
        "idcarrera"          => $_POST['idcarrera'],
        "idcurso"            => $_POST['idcurso'],
        "fechanac"           => $_POST['fechanac'],
        "telefono"           => $_POST['telefono'],
        "correo"             => $_POST['correo'],
        "direccion"          => $_POST['direccion']

    ];

    $respuesta = $estudiante->registrar($datosGuardar);
    echo json_encode($respuesta );
  }

  if($_POST['operacion'] == 'obtener'){
    $respuesta = $estudiante->obtener($_POST['idestudiante']);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'actualizar'){
    $datosActualizar = [
      "idestudiante"       => $_POST['idestudiante'],
      "nombres"            => $_POST['nombres'],
      "idcarrera"          => $_POST['idcarrera'],
      "idcurso"            => $_POST['idcurso'],
      "fechanac"           => $_POST['fechanac'],
      "telefono"           => $_POST['telefono'],
      "correo"             => $_POST['correo'],
      "direccion"          => $_POST['direccion']

    ];

    $respuesta = $estudiante->actualizar($datosActualizar);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'eliminar'){
    $respuesta = $estudiante->eliminar($_POST['idestudiante']);
    echo json_encode($respuesta);
  }

}