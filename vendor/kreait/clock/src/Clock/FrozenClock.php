<?php

declare(strict_types=1);

namespace Kreait\Clock;

use DateTimeImmutable;
use Kreait\Clock;

final class FrozenClock implements Clock
{
    /** @var DateTimeImmutable */
    private $now;

    public function __construct(DateTimeImmutable $now)
    {
        $this->now = $now;
    }

    public function setTo(DateTimeImmutable $now)
    {
        $this->now = $now;
    }

    public function now(): DateTimeImmutable
    {
        return $this->now;
    }
}
