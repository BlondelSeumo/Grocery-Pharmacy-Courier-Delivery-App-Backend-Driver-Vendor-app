<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrdersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->string('code');
            $table->string('verification_code')->nullable();
            $table->string('note')->nullable();
            $table->string('reason')->nullable();
            $table->enum('status', ['scheduled','pending', 'preparing', 'ready', 'enroute', 'failed', 'cancelled', 'delivered'])->default('pending');
            $table->enum('payment_status', ['pending', 'review', 'failed', 'cancelled', 'successful'])->default('pending');
            //indicate if the order is for package delivery or regular delivery
            $table->enum('type', ['regular', 'package'])->default('regular');
            $table->double('sub_total', 8, 2)->default(0);
            $table->double('tip', 8, 2)->default(0);
            $table->double('discount', 8, 2)->default(0);
            $table->double('delivery_fee', 8, 2)->default(0);
            $table->double('commission', 8, 2)->default(0);
            $table->double('tax', 8, 2)->default(0);
            $table->double('total', 8, 2)->default(0);
            $table->foreignId('delivery_address_id')->nullable()->constrained();
            //start package delivery columns
            $table->string('recipient_name')->nullable();
            $table->string('recipient_phone')->nullable();
            $table->date('pickup_date')->nullable();
            $table->time('pickup_time')->nullable();
            $table->foreignId('package_type_id')->nullable()->constrained();
            $table->foreignId('pickup_location_id')->nullable()->constrained('delivery_addresses');
            $table->foreignId('dropoff_location_id')->nullable()->constrained('delivery_addresses');
            $table->double('weight', 10, 2)->default(0);
            $table->double('width', 10, 2)->default(0);
            $table->double('length', 10, 2)->default(0);
            $table->double('height', 10, 2)->default(0);
            //end package delivery columns


            $table->foreignId('payment_method_id')->constrained();
            $table->foreignId('vendor_id')->constrained();
            $table->foreignId('user_id')->constrained();
            $table->foreignId('driver_id')->nullable()->constrained( "users");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('orders');
    }
}
