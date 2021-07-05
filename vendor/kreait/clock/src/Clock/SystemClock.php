<?php

declare(strict_types=1);

namespace Kreait\Clock;

use DateTimeImmutable;
use DateTimeZone;
use Kreait\Clock;
use function date_default_timezone_get;

final class SystemClock implements Clock
{
    /** @var DateTimeZone */
    private $timezone;

    public function __construct(DateTimeZone $timezone = null)
    {
        $this->timezone = $timezone ?: new DateTimeZone(date_default_timezone_get());
    }

    public function now(): DateTimeImmutable
    {
        return new DateTimeImmutable('now', $this->timezone);
    }
}
