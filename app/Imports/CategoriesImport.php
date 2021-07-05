<?php

namespace App\Imports;

use App\Models\Category;
use Maatwebsite\Excel\Row;
use Maatwebsite\Excel\Concerns\OnEachRow;
use Maatwebsite\Excel\Concerns\WithHeadingRow;


class CategoriesImport implements OnEachRow, WithHeadingRow
{

    public function onRow(Row $row)
    {
        $rowIndex = $row->getIndex();
        $row      = $row->toArray();
        if (!empty($row["name"])) {
            $category = Category::updateOrCreate(
                ['id' => $row["id"]],
                ['name' => $row["name"], 'is_active' => $row["is_active"] ?? 0]
            );

            if ($row["image"] != null && !empty($row["image"])) {

                $category->clearMediaCollection();
                $category->addMediaFromUrl($row["image"])->toMediaCollection();
            }
        }
    }
}
