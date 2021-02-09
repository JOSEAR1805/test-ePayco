<?php

namespace App\Controllers;

use App\Models\PaymentModel;
use App\Models\UserModel;
use App\Models\TransactionModel;

use CodeIgniter\RESTful\ResourceController;

class RestPayment extends ResourceController {
    protected $modelName = 'App\Models\PaymentModel';
    protected $format    = 'json';

    public function pay() {
      $paymentModel = new PaymentModel();
      $userModel = new UserModel();
      $transaction = new TransactionModel();
      $db = \Config\Database::connect();
      $email = \Config\Services::email();

      $json = $this->request->getJSON();
      $code = substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, 6);

      if ($json->{'document'} && $json->{'phone'} && $json->{'quantity'}) { 
        $user = $userModel->where('document', $json->{'document'})->where('phone', $json->{'phone'})->first();

        if (empty($json->{'code'})) {
          if ($user) {
            $ingreso = $db->query("SELECT SUM(quantity) as ingreso FROM transactions WHERE type= 1 AND userId = " . intval($user['id']) . ";")->getRow()->ingreso;
            $egreso = $db->query("SELECT SUM(quantity) as egreso FROM transactions WHERE type= 2 AND userId = " . intval($user['id']) . ";")->getRow()->egreso;
            $disponible = $ingreso - $egreso; 

            if ($disponible >=  $json->{'quantity'}) {

              $result = $paymentModel->insert([
                'userId' => intval($user['id']),
                'code' => $code,
                'status' => 0,
                'quantity' => $json->{'quantity'},
              ]);
              
              if ($result) {
                $email->setFrom('admin@monedero.com');
                $email->setTo($user['email']);
                $email->setSubject('Codígo de Confirmación de Pago');
                $email->setMessage('El codigo para confiramr su pago es: <strong>' . $code . '</strong>');
                $rs = $email->send();
                
                if ($rs) {
                  return $this->respond(array( 
                    "data" => $this->model->find($result),
                    "data2" => $rs,
                    "message" => "Codigo de Confirmación enviado con exito!",
                    "code" => 200
                  ));
                } else {
                  return $this->respond(array(
                    "message" => "No se ha podido enviar el código de confirmación!",
                    "code" => 500
                  ));
                }
    
              } else {
                return $this->respond(array(
                  "message" => "Ha ocurrido un error!",
                  "code" => 500
                ));
              }

            } else {

              return $this->respond(array(
                "message" => "Disculpe pero no posee suficiente saldo positivo para concretar la compra!",
                "code" => 500
              ));

            }
            
          } else {
            return $this->respond(array(
              "message" => "No existe Cliente con los parametros ingresados!",
              "code" => 500
            ));
          }
        } else {
          if ($user) {
            $payment = $paymentModel->where('userId', intval($user['id']))->where('code', $json->{'code'})->where('status', 0)->first();
            
            if ($payment) {
              $result = $transaction->insert([
                'userId' => intval($user['id']),
                'type' => 2,
                'status' => 1,
                'quantity' => $payment['quantity'],
                ]);
                
              if ($result) {
                $paymentModel->update(intval($payment['id']), ['status' => 1]);
                return $this->respond(array( 
                  "message" => "Pago realizado con exito!",
                  "code" => 200
                ));
              } else {
                $paymentModel->update(intval($payment['id']), ['status' => 2]);
                return $this->respond(array(
                  "message" => "Ha ocurrido un error!",
                  "code" => 500
                ));
              }
  
            } else {
              return $this->respond(array(
                "message" => "Codigo ingresado es erroneo!",
                "code" => 500
              ));
            }
            
          } else {
            return $this->respond(array(
              "message" => "No existe Cliente con los parametros ingresados!",
              "code" => 500
            ));
          }
        }
        
      } else {
        return $this->respond(array(
          "message" => "Por favor rellenar campos requeridos!",
          "code" => 500
        ));
      }

    }

    

}