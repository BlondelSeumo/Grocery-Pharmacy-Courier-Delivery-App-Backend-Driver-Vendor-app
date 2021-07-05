<aside
        class="z-20 flex-shrink-0 hidden w-64 overflow-y-auto bg-primary-500 md:block"
      >
        <div class="py-4 text-gray-500 dark:text-gray-400">
          <a
            class="flex items-center ml-6 space-x-4 text-lg font-bold text-gray-100"
            href="{{ route('dashboard') }}">
            <img src="{{ setting('websiteLogo', asset('images/logo.png') ) }}" class="w-16 h-16 rounded"/>
            <div>
                <p>{{ setting('websiteName', env("APP_NAME") ) }}</p>
                <p class="text-xs text-gray-200">version {{ setting('appVerison', "1.0.0" ) }}</p>
            </div>
          </a>
          @include('layouts.partials.nav.menu')
        </div>
      </aside>
