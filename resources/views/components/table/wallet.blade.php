{{ setting('currency', '$') }} {{ number_format( $model->wallet->balance ?? 0.00, 2 ) }}
