<?php

namespace App\Console\Commands;

use App\Models\Order;
use Illuminate\Console\Command;
use Carbon\Carbon;

class DispatchOrder extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'order:dispatch';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Dispatch order when the time is right';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        //
        $today = Carbon::today();
        $hoursFromNow = Carbon::now()->addHours(setting('minScheduledTime', 2))->toTimeString();

        //get orders scheduled for today with the next 2hours
        Order::where('status', 'scheduled')
            ->whereDate('pickup_date', $today)
            ->whereTime('pickup_time', '<=', $hoursFromNow)
            ->update(['status' => 'pending']);
    }
}
