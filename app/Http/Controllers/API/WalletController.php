<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Wallet;
use App\Models\WalletTransaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class WalletController extends Controller
{

    public function index()
    {

        $wallet = Wallet::where('user_id',  Auth::id())->first();
        if (empty($wallet)) {
            $wallet = Wallet::create(
                ['user_id' =>  Auth::id()],
                ['balance' => 0.00]
            );
        }
        return $wallet;
    }

    public function topup(Request $request)
    {

        try {

            DB::beginTransaction();
            $wallet = $this->index();
            $walletTransaction = new WalletTransaction();
            $walletTransaction->amount = $request->amount;
            $walletTransaction->wallet_id = $wallet->id;
            $walletTransaction->is_credit = 1;
            $walletTransaction->ref = \Str::random(10);
            $walletTransaction->save();
            DB::commit();

            return response()->json([
                "message" => "",
                "link" => route('wallet.topup', ["code" => $walletTransaction->ref]),
            ]);
        } catch (\Exception $ex) {
            DB::rollback();
            return response()->json([
                "message" => $ex->getMessage()
            ], 400);
        }
    }
}
