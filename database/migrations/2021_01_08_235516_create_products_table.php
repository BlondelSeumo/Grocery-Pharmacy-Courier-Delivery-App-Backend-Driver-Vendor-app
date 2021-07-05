<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->text('description')->nullable();
            $table->double('price', 8, 2);
            $table->double('discount_price', 8, 2)->default(0);
            $table->string('capacity')->default("1");
            $table->string('unit')->default("kg");
            $table->string('package_count')->nullable();
            $table->integer('available_qty')->nullable();
            $table->boolean('featured')->default(false);
            $table->boolean('deliverable')->default(true);
            $table->boolean('is_active')->default(true);
            $table->foreignId('vendor_id')->constrained();
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
        Schema::dropIfExists('products');
    }
}
