<?php

require_once '../models/carrera.php';

if (isset($_POST['operacion'])){

  $carrera = new Carrera();

  if ($_POST['operacion'] == 'listar'){
    $datos = $carrera->Listar();

    if($datos){
      echo json_encode($datos);
    }
  }

  if($_POST['operacion'] == 'listardtc'){
    //Ejecutamos el método y guardamos el resultado
    $datos = $carrera->Listardtc();
    if($datos){
      // echo json_encode($datos);
      foreach($datos as $registro){
        echo "
            <tr>
                <td>{$registro['iddtcarrs']}</td>
                <td>{$registro['carrera']}</td>
                <td>{$registro['duracion']}</td>
                <td>{$registro['costo']}</td>
                <td>{$registro['curso']}</td>
                <td>{$registro['creditos']}</td>
                <td >
                  <a href='#' class='eliminar btn btn-outline-danger btn-sm' data-iddtcarrs='{$registro['iddtcarrs']}'>Eliminar</a> 
                  <a href='#' class='editar btn btn-outline-info btn-sm' data-bs-toggle='modal' data-bs-target='#md-dtcarreras' data-iddtcarrs ='{$registro['iddtcarrs']}'>Editar</a>
                </td>
            </tr>
        ";
      }
    }
  }

  // if($_POST['operacion'] == 'listarcar'){
  //   //Ejecutamos el método y guardamos el resultado
  //   $datos = $carrera->Listarcarr();
  //   if($datos){
  //     // echo json_encode($datos);
  //     foreach($datos as $registro){
  //       echo "
  //           <tr>
  //               <td>{$registro['idcarrera']}</td>
  //               <td>{$registro['carrera']}</td>
  //               <td>{$registro['duracion']}</td>
  //               <td>{$registro['costo']}</td>
                
  //               <td >
  //                 <a href='#' class='eliminar btn btn-outline-danger btn-sm' data-idcarrera='{$registro['idcarrera']}'>Eliminar</a> 
  //                 <a href='#' class='editar btn btn-outline-info btn-sm' data-bs-toggle='modal' data-bs-target='#md-carreras' data-idcarrera ='{$registro['idcarrera']}'>Editar</a>
  //               </td>
  //           </tr>
  //       ";
  //     }
  //   }
  // }

  if($_POST['operacion'] == 'listarcar'){
    //Ejecutamos el metodo y guardamos el resultado
    $datos = $carrera->Listarcarr();

    if($datos){
      echo json_encode($datos);
    }
  }

  if($_POST['operacion'] == 'registrar'){
    $datosGuardar = [
      "carrera"     => $_POST['carrera'],
      "duracion"    => $_POST['duracion'],
      "costo"       => $_POST['costo']
    ];

    $respuesta = $carrera->registrar($datosGuardar);
    echo json_encode($respuesta );
  }

  if($_POST['operacion'] == 'obtener'){
    $respuesta = $carrera->obtener($_POST['iddtcarrs']);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'obtenercar'){
    $respuesta = $carrera->obtenercar($_POST['idcarrera']);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'actualizar'){
    $datosActualizar = [
      "iddtcarrs"       => $_POST['iddtcarrs'],
      "idcarrera"       => $_POST['idcarrera'],
      "idcurso"         => $_POST['idcurso']

    ];

    $respuesta = $carrera->actualizar($datosActualizar);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'actualizarcar'){
    $datosActualizar = [
      "idcarrera"       => $_POST['idcarrera'],
      "carrera"         => $_POST['carrera'],
      "duracion"        => $_POST['duracion'],
      "costo"           => $_POST['costo']
  

    ];

    $respuesta = $carrera->actualizarcar($datosActualizar);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'eliminar'){
    $respuesta = $carrera->eliminar($_POST['iddtcarrs']);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'eliminarcar'){
    $respuesta = $carrera->eliminarcar($_POST['idcarrera']);
    echo json_encode($respuesta);
  }

}

