<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" type="image/png" href="{{ setting('favicon') }}" />
    <title>@yield('title', "" ) - {{ setting('websiteName', env('APP_NAME')) }}</title>
    @include('layouts.partials.styles')
    @yield('styles')
</head>

<body>
    {{ $slot ?? '' }}
    @yield('content')

    {{-- footer --}}
    @include('layouts.partials.scripts')
    @stack('scripts')
</body>

</html>
