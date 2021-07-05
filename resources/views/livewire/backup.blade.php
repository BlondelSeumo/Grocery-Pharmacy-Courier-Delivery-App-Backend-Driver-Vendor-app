@section('title', 'Database Backup')
<div>

    <x-baseview title="Database Backups" showButton="true">
        <div class="w-40 ml-auto">
        <x-buttons.primary title="New Backup" wireClick='newBackUp' >
            <x-heroicon-o-plus class="w-5 h-5" />
        </x-buttons.primary>
        </div>

        {{-- table data --}}
        <table class="w-full mt-5 overflow-hidden bg-white border rounded shadow">
            <thead>
                <tr class="bg-gray-300 border-b">
                    <td class="p-2">S/N</td>
                    <td class="p-2">File Name</td>
                    <td class="p-2">File Size</td>
                    <td class="p-2">Created</td>
                    <td class="p-2">Action</td>
                </tr>
            </thead>
            <tbody>
                @php
                    $count = 1;
                @endphp
                @foreach($backups as $backup)
                    @php
                        $infoPath = pathinfo( $backup );
                        $extension = $infoPath['extension'] ?? "";
                    @endphp
                    @if( $extension == "zip" )
                        <tr class="border-b">
                            <td class="p-2">{{ $count }}</td>
                            <td class="p-2">{{ basename($backup) }}</td>
                            <td class="p-2">{{ Storage::size($backup)/1000 }} KB</td>
                            <td class="p-2">{{ \Carbon\Carbon::createFromTimestamp(Storage::lastModified($backup))->format("d M Y \\a\\t h:i a")  }}</td>
                            <td class="flex p-2 space-x-4">
                                {{-- Actions --}}
                                <x-buttons.plain wireClick="downloadBackup('{{ $backup }}')" title="Download">
                                    <x-heroicon-o-cloud-download class="w-5 h-5 mr-2"/>
                                    <span class="">Download</span>
                                </x-buttons.plain>
                                <x-buttons.delete id="'{{ $backup }}'" />
                            </td>
                        </tr>
                        @php
                            $count++;
                        @endphp
                    @endif
                @endforeach
                @if( $count <= 1 )
                    <tr class="border-b">
                        <td class="p-2 text-center" colspan="5">
                            No Backup Yet
                        </td>
                    </tr>
                @endempty
            </tbody>

        </table>

    </x-baseview>


</div>


