<!-- Backdrop -->
<div
x-show="isSideMenuOpen"
x-transition:enter="transition ease-in-out duration-150"
x-transition:enter-start="opacity-0"
x-transition:enter-end="opacity-100"
x-transition:leave="transition ease-in-out duration-150"
x-transition:leave-start="opacity-100"
x-transition:leave-end="opacity-0"
class="fixed inset-0 z-10 flex items-end bg-black bg-opacity-50 sm:items-center sm:justify-center"
></div>
<aside
class="fixed inset-y-0 z-20 flex-shrink-0 w-64 mt-16 overflow-y-auto bg-primary-500 dark:bg-gray-800 md:hidden"
x-show="isSideMenuOpen"
x-transition:enter="transition ease-in-out duration-150"
x-transition:enter-start="opacity-0 transform -translate-x-20"
x-transition:enter-end="opacity-100"
x-transition:leave="transition ease-in-out duration-150"
x-transition:leave-start="opacity-100"
x-transition:leave-end="opacity-0 transform -translate-x-20"
@click.away="closeSideMenu"
@keydown.escape="closeSideMenu"
>
<div class="py-4 text-gray-500 dark:text-gray-400">
  <a
    class="flex items-center ml-6 text-lg font-bold text-gray-100"
    href="{{ route('dashboard') }}">
    <img src="{{ setting('websiteLogo', asset('images/logo.png') ) }}" class="w-16 h-16"/>
    <div>
        <p>{{ setting('websiteName', env("APP_NAME") ) }}</p>
        <p class="text-xs text-gray-200">version {{ setting('appVerison', "1.0.0" ) }}</p>
    </div>
  </a>
  @include('layouts.partials.nav.menu')
</div>
</aside>
