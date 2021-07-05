<?php

namespace App\Traits;

use App\Models\PaymentMethod;
use App\Models\User;
use Symfony\Component\Process\Process;
use Symfony\Component\Process\Exception\ProcessFailedException;

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Artisan;
use Spatie\Permission\Models\Role;

trait SystemUpdateTrait
{

    public function runUpgradeAppSystemCommands()
    {
        //
        $appVersionCode = setting('appVerisonCode', "1");
        $appVerison = setting('appVerison', "1.0.0");


        if ($appVersionCode == 1) {

            $appVersionCode++;
            $appVerison = "1.0.0";
        }

        if ($appVersionCode == 2) {

            $appVersionCode++;
            $appVerison = "1.0.1";

            //drop category_id from products
            if (Schema::hasColumn('products', 'category_id')) {
                Schema::table('products', function (Blueprint $table) {
                    $table->dropColumn('category_id');
                });
            }
        }

        if ($appVersionCode == 3) {

            $appVersionCode++;
            $appVerison = "1.0.2";

            //migrate the user tokens
            if (!Schema::hasTable('user_tokens')) {
                Artisan::call('migrate --force');
            }
        }

        if ($appVersionCode == 4) {

            $appVersionCode++;
            $appVerison = "1.0.3";

            //migrate users
            if (!Schema::hasColumn('users', 'is_online')) {

                Schema::table('users', function (Blueprint $table) {
                    $table->boolean('is_online')->default(false)->after("is_active");
                });
            }

            //migrate reviews
            if (!Schema::hasColumn('reviews', 'order_id')) {

                //sorry
                // Review::whereNotNull('id')->delete();
                Schema::table('reviews', function (Blueprint $table) {
                    $table->dropForeign(['vendor_id']);
                    $table->dropColumn('vendor_id');
                });

                Schema::table('reviews', function (Blueprint $table) {
                    $table->foreignId('vendor_id')->constrained()->nullable();
                    $table->foreignId('order_id')->constrained()->nullable();
                });
            }
        }


        if ($appVersionCode == 5) {

            $appVersionCode++;
            $appVerison = "1.1.0";

            if (!Schema::hasTable('wallet_transactions')) {
                Artisan::call('migrate --force');
            }

            //wallet payment method
            $paymetnMethod = PaymentMethod::where('slug', "wallet")->first();
            if (empty($paymetnMethod)) {
                \DB::table('payment_methods')->insert(array(
                    0 =>
                    array(
                        'name' => 'Wallet',
                        'slug' => 'wallet',
                        'is_active' => 1,
                        'is_cash' => 1,
                        'created_at' => '2021-01-09 12:38:10',
                        'updated_at' => '2021-01-09 12:38:10',
                    ),
                ));
            }
        }

        if ($appVersionCode == 6) {

            $appVersionCode++;
            $appVerison = "1.1.1";

            if (!Schema::hasColumn('delivery_addresses', 'deleted_at')) {
                Schema::table('delivery_addresses', function (Blueprint $table) {
                    $table->softDeletes();
                });
            }
            if (!Schema::hasColumn('orders', 'verification_code')) {
                Schema::table('orders', function (Blueprint $table) {
                    $table->string('verification_code')->nullable()->after('code');
                });
            }
        }

        if ($appVersionCode == 7) {

            $appVersionCode++;
            $appVerison = "1.1.2";

            //
            \DB::statement("ALTER TABLE orders MODIFY COLUMN `status` ENUM('pending', 'preparing', 'ready', 'enroute', 'failed', 'cancelled', 'delivered') DEFAULT 'pending' ");

            if (!Schema::hasColumn('vendors', 'auto_assignment')) {
                Schema::table('vendors', function (Blueprint $table) {
                    $table->boolean('auto_assignment')->default(true)->after('is_package_vendor');
                });
            }
        }

        //
        if ($appVersionCode == 8) {

            $appVersionCode++;
            $appVerison = "1.2.0";


            if (!Schema::hasColumn('orders', 'reason')) {
                Schema::table('orders', function (Blueprint $table) {
                    $table->string('reason')->nullable()->after('note');
                });
            }

            if (!Schema::hasColumn('package_type_pricings', 'auto_assignment')) {
                Schema::table('package_type_pricings', function (Blueprint $table) {
                    $table->boolean('auto_assignment')->default(false)->after('is_active');
                });
            }

            if (!Schema::hasColumn('package_type_pricings', 'base_price')) {
                Schema::table('package_type_pricings', function (Blueprint $table) {
                    $table->double('base_price', 8, 2)->default(0.00)->after('distance_price');
                });
            }

            if (!Schema::hasColumn('users', 'code')) {
                Schema::table('users', function (Blueprint $table) {
                    $table->string('code')->nullable()->unique()->after('id');
                });

                //adding code for registered users
                $users = User::all();
                foreach ($users as $user) {
                    $user->code = \Str::random(3) . "" . $user->id . "" . \Str::random(2);
                    $user->save();
                }
            }

            if (!Schema::hasTable('category_product')) {
                Artisan::call('migrate --force');
            }

            if (!Schema::hasTable('days')) {
                Artisan::call('migrate --force');
            }
        }

        //
        if ($appVersionCode == 9 || $appVerison == "1.2.1") {

            $appVersionCode = 10;
            $appVerison = "1.2.1";
            $tables = \DB::select('SHOW TABLES');
            foreach ($tables as $table) {
                foreach ($table as $key => $value)
                    if (Schema::hasColumn($value, 'created_at') && !Schema::hasColumn($value, 'deleted_at')) {
                        logger("Table Name", [$value]);
                        Schema::table($value, function (Blueprint $table) {
                            $table->softDeletes();
                        });
                    }
            }

            //offline payment
            if (!Schema::hasColumn('payment_methods', 'instruction')) {

                Schema::table("payment_methods", function (Blueprint $table) {
                    $table->text('instruction')->nullable()->after('slug');
                });
            }

            //
            $paymetnMethod = PaymentMethod::where('slug', "offline")->first();
            if (empty($paymetnMethod)) {
                \DB::table('payment_methods')->insert(array(
                    0 =>
                    array(
                        'name' => 'Offline Payment',
                        'slug' => 'offline',
                        'secret_key' => '',
                        'public_key' => '',
                        'hash_key' => '',
                        'is_active' => 1,
                        'is_cash' => 0,
                        'created_at' => '2021-01-09 12:38:10',
                        'updated_at' => '2021-01-09 12:38:10',
                    ),
                ));
            }

            //adding Billplz payment
            $paymetnMethod = PaymentMethod::where('slug', "billplz")->first();
            if (empty($paymetnMethod)) {
                \DB::table('payment_methods')->insert(array(
                    0 =>
                    array(
                        'name' => 'Billplz',
                        'slug' => 'billplz',
                        'secret_key' => '4e8389bd-f801-45ad-9da5-8f49b2eab1d2',
                        'public_key' => '',
                        'hash_key' => '',
                        'is_active' => 1,
                        'is_cash' => 0,
                        'created_at' => '2021-01-09 12:38:10',
                        'updated_at' => '2021-01-09 12:38:10',
                    ),
                ));
            }

            //add review to payment status
            \DB::statement("ALTER TABLE payments MODIFY COLUMN `status` ENUM('pending', 'failed', 'review', 'successful') DEFAULT 'pending' NOT NULL");
            \DB::statement("ALTER TABLE wallet_transactions MODIFY COLUMN `status` ENUM('pending', 'failed', 'review', 'successful') DEFAULT 'pending' NOT NULL");
            \DB::statement("ALTER TABLE orders MODIFY COLUMN `payment_status` ENUM('pending', 'review', 'failed', 'cancelled', 'successful') DEFAULT 'pending'  NOT NULL");
            //add scheduled to status
            \DB::statement("ALTER TABLE orders MODIFY COLUMN `status` ENUM('scheduled','pending', 'preparing', 'ready', 'enroute', 'failed', 'cancelled', 'delivered') DEFAULT 'pending'  NOT NULL");


            //making filed optional
            if (!Schema::hasColumn('package_type_pricings', 'field_required')) {

                Schema::table("package_type_pricings", function (Blueprint $table) {
                    $table->boolean('field_required')->default(false)->after('auto_assignment');
                });
            }

            //making filed optional
            if (!Schema::hasColumn('vendors', 'base_delivery_fee')) {

                Schema::table("vendors", function (Blueprint $table) {
                    $table->double('base_delivery_fee', 8, 2)->default(0)->after('description');
                });
            }
        }

        //
        if ($appVersionCode == 10) {

            $appVersionCode++;
            $appVerison = "1.2.2";

            //adding abitmedia payment
            $paymetnMethod = PaymentMethod::where('slug', "abitmedia")->first();
            if (empty($paymetnMethod)) {
                \DB::table('payment_methods')->insert(array(
                    0 =>
                    array(
                        'name' => 'Abitmedia Cloud',
                        'slug' => 'abitmedia',
                        'instruction' => NULL,
                        'secret_key' => '2y-13-tx-zsjtggeehkmygjbtsf-51z5-armmnw-ihbuspjufwubv4vxok6ery7wozao3wmggnxjgyg',
                        'public_key' => NULL,
                        'hash_key' => NULL,
                        'is_active' => 1,
                        'is_cash' => 0,
                        'created_at' => '2021-01-09 12:38:10',
                        'updated_at' => '2021-01-09 12:38:10',
                        'deleted_at' => NULL,
                    ),
                ));
            }

            //
            if (!Schema::hasColumn('vendors', 'allow_schedule_order')) {
                Schema::table('vendors', function (Blueprint $table) {
                    $table->boolean('allow_schedule_order')->default(false)->after('auto_assignment');
                });
            }

            //
            if (!Schema::hasColumn('reviews', 'driver_id')) {
                Schema::table('reviews', function (Blueprint $table) {
                    $table->foreignId('driver_id')->constrained("users")->nullable()->after('vendor_id');
                });
            }

            //vendors has_sub_categories
            if (!Schema::hasColumn('vendors', 'has_sub_categories')) {
                Schema::table('vendors', function (Blueprint $table) {
                    $table->boolean('has_sub_categories')->default(false)->after('allow_schedule_order');
                });
            }

            //vendors creator_id
            if (!Schema::hasColumn('vendors', 'creator_id')) {
                Schema::table('vendors', function (Blueprint $table) {
                    $table->foreignId('creator_id')->nullable()->constrained('users')->after('has_sub_categories');
                });
            }
            //coupons creator_id
            if (!Schema::hasColumn('coupons', 'creator_id')) {
                Schema::table('coupons', function (Blueprint $table) {
                    $table->foreignId('creator_id')->nullable()->constrained('users')->after('is_active');
                });
            }

            //users creator_id
            if (!Schema::hasColumn('users', 'creator_id')) {
                Schema::table('users', function (Blueprint $table) {
                    $table->foreignId('creator_id')->nullable()->after('is_active');
                });
            }

            //delivery_addresses state & country
            if (!Schema::hasColumn('delivery_addresses', 'state')) {
                Schema::table('delivery_addresses', function (Blueprint $table) {
                    $table->string('state')->nullable()->after('city');
                    $table->string('country')->nullable()->after('state');
                });
            }

            //
            if (!Schema::hasTable('order_stops') || !Schema::hasTable('subcategories') || !Schema::hasTable('product_sub_category')) {
                Artisan::call('migrate --force');
            }

            //city admin role
            $cityAdminRole = Role::where('name', 'city-admin')->first();
            if (empty($cityAdminRole)) {
                \DB::table('roles')->insert(array(
                    0 =>
                    array(
                        'id' => 5,
                        'name' => 'city-admin',
                        'guard_name' => 'web',
                        'created_at' => '2020-12-28 11:57:58',
                        'updated_at' => '2020-12-28 11:57:58',
                        'deleted_at' => NULL,
                    ),
                ));
            }
        }

        //
         if ($appVersionCode == 11) {

            $appVersionCode++;
            $appVerison = "1.2.3";

            //adding abitmedia payment
            $paymetnMethod = PaymentMethod::where('slug', "paypal")->first();
            if (empty($paymetnMethod)) {
                \DB::table('payment_methods')->insert(array(
                    0 =>
                    array(
                        'name' => 'Paypal',
                        'slug' => 'paypal',
                        'instruction' => NULL,
                        'secret_key' => NULL,
                        'public_key' => NULL,
                        'hash_key' => NULL,
                        'is_active' => 1,
                        'is_cash' => 0,
                        'created_at' => '2021-01-09 12:38:10',
                        'updated_at' => '2021-01-09 12:38:10',
                        'deleted_at' => NULL,
                    ),
                ));
            }
         
            //orders
            if (!Schema::hasColumn('orders', 'tip')) {
                Schema::table('orders', function (Blueprint $table) {
                    $table->double('tip', 8, 2)->default(0)->after('sub_total');
                });
            }

            //vendor payment methods
            if (!Schema::hasTable('payment_method_vendor')) {
                Artisan::call('migrate --force');
            }

           
        }

        setting([
            'appVerisonCode' =>  $appVersionCode,
            'appVerison' =>  $appVerison,
        ])->save();
    }

