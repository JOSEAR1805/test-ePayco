<?php

namespace App\Models;

use CodeIgniter\Model;

class PaymentModel extends Model {
    protected $table      = 'payments';
    protected $primaryKey = 'id';

    protected $useAutoIncrement = true;

    protected $returnType     = 'array';
    protected $useSoftDeletes = false;

    protected $allowedFields = ['userId', 'code', 'status', 'quantity', 'note', 'payConfirmed'];

    protected $useTimestamps = true;
    protected $createdField  = 'createdAt';
    protected $updatedField  = 'updatedAt';
    // protected $deletedField  = 'deletedAt';

    protected $validationRules    = [];
    protected $validationMessages = [];
    protected $skipValidation     = false;
}