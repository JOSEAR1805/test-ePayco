<?php

namespace Config;

use CodeIgniter\Validation\CreditCardRules;
use CodeIgniter\Validation\FileRules;
use CodeIgniter\Validation\FormatRules;
use CodeIgniter\Validation\Rules;

class Validation
{
	//--------------------------------------------------------------------
	// Setup
	//--------------------------------------------------------------------

	/**
	 * Stores the classes that contain the
	 * rules that are available.
	 *
	 * @var string[]
	 */
	public $ruleSets = [
		Rules::class,
		FormatRules::class,
		FileRules::class,
		CreditCardRules::class,
	];

	/**
	 * Specifies the views that are used to display the
	 * errors.
	 *
	 * @var array<string, string>
	 */
	public $templates = [
		'list'   => 'CodeIgniter\Validation\Views\list',
		'single' => 'CodeIgniter\Validation\Views\single',
	];

	public $user = [
		'name' => 'required|min_length[3]',
		'document' => 'required|min_length[6]',
		'email' => 'required|valid_email',
		'phone' => 'required|min_length[6]',
	];

	public $transaction = [
		'userId' => 'required',
		'type' => 'required',
		'status' => 'required',
		'quantity' => 'required',
	];

	public $payment = [
		'userId' => 'required',
	];

	//--------------------------------------------------------------------
	// Rules
	//--------------------------------------------------------------------
}
