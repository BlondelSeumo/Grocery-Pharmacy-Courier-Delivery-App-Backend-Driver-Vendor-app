<?php

namespace App\Http\Livewire;

use App\Models\Vendor;
use App\Models\Order;
use App\Models\User;
use Asantibanez\LivewireCharts\Models\LineChartModel;
use Carbon\Carbon;
use Numbers\Number;
use Livewire\Component;


class DashboardLivewire extends Component
{
    public function render()
    {

        $totalOrders = Number::n(Order::mine()->count())->round(3)->getSuffixNotation();
        $totalEarnings = Number::n(Order::mine()->sum('total'))->round(3)->getSuffixNotation();
        $totalVendors = Number::n(Vendor::count())->round(3)->getSuffixNotation();
        $totalClients = Number::n(User::client()->count())->round(3)->getSuffixNotation();

        return view('livewire.dashboard',[
            "totalOrders" => $totalOrders,
            "totalEarnings" => $totalEarnings,
            "totalVendors" => $totalVendors,
            "totalClients" => $totalClients,

            "earningChart" => $this->earningChart(),
            "usersChart" => $this->usersChart(),
            "vendorsChart" => $this->vendorsChart(),
            "ordersChart" => $this->ordersChart(),
        ]);
    }




    public function earningChart(){

        //
        $chart = (new LineChartModel())->setTitle('Total Earning ('.Date("Y").')')->withoutLegend();

        for( $loop = 0; $loop < 12; $loop++ ){
            $date = Carbon::now()->firstOfYear()->addMonths($loop);
            $formattedDate = $date->format("M");
            $data = Order::mine()->whereMonth("created_at" , $date )->sum('total');

            //
            $chart->addPoint(
                $formattedDate,
                $data,
                $this->genColor(),
            );
        }


        return $chart;

    }

    public function usersChart(){

        //
        $chart = (new LineChartModel())->setTitle('Users This Week')->withoutLegend();

        for( $loop = 0; $loop < 7; $loop++ ){
            $date = Carbon::now()->startOfWeek()->addDays($loop);
            $formattedDate = $date->format("D");
            $data = User::whereDate("created_at" , $date )->count();

            //
            $chart->addPoint(
                $formattedDate,
                $data,
                $this->genColor(),
            );
        }


        return $chart;

    }

    public function vendorsChart(){

        //
        $chart = (new LineChartModel())->setTitle('Vendors This Year')->withoutLegend();

        for( $loop = 0; $loop < 12; $loop++ ){
            $date = Carbon::now()->firstOfYear()->addMonths($loop);
            $formattedDate = $date->format("M");
            $data = Vendor::whereMonth("created_at" , $date )->count();

            //
            $chart->addPoint(
                $formattedDate,
                $data,
                $this->genColor(),
            );
        }


        return $chart;

    }


    public function ordersChart(){

        //
        $chart = (new LineChartModel())->setTitle('Total Orders ('.Date("Y").')')->withoutLegend();

        for( $loop = 0; $loop < 12; $loop++ ){
            $date = Carbon::now()->firstOfYear()->addMonths($loop);
            $formattedDate = $date->format("M");
            $data = Order::mine()->whereMonth("created_at" , $date )->count();

            //
            $chart->addPoint(
                $formattedDate,
                $data,
                $this->genColor(),
            );
        }

        return $chart;

    }





    public function genColor(){
        return '#' . substr(str_shuffle('ABCDEF0123456789'), 0, 6);
    }
}
