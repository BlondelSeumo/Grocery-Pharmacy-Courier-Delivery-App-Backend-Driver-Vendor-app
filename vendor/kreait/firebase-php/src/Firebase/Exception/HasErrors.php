<?php

declare(strict_types=1);

namespace Kreait\Firebase\Exception;

/**
 * @codeCoverageIgnore
 */
trait HasErrors
{
    /** @var array<mixed> */
    protected $errors = [];

    /**
     * @return array<mixed>
     */
    public function errors(): array
    {
        return $this->errors;
    }
}
