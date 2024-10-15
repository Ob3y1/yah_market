<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ShopController;
use App\Http\Controllers\AdminController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);
Route::post('/admin/login', [AuthController::class, 'loginAsAdmin']);

Route::middleware('auth:api')->group(function () {
    Route::get('/logout', [AuthController::class, 'logout']);
    Route::get('/user', [AuthController::class, 'user']);
    Route::put('/user', [AuthController::class, 'update']);
    Route::get('categories', [ShopController::class, 'getCategories']);
    Route::get('categories/{id}/products', [ShopController::class, 'getProductsByCategory']);
    Route::get('products/{id}', [ShopController::class, 'getProductDetails']);
    Route::post('basket/add', [ShopController::class, 'addToBasket']);
    Route::get('basket', [ShopController::class, 'getBasket']);
    Route::delete('basket/remove/{productId}', [ShopController::class, 'removeFromBasket']);
    Route::post('basket/clear', [ShopController::class, 'clearBasket']);
});
// Route::middleware('auth:api', 'admin')->group(function () {
//     Route::post('/admin/categories', [AdminController::class, 'addCategory']);
//     Route::put('/admin/categories/{id}', [AdminController::class, 'updateCategory']);
//     Route::delete('/admin/categories/{id}', [AdminController::class, 'deleteCategory']);
//     Route::post('/admin/products', [AdminController::class, 'addProduct']);
//     Route::put('/admin/products/{id}', [AdminController::class, 'updateProduct']);
//     Route::delete('/admin/products/{id}', [AdminController::class, 'deleteProduct']); 
//     Route::get('/admin/statistics', [AdminController::class, 'getStatistics']);
// });
