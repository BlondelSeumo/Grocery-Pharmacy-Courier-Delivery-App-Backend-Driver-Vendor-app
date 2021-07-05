@section('title', 'Dashboard')
    <div>
        {{-- If your happiness depends on money, you will never be happy with yourself. --}}
        <x-baseview title="Dashboard">

            {{-- Info cards --}}
            <div class="grid gap-6 mt-10 md:grid-cols-2 lg:grid-cols-4">

                {{-- Orders --}}
                <x-dashboard-card bg="bg-primary-100" title="TOTAL ORDERS" value="{{ $totalOrders }}">
                    <x-heroicon-s-shopping-bag class="w-16 text-primary-600" />
                </x-dashboard-card>

                {{-- Earning --}}
                <x-dashboard-card bg="bg-blue-100" title="TOTAL EARNINGS" value="{{ setting('currency') }} {{ $totalEarnings }}">
                    <x-heroicon-s-cash class="w-16 text-primary-600" />
                </x-dashboard-card>
                @role('admin')
                {{-- Total Vendors --}}
                <x-dashboard-card bg="bg-red-100" title="TOTAL VENDORS" value="{{ $totalVendors }}">
                    <x-heroicon-s-cake class="w-16 text-primary-600" />
                </x-dashboard-card>

                {{-- Users --}}
                <x-dashboard-card bg="bg-yellow-100" title="TOTAL Clients" value="{{ $totalClients }}">
                    <x-heroicon-s-users class="w-16 text-primary-600" />
                </x-dashboard-card>
                @endrole
            </div>

            {{-- Charts --}}
            <div class="grid gap-6 mt-10 mb-20 lg:grid-cols-2">

                {{-- Earning --}}
                <x-dashboard-chart>
                    <livewire:livewire-line-chart :line-chart-model="$earningChart" />
                </x-dashboard-chart>
                @role('admin')
                {{-- Users --}}
                <x-dashboard-chart>
                    <livewire:livewire-line-chart :line-chart-model="$usersChart" />
                </x-dashboard-chart>

                {{-- Total Vendors --}}
                <x-dashboard-chart>
                    <livewire:livewire-line-chart :line-chart-model="$vendorsChart" />
                </x-dashboard-chart>
                @endrole

                {{-- Orders --}}
                <x-dashboard-chart>
                    <livewire:livewire-line-chart :line-chart-model="$ordersChart" />
                </x-dashboard-chart>






            </div>

        </x-baseview>
    </div>
