<?php

require_once 'conexion.php';

class Carrera extends Conexion{

  private $conexion;

  public function __CONSTRUCT(){
    $this->conexion = parent::getConexion();
  }

  public function Listar(){
    try{
      $consulta = $this->conexion->prepare("SELECT * FROM carreras");
      $consulta->execute();
      return $consulta->fetchAll(PDO::FETCH_NUM);
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function Listarcarr(){
    try{
      //Preparamos la consulta
      $consulta =  $this->conexion->prepare("CALL spu_listar_carreras()");
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

  public function Listardtc(){
    try{
      //Preparamos la consulta
      $consulta =  $this->conexion->prepare("CALL spu_listar_dtcarreras()");
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



  public function obtener($iddtcarrs = 0){
    try{
      $consulta = $this->conexion->prepare("CALL spu_obtener_dtcarreras(?)");
      $consulta->execute(array($iddtcarrs));
      return $consulta->fetch(PDO::FETCH_ASSOC);
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function obtenercar($idcarrera = 0){
    try{
      $consulta = $this->conexion->prepare("CALL spu_obtener_carreras(?)");
      $consulta->execute(array($idcarrera));
      return $consulta->fetch(PDO::FETCH_ASSOC);
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
      $consulta = $this->conexion->prepare("CALL spu_registrar_carreras(?,?,?)");
      $respuesta["status"] = $consulta->execute(
        array(
          $datos["carrera"],
          $datos["duracion"],
          $datos['costo']
        )
      );
    }
    catch(Exception $e){
      $respuesta["message"] = "No se ha podido completar el proceso. Código error: ". $e->getCode();
    }
    return $respuesta;
  }

  public function actualizar ($datos = []){
    $respuesta = [
      "status" => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_actualizar_dtcarreras(?,?,?)");
      $respuesta["status"] = $consulta->execute(
        array(
          $datos["iddtcarrs"],
          $datos["idcarrera"],
          // $datos["duracion"],
          // $datos["costo"],
          $datos["idcurso"]
          // $datos["creditos"]
        )
      );
    }
    catch(Exception $e){
      $respuesta["message"] = "No se ha podido completar el proceso. Código error: " . $e->getCode();
    }
    return $respuesta;
  }

  public function actualizarcar ($datos = []){
    $respuesta = [
      "status" => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_actualizar_carreras(?,?,?,?)");
      $respuesta["status"] = $consulta->execute(
        array(
          $datos["idcarrera"],
          $datos["carrera"],
          $datos["duracion"],
          $datos["costo"]
         
        )
      );
    }
    catch(Exception $e){
      $respuesta["message"] = "No se ha podido completar el proceso. Código error: " . $e->getCode();
    }
    return $respuesta;
  }

  public function eliminar($iddtcarrs = 0){
    $respuesta = [
      "status" => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_eliminar_dtcarreras(?)");
      $respuesta ["status"] = $consulta->execute(array($iddtcarrs));
    }
    catch(Exception $e){
      $respuesta["message"] = "No se ha podido completar el proceso. Código error: " . $e->getCode();
    }
    return $respuesta;
  }

  public function eliminarcar($idcarrera = 0){
    $respuesta = [
      "status" => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_eliminar_carreras(?)");
      $respuesta ["status"] = $consulta->execute(array($idcarrera));
    }
    catch(Exception $e){
      $respuesta["message"] = "No se ha podido completar el proceso. Código error: " . $e->getCode();
    }
    return $respuesta;
  }
}


