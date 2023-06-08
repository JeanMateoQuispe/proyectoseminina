<?php

// Conexion a la db
class Conexion {
    private function Conectar(){
        try{
            $pdo = new PDO("mysql:host=localhost;port=3306;dbname=db_matriculas;charset=UTF8","root","");
            return $pdo;
        }
        catch(Exception $e){
            die($e->getMessage());
        }
    }

    // En este metódo se utilizará el modelo
    public function getConexion(){
        try{
            $pdo = $this->Conectar();
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $pdo;
        }
        catch(Exception $e){
            die($e->getMessage());
        }
    }
}