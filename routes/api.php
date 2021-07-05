<?php

use App\Http\Controllers\API\AppSettingsController;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\CategoryController;
use App\Http\Controllers\API\BannerController;
use App\Http\Controllers\API\FavouriteController;
use App\Http\Controllers\API\ProductController;
use App\Http\Controllers\API\VendorController;
use App\Http\Controllers\API\CouponController;
use App\Http\Controllers\API\SearchController;
use App\Http\Controllers\API\DeliveryAddressController;
use App\Http\Controllers\API\PaymentMethodController;
use App\Http\Controllers\API\OrderController;
use App\Http\Controllers\API\PackageOrderController;
use App\Http\Controllers\API\PackageTypeController;
use App\Http\Controllers\API\ChatNotificationController;
use App\Http\Controllers\API\RatingController;
use App\Http\Controllers\API\EarningController;
use App\Http\Controllers\API\UserController;
use App\Http\Controllers\API\WalletController;
use App\Http\Controllers\API\OrderPaymentCallbackController;
use App\Http\Controllers\API\VendorPackageTypePricingController;
use Illuminate\Support\Facades\Route;

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

//App settings
Route::get('/app/settings', [AppSettingsController::class, 'index']);


// Auth
Route::post('login', [AuthController::class, 'login']);
Route::post('register', [AuthController::class, 'register']);
Route::get('logout', function () {
    Auth::logout();
    return response()->json([
        "message" => "Logout successful"
    ]);
});

Route::get('verify/phone', [AuthController::class, 'verifyPhoneAccount']);
Route::post('password/reset/init', [AuthController::class, 'passwordReset']);
// Route::get('password/update/{code}/{email}', PasswordResetLivewire::class)->name('password.reset.link');

Route::get('categories', [CategoryController::class, "index"]);
Route::get('banners', [BannerController::class, "index"]);
Route::apiResource('products', ProductController::class);
Route::apiResource('vendors', VendorController::class);
Route::get('coupons/{code}', [CouponController::class, 'show']);
Route::get('search', [SearchController::class, 'index']);

//package delivery
Route::get('package/types', [PackageTypeController::class, 'index']);
//
Route::post('order/payment/callback', [OrderPaymentCallbackController::class, 'order'])->name('api.payment.callback');
Route::post('wallet/topup/callback', [OrderPaymentCallbackController::class, 'wallet'])->name('api.wallet.topup.callback');

Route::group(['middleware' => ['auth:sanctum']], function () {

    Route::apiResource('favourites', FavouriteController::class);
    Route::put('profile/update', [AuthController::class, 'profileUpdate']);
    Route::put('profile/password/update', [AuthController::class, 'changePassword']);
    Route::apiResource('delivery/addresses', DeliveryAddressController::class);
    Route::apiResource('payment/methods', PaymentMethodController::class)->only('index');
    Route::apiResource('orders', OrderController::class)->only('index', 'store', 'show', 'update');
    Route::apiResource('rating', RatingController::class)->only('store');
    //package delivery
    Route::get('package/order/summary', [PackageOrderController::class, 'summary']);
    //
    Route::post('chat/notification', [ChatNotificationController::class, 'send']);

    //earning
    Route::get('earning/user', [EarningController::class, 'user']);
    Route::get('earning/vendor', [EarningController::class, 'vendor']);
    Route::get('users', [UserController::class, 'index']);
    Route::get('vendor/{id}/details', [VendorController::class, 'fullDeatils']);

    //wallets
    Route::get('wallet/balance', [WalletController::class, 'index']);
    Route::post('wallet/topup', [WalletController::class, 'topup']);

    //
    Route::group(['middleware' => ['role:manager']], function () {
            
        Route::apiResource('/vendor/package/pricing', VendorPackageTypePricingController::class);

    });
});
