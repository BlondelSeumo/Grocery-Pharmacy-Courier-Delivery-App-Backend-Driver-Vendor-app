<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateStateVendorPivotTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('state_vendor', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('state_id')->index();
            $table->foreign('state_id')->references('id')->on('states')->onDelete('cascade');
            $table->foreignId('vendor_id')->constrained();
            $table->boolean('is_active')->default(true);
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
        Schema::dropIfExists('state_vendor');
    }
}