    public function systemTerminalRun($command)
    {

        $commandArray = explode(" ", $command);
        $composerInstall = new Process($commandArray);
        $composerInstall->setWorkingDirectory(base_path());
        $composerInstall->run();

        if (!$composerInstall->isSuccessful()) {
            throw new ProcessFailedException($composerInstall);
        }
    }


    public function extractUpdateFiles($filePath, $fileName, $oraginalFileName)
    {

        logger("Upgrade", [$fileName, $filePath, $oraginalFileName]);
        $extractPath = base_path();
        $commandArray = explode(" ", "unzip " . $fileName . " -d " . $extractPath . "");
        $composerInstall = new Process($commandArray);
        $composerInstall->setWorkingDirectory($filePath);
        $composerInstall->run();

        if (!$composerInstall->isSuccessful()) {
            throw new ProcessFailedException($composerInstall);
        }

        //
        $commandArray = explode(" ", "mkdir NewFolder");
        $composerInstall = new Process($commandArray);
        $composerInstall->setWorkingDirectory($extractPath);
        $composerInstall->run();

        if (!$composerInstall->isSuccessful()) {
            throw new ProcessFailedException($composerInstall);
        }

        $extractPath = base_path() . "/'Update Owners'";
        $distinationPath = base_path() . "/NewFolder";
        $commandArray = explode(" ", "cp -r * " . $distinationPath . "");
        $composerInstall = new Process($commandArray);
        $composerInstall->setWorkingDirectory($extractPath);
        $composerInstall->run();

        if (!$composerInstall->isSuccessful()) {
            throw new ProcessFailedException($composerInstall);
        }
    }
}
