<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "https://www.w3.org/TR/html4/strict.dtd">
<!-- saved from url=(0092)https://mail.google.com/mail/u/6?ik=eaec821c43&view=lg&permmsgid=msg-f%3A1701937600630568273 -->
<html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><style type="text/css" nonce="">
body,td,div,p,a,input {font-family: arial, sans-serif;}
</style><meta http-equiv="X-UA-Compatible" content="IE=edge"><link rel="shortcut icon" href="https://ssl.gstatic.com/ui/v1/icons/mail/rfr/gmail.ico" type="image/x-icon"><title>Order Update</title><style type="text/css" nonce="">
body, td {font-size:13px} a:link, a:active {color:#1155CC; text-decoration:none} a:hover {text-decoration:underline; cursor: pointer} a:visited{color:##6611CC} img{border:0px} pre { white-space: pre; white-space: -moz-pre-wrap; white-space: -o-pre-wrap; white-space: pre-wrap; word-wrap: break-word; max-width: 800px; overflow: auto;} .logo { left: -7px; position: relative; }
</style></head><body><div class="bodycontainer"><div class="maincontent"><table width="100%" cellpadding="0" cellspacing="0" border="0" class="message"><tbody><tr><td colspan="2"><table width="100%" cellpadding="12" cellspacing="0" border="0"><tbody><tr><td><div style="overflow: hidden;"><font size="-1">
<div style="color:#2f313f;font-family:&#39;Google Sans&#39;,Helvetica,Arial;font-size:16px;margin:0!important;width:100%;width:100%">
<center>
<div style="font-family:&#39;Google Sans&#39;,Helvetica,Arial;font-size:16px">
<table cellpadding="0" cellspacing="0" border="0" width="100%" bgcolor="#FFFFFF" style="table-layout:fixed;width:100%;width:100%">
<tbody><tr>
<td style="padding:0">
<table cellpadding="0" cellspacing="0" style="margin:0 auto;width:100%;border-collapse:collapse;background:#f4f4f6" bgcolor="#F4F4F6" class="m_-7689638270191332508header">
<tbody><tr>
<td>
<table cellpadding="0" cellspacing="0" style="margin:0 auto;max-width:632px;width:100%;border-collapse:collapse">
<tbody><tr>
<td colspan="2" style="padding:40px 0 0 16px;vertical-align:top">
<img src="{{ setting('websiteLogo', asset('images/logo.png') ) }}" alt="" width="140" height="140">
</td>
<td style="vertical-align:top;text-align:right;padding-right:16px;padding-top:40px">
<span class="m_-7689638270191332508order-date" style="margin:0;font-size:14px;line-height:18px;color:#7c7d86!important;font-family:&#39;Google Sans&#39;,Helvetica,Arial;text-decoration:none;display:block">­{{ $order->created_at }}</span>
</td>
</tr>
<tr>
<td colspan="2" style="padding:20px 10px 31px 16px">
<p style="margin:0 0 9px;color:#2f313f;font-size:24px;line-height:30px;font-weight:bold!important;font-family:&#39;Google Sans&#39;,Helvetica,Arial"><b>Hi {{ $order->user->name }}!</b></p>
<p style="margin:0;color:#7c7d86;font-size:16px;line-height:20px;font-family:&#39;Google Sans&#39;,Helvetica,Arial">This is your receipt.</p>
</td>
</tr>
</tbody></table>
</td>
</tr>
</tbody></table>
<table cellpadding="0" cellspacing="0" style="margin:0 auto;max-width:632px;width:100%;border-collapse:collapse">
<tbody><tr>
<td colspan="3" style="background:#ffffff;padding:0">
<table class="m_-7689638270191332508header" width="100%" cellpadding="0" cellspacing="0" style="border:none;border-collapse:collapse;width:100%;margin-bottom:30px">
<tbody><tr>
<td class="m_-7689638270191332508header-label" style="padding:40px 16px 0">
<div style="margin:0 auto;max-width:600px;width:100%">
<span style="display:block;margin-top:0;margin-bottom:0;color:#7c7d86;font-size:14px;line-height:16px;font-family:&#39;Google Sans&#39;,Helvetica,Arial">From</span>
<span style="display:block;margin-top:4px;margin-bottom:5px;color:#2f313f;font-size:20px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial">{{ $order->vendor->name }}</span>
<a class="m_-7689638270191332508address-title">­{{ $order->vendor->name }}</a>
</div>
</td>
</tr>

<tr>
<td class="m_-7689638270191332508header-label" style="padding:16px 16px 27px">
<div style="margin:0 auto;max-width:600px;width:100%">
<span style="display:block;margin-top:0;margin-bottom:0;color:#7c7d86;font-size:14px;line-height:16px;font-family:&#39;Google Sans&#39;,Helvetica,Arial">To</span>
<a style="display:block;margin-top:4px;margin-bottom:5px;color:#2f313f!important;font-size:20px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial;text-decoration:none!important" class="m_-7689638270191332508address-title">­{{ $order->delivery_address != null ?$order->delivery_address->name: 'Customer Pickup' }}</a>
</div>
</td>
</tr>
<tr>
<td style="padding:0 16px">
<div style="background:#f4f4f6;height:1px;width:100%;max-width:600px;margin:10px auto"></div>
</td>
</tr>
<tr>
<td style="vertical-align:middle;padding:0 16px">
<table width="100%" cellpadding="0" cellspacing="0" style="table-layout:fixed;width:100%;border:none;border-collapse:collapse;max-width:600px;margin-left:auto;margin-right:auto">
<tbody>
    
    <!-- <start order products!--  -->
        @if( $order->vendor->is_package_vendor )

        <tr>
            <td style="vertical-align:top;padding:0">
            <p style="margin:0 auto;max-width:600px;width:100%">
            <span style="display:inline-block;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial;padding-left:4px;padding-right:1px;float:left">1 x</span>
            
            <span style="color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial;padding-left:4px">{{ $order->package_type->name }}</span>
            </p>
            </td>
            <td style="vertical-align:top;text-align:right;padding:0;table-layout:fixed;max-width:80px;width:80px">
            <p style="display:inline-block;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial;margin-top:0;margin-bottom:0">{{ setting('currency', '$') }} {{ $order->sub_total ?? '0.00' }}</p>
            </td>
            </tr>
        @else

        @foreach ($order->products as $product)
<tr>
<td style="vertical-align:top;padding:0">
<p style="margin:0 auto;max-width:600px;width:100%">
<span style="display:inline-block;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial;padding-left:4px;padding-right:1px;float:left">{{ $product->quantity }} x</span>

<span style="color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial;padding-left:4px">{{ $product->product->name }}</span>
<span style="display:block;font-size:14px;line-height:24px;color:#818391;font-family:&#39;Google Sans&#39;,Helvetica,Arial;padding-left:39px">
    {{ $product->options }}
</span>
</p>
</td>
<td style="vertical-align:top;text-align:right;padding:0;table-layout:fixed;max-width:80px;width:80px">
<p style="display:inline-block;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial;margin-top:0;margin-bottom:0">{{ setting('currency', '$') }} {{ $product->price }}</p>
</td>
</tr>

@endforeach

@endif



<!-- end -->
<tr>
<td colspan="2" style="padding-bottom:0;padding-top:0">
<div style="background:#f4f4f6;height:1px;width:100%;max-width:600px;margin:10px auto"></div>
</td>
</tr>
{{-- subtotal --}}
<tr>
    <td style="vertical-align:middle;padding:0">
    <p style="margin-top:1px;margin-bottom:6px;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial">Subtotal</p>
    </td>
    <td style="vertical-align:middle;text-align:right;padding:0">
    <p style="margin-top:1px;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial"> {{ setting('currency', '$') }} {{ $order->sub_total ?? '0.00' }}</p>
    </td>
    </tr>
{{-- discount --}}
<tr>
    <td style="vertical-align:middle;padding:0">
    <p style="margin-top:1px;margin-bottom:6px;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial">Discount Amount</p>
    </td>
    <td style="vertical-align:middle;text-align:right;padding:0">
    <p style="margin-top:1px;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial"> - {{ setting('currency', '$') }} {{ $order->discount ?? '0.00' }}</p>
    </td>
    </tr>
{{-- delivery fee --}}
<tr>
<td style="vertical-align:middle;padding:0">
<p style="margin-top:1px;margin-bottom:6px;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial">Delivery fee</p>
</td>
<td style="vertical-align:middle;text-align:right;padding:0">
<p style="margin-top:1px;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial">+ {{ setting('currency', '$') }} {{ $order->delivery_fee ?? '0.00' }}</p>
</td>
</tr>
{{-- tax --}}
<tr>
    <td style="vertical-align:middle;padding:0">
    <p style="margin-top:1px;margin-bottom:6px;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial">Tax</p>
    </td>
    <td style="vertical-align:middle;text-align:right;padding:0">
    <p style="margin-top:1px;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial"> + {{ setting('currency', '$') }} {{ $order->tax ?? '0.00' }}</p>
    </td>
    </tr>
<tr>
<td colspan="2" style="padding:0">
<div style="background:#f4f4f6;height:1px;width:100%;max-width:600px;margin:10px auto"></div>
</td>
</tr>
<tr>
<td style="vertical-align:middle;padding:0">
<p style="margin-top:6px;margin-bottom:6px;font-family:&#39;Google Sans&#39;,Helvetica,Arial;color:#2f313f;font-size:20px;line-height:30px"><b>Total charged:</b></p>
</td>
<td style="vertical-align:middle;text-align:right;padding:0">
<p style="margin-top:6px;margin-bottom:6px;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial;color:#2f313f;white-space:nowrap"><b>{{ setting('currency', '$') }} {{ $order->total ?? '0.00' }}</b></p>
</td>
</tr>
<tr>
    <td style="vertical-align:middle;padding:0">
    <p style="margin-top:6px;margin-bottom:6px;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial">Payment Method</p>
    </td>
    <td style="vertical-align:middle;text-align:right;padding:0">
    <p style="margin-top:6px;color:#2f313f;font-size:16px;line-height:24px;font-family:&#39;Google Sans&#39;,Helvetica,Arial">{{ $order->payment_method->name ?? '' }}</p>
    </td>
    </tr>
</tbody></table>
</td>
</tr>
</tbody></table>
</td>
</tr>
<tr>
<td class="m_-7689638270191332508under-footer" colspan="3" style="color:#7c7d86;font-size:12px;height:18px;line-height:14px;padding-bottom:40px;padding-top:32px;text-align:center;width:540px">
© {{ date('Y') }}  {{ setting('websiteName', env("APP_NAME")) }}
</td>
</tr>
</tbody></table>
</td>
</tr>
</tbody></table>
</div>
</center>
<img src="./Gmail - Delivery from Bolt Food_files/unnamed.gif" alt="" width="1" height="1" border="0" style="height:1px!important;width:1px!important;border-width:0!important;margin-top:0!important;margin-bottom:0!important;margin-right:0!important;margin-left:0!important;padding-top:0!important;padding-bottom:0!important;padding-right:0!important;padding-left:0!important">
</div>
</font></div></td></tr></tbody></table></td></tr></tbody></table></div><div id="extwaiokist" style="display:none" v="jjhpi" q="450d6f9d" c="192.2" i="198" u="192.1" s="06022121" d="1" w="false" e="" m="BMe=" vn="3vdo1"><div id="extwaigglbit" style="display:none" v="jjhpi" q="450d6f9d" c="192.2" i="198" u="192.1" s="06022121" d="1" w="false" e="" m="BMe="></div></div></div></body></html>