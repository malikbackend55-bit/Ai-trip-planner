<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\TripController;
use App\Http\Controllers\Api\ChatController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/trips/generate', [TripController::class, 'generate']);
    Route::apiResource('trips', TripController::class);
    Route::post('/chat', [ChatController::class, 'sendMessage']);
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
});
