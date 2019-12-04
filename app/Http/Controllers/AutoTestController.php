<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\AutoTest;

class AutoTestController extends Controller
{

    public function __construct()
    {
    }

    public function index()
    {
        $autotest_data = AutoTest::all();
        return view('autotest.index', ['autotest_data' => $autotest_data]);
    }

    public function save()
    {
        $input = request()->all();
        AutoTest::create([
            'number_a' => $input['number_a'],
            'number_b' => $input['number_b'],
        ]);
        return redirect()->route('autotest.index');
    }
}
