@extends('layouts.auth')
@section('title', "Privacy Policy")
@section('content')
<div class="w-10/12 mx-auto my-10">
    {!! setting('privacyPolicy', "") !!}
</div>
@endsection
