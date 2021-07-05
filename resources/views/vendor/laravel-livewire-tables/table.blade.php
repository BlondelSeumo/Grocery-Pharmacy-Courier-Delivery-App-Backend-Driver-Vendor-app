<div>
    <div class="items-center justify-between block my-3 md:flex">
        @if($show_search ?? true )
            <div class="w-full">
                <div class="flex items-center w-10/12 p-2 bg-white border border-gray-300 rounded md:w-5/12">
                    <span class="input-group-text"><i class="fa fa-search"></i></span>
                    <input type="search" class="w-full h-6 px-3 focus:outline-none" placeholder="{{ __('Search') }}" wire:model="search">
                </div>
            </div>
        @endif
        @if($header_view)
            <div class="ml-auto">
                @include($header_view)
            </div>
        @endif
    </div>

    <div class="mb-3 card">
        @if($models->isEmpty())
            <div class="card-body">
                {{ __('No results to display.') }}
            </div>
        @else
            <div class="p-0 card-body">
                <div class="table-responsive">
                    <table class="table {{ $table_class }} mb-0">
                        <thead class="{{ $thead_class }}">
                        <tr>
                            @if($checkbox && $checkbox_side == 'left')
                                @include('laravel-livewire-tables::checkbox-all')
                            @endif

                            @foreach($columns as $column)
                                <th class="align-middle text-nowrap border-top-0 {{ $this->thClass($column->attribute) }}">
                                    @if($column->sortable)
                                        <span style="cursor: pointer;" wire:click="sort('{{ $column->attribute }}')">
                                            {{ $column->heading }}

                                            @if($sort_attribute == $column->attribute)
                                                <i class="fa fa-sort-amount-{{ $sort_direction == 'asc' ? 'up-alt' : 'down' }}"></i>
                                            @else
                                                <i class="fa fa-sort-amount-up-alt" style="opacity: .35;"></i>
                                            @endif
                                        </span>
                                    @else
                                        {{ $column->heading }}
                                    @endif
                                </th>
                            @endforeach

                            @if($checkbox && $checkbox_side == 'right')
                                @include('laravel-livewire-tables::checkbox-all')
                            @endif
                        </tr>
                        </thead>
                        <tbody>
                        @foreach($models as $model)
                            <tr class="{{ $this->trClass($model) }}">
                                @if($checkbox && $checkbox_side == 'left')
                                    @include('laravel-livewire-tables::checkbox-row')
                                @endif

                                @foreach($columns as $column)
                                    <td class="align-middle {{ $this->tdClass($column->attribute, $value = Arr::get($model->toArray(), $column->attribute)) }}">
                                        @if($column->view)
                                            @include($column->view)
                                        @else
                                            {{ $value }}
                                        @endif
                                    </td>
                                @endforeach

                                @if($checkbox && $checkbox_side == 'right')
                                    @include('laravel-livewire-tables::checkbox-row')
                                @endif
                            </tr>
                        @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        @endif
    </div>

    <div class="row justify-content-between">
        <div class="col-auto">
            {{ $models->links() }}
        </div>
        @if($footer_view)
            <div class="col-md-auto">
                @include($footer_view)
            </div>
        @endif
    </div>
</div>
