<?php

require_once '../models/docente.php';

if(isset($_POST['operacion'])){
    $docente = new Docente();

    if ($_POST['operacion'] == 'listar'){
        $datos = $docente->Listar();

        if($datos){
            echo json_encode($datos);
        }
    }

    if($_POST['operacion'] == 'listardocen'){
    //Ejecutamos el método y guardamos el resultado
    $datos = $docente->ListarDocen();
        if($datos){
            // echo json_encode($datos);
            foreach($datos as $registro){
                echo "
                    <tr>
                        <td>{$registro['iddocente']}</td>
                        <td>{$registro['nombres']}</td>
                        <td>{$registro['fechanac']}</td>
                        <td>{$registro['telefono']}</td>
                        <td>{$registro['correo']}</td>
                        <td>{$registro['especialidad']}</td>
                        <td >
                            <a href='#' class='eliminar btn btn-outline-danger btn-sm' data-iddocente='{$registro['iddocente']}'>Eliminar</a> 
                            <a href='#' class='editar btn btn-outline-info btn-sm' data-bs-toggle='modal' data-bs-target='#modal-docentes' data-iddocente='{$registro['iddocente']}'>Editar</a>
                        </td>
                    </tr>
                ";
            }
        }
    }

    if($_POST['operacion'] == 'registrar'){
        $datosGuardar = [
          "nombres"         => $_POST['nombres'],
          "numdoc"          => $_POST['numdoc'],
          "fechanac"        => $_POST['fechanac'],
          "telefono"        => $_POST['telefono'],
          "correo"          => $_POST['correo'],
          "direccion"       => $_POST['direccion'],
          "especialidad"    => $_POST['especialidad']
        ];
    
        $respuesta = $docente->registrar($datosGuardar);
        echo json_encode($respuesta );
    }

    if($_POST['operacion'] == 'obtener'){
        $respuesta = $docente->obtener($_POST['iddocente']);
        echo json_encode($respuesta);
    }
    
    if($_POST['operacion'] == 'actualizar'){
    $datosActualizar = [
        "iddocente"       => $_POST['iddocente'],
        "nombres"         => $_POST['nombres'],
        "numdoc"          => $_POST['numdoc'],
        "fechanac"        => $_POST['fechanac'],
        "telefono"        => $_POST['telefono'],
        "correo"          => $_POST['correo'],
        "direccion"       => $_POST['direccion'],
        "especialidad"    => $_POST['especialidad']
    ];

    $respuesta = $docente->actualizar($datosActualizar);
    echo json_encode($respuesta);
    }

    if($_POST['operacion'] == 'eliminar'){
        $respuesta = $docente->eliminar($_POST['iddocente']);
        echo json_encode($respuesta);
    }
}