{{ setting('currency', '$') }}{{ $model->price ?? $model[$column->attribute] ?? '' }}
