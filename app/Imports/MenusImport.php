<?php

namespace App\Imports;

use App\Models\Menu;
use Maatwebsite\Excel\Row;
use Maatwebsite\Excel\Concerns\OnEachRow;
use Maatwebsite\Excel\Concerns\WithHeadingRow;


class MenusImport implements OnEachRow, WithHeadingRow
{

    public function onRow(Row $row)
    {
        $rowIndex = $row->getIndex();
        $row      = $row->toArray();
        if (!empty($row["name"])) {
            Menu::updateOrCreate(
                ['id' => $row["id"]],
                $row
            );
        }
    }
}
