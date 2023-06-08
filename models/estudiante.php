<?php

// Importar la conexión
require_once 'conexion.php';

//la clase matricula heredara los metodos de la clase conexion
class Estudiante extends Conexion{

    //Almacena la conexión
    private $conexion;

    //Pasamo la conexión
    public function __CONSTRUCT(){
        $this->conexion = parent::getConexion();
    }

    public function Listar(){
      try{
        //Preparamos la consulta
        $consulta =  $this->conexion->prepare("CALL spu_listar_estudiantes()");
        //Ejecutamos la consulta
        $consulta->execute();
        //Presentaremos los datos obtenidos como ARRAY asociativo
        $tabla = $consulta->fetchAll(PDO::FETCH_ASSOC);
        // Retornamos los datos obtenidos
        return $tabla;
      }
      catch(Exception $e){
        die($e->getMessage());
      }
    }

    public function registrar($datos = []){
      $respuesta = [
        "status"  => false,
        "message" => ""
      ];
      try{
        $consulta = $this->conexion->prepare("CALL spu_registrar_estudiantes(?,?,?,?,?,?,?)");
        $respuesta["status"] = $consulta->execute(
          array(
            $datos["nombres"],
            $datos["idcarrera"],
            $datos["idcurso"],
            $datos["fechanac"],
            $datos["telefono"],
            $datos["correo"],
            $datos["direccion"]
          )
        );
      }
      catch(Exception $e){
        $respuesta["message"] = "No se ha podido completar el proceso. Código error: ". $e->getCode();
      }
      return $respuesta;
    }

    public function obtener($idestudiante = 0){
      try{
        $consulta = $this->conexion->prepare("CALL spu_obtener_estudiantes(?)");
        $consulta->execute(array($idestudiante));
        return $consulta->fetch(PDO::FETCH_ASSOC);
      }
      catch(Exception $e){
        die($e->getMessage());
      }
    }
  
    public function actualizar ($datos = []){
      $respuesta = [
        "status" => false,
        "message" => ""
      ];
      try{
        $consulta = $this->conexion->prepare("CALL spu_actualizar_estudiantes(?,?,?,?,?,?,?,?)");
        $respuesta["status"] = $consulta->execute(
          array(
            $datos["idestudiante"],
            $datos["nombres"],
            $datos["idcarrera"],
            $datos["idcurso"],
            $datos["fechanac"],
            $datos["telefono"],
            $datos["correo"],
            $datos["direccion"]
          )
        );
      }
      catch(Exception $e){
        $respuesta["message"] = "No se ha podido completar el proceso. Código error: " . $e->getCode();
      }
      return $respuesta;
    }
  
    public function eliminar($idestudiante = 0){
      $respuesta = [
        "status" => false,
        "message" => ""
      ];
      try{
        $consulta = $this->conexion->prepare("CALL spu_eliminar_estudiantes(?)");
        $respuesta ["status"] = $consulta->execute(array($idestudiante));
      }
      catch(Exception $e){
        $respuesta["message"] = "No se ha podido completar el proceso. Código error: " . $e->getCode();
      }
      return $respuesta;
    }
}