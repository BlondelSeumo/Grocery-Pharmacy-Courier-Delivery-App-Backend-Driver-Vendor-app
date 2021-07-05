<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrderStopsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('order_stops', function (Blueprint $table) {
            $table->id();
            $table->double('price', 8, 2)->default(0);
            $table->foreignId('order_id')->constrained();
            $table->foreignId('stop_id')->nullable()->constrained('delivery_addresses');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('order_stops');
    }
}
