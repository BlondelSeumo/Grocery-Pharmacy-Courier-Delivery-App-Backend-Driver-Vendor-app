<?php

namespace App\Imports;

use App\Models\Vendor;
use Maatwebsite\Excel\Row;
use Maatwebsite\Excel\Concerns\OnEachRow;
use Maatwebsite\Excel\Concerns\WithHeadingRow;


class VendorsImport implements OnEachRow, WithHeadingRow
{

    public function onRow(Row $row)
    {
        $rowIndex = $row->getIndex();
        $row      = $row->toArray();
        if (!empty($row["name"])) {
            $vendor = Vendor::updateOrCreate(
                ['id' => $row["id"]],
                $row
            );

            //
            $categoriesIds = explode(",", $row["categories_id"]);
            $vendor->categories()->sync($categoriesIds);
        }
    }
}
