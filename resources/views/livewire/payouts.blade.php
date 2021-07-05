@section('title', 'Payout '.Str::ucfirst($type))
<div>

    <x-baseview title="Payout {{ Str::ucfirst($type) }}">
        @livewire('tables.payout-table', [
            "type" => $type
        ])
    </x-baseview>



</div>


