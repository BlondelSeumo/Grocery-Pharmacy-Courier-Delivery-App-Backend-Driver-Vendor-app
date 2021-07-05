<?php

declare(strict_types=1);

namespace BladeUI\Icons\Components;

use Illuminate\View\Component;

final class Svg extends Component
{
    public function render()
    {
        return function (array $data) {
            $attributes = $data['attributes']->getIterator()->getArrayCopy();

            $class = $attributes['class'] ?? '';

            unset($attributes['class']);

            return svg($this->componentName, $class, $attributes)->toHtml();
        };
    }
}
