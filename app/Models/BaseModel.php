<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;
use Illuminate\Database\Eloquent\SoftDeletes;
use Carbon\Carbon;

class BaseModel extends Model implements HasMedia
{

    use HasFactory, InteractsWithMedia;
    use SoftDeletes;

    protected $appends = ['formatted_date', 'formatted_updated_date', 'photo'];
    protected $casts = [ 'id' => 'integer' ];
    protected $hidden = ['media'];


    public function scopeActive($query){
        return $query->where('is_active', '=', 1);
    }

    public function scopeWithAndWhereHas($query, $relation, $constraint){
        return $query->whereHas($relation, $constraint)
                     ->with([$relation => $constraint]);
    }



    public function registerMediaCollections(): void
    {
        $this
            ->addMediaCollection('default')
            ->useFallbackUrl(''.url('').'/images/default.png')
            ->useFallbackPath(public_path('/images/default.png'));
    }

    public function getPhotoAttribute(){
        return $this->getFirstMediaUrl('default');
    }

    public function getFormattedDateAttribute()
    {
        return $this->created_at->format('d M Y');
    }

    public function getFormattedUpdatedDateAttribute()
    {
        return $this->updated_at->format('d M Y');
    }


    public function calculateDiffInHours($from, $to)
    {
        $from = Carbon::createFromFormat('H:s:i', $from);
        $to = Carbon::createFromFormat('H:s:i', $to);
        return $to->diffInHours($from) ?? 0;
    }

    public function carbonFromTime($time)
    {
        return Carbon::createFromFormat('H:s:i', $time);
    }

}
