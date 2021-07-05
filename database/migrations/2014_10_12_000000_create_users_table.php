<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('code')->nullable()->unique();
            $table->string('name');
            $table->string('email')->unique();
            $table->string('phone')->unique();
            $table->decimal('commission', 8, 2)->nullable()->default(0.00);
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->foreignId('vendor_id')->nullable()->constrained();
            $table->boolean('is_active')->default(true);
            $table->boolean('is_online')->default(false);
            $table->foreignId('creator_id')->nullable();
            $table->rememberToken();
            $table->timestamps();
            $table->softDeletes();
        });

        //
        //creator_id
        if (!Schema::hasColumn('vendors', 'creator_id')) {
            Schema::table('vendors', function (Blueprint $table) {
                $table->foreignId('creator_id')->nullable()->constrained('users')->after('has_sub_categories');
            });
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
