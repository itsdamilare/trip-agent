<?php

use App\Http\Controllers\TravelController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
 */

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Auth::routes();
// get all bookings
Route::get('bookings', [TravelController::class, 'getBookings'])->middleware('auth');

//get specific bookings
Route::get('bookings/{id}', [TravelController::class, 'getSpecificBooking'])->middleware('auth');

// create a booking
Route::post('bookings', [TravelController::class, 'createBooking'])->middleware('auth');

// edit a booking
Route::put('bookings/{id}', [TravelController::class, 'editBooking'])->middleware('auth');

// delete a booking
Route::delete('bookings/{id}', [TravelController::class, 'deleteBooking'])->middleware('auth');

Route::get('packages', [TravelController::class, 'getPackages'])->middleware('auth');
Route::get('packages/{id}', [TravelController::class, 'getPackage'])->middleware('auth');
