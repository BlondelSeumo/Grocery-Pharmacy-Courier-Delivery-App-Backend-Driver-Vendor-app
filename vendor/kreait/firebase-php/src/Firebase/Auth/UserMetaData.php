<?php

declare(strict_types=1);

namespace Kreait\Firebase\Auth;

use DateTimeImmutable;
use Kreait\Firebase\Util\DT;

class UserMetaData implements \JsonSerializable
{
    /** @var DateTimeImmutable|null */
    public $createdAt;

    /** @var DateTimeImmutable|null */
    public $lastLoginAt;

    /** @var DateTimeImmutable|null */
    public $passwordUpdatedAt;

    /**
     * The time at which the user was last active (ID token refreshed), or null
     * if the user was never active.
     *
     * @var DateTimeImmutable|null
     */
    public $lastRefreshAt;

    /**
     * @param array<string, mixed> $data
     */
    public static function fromResponseData(array $data): self
    {
        $metadata = new self();
        $metadata->createdAt = DT::toUTCDateTimeImmutable($data['createdAt']);

        if ($data['lastLoginAt'] ?? null) {
            $metadata->lastLoginAt = DT::toUTCDateTimeImmutable($data['lastLoginAt']);
        }

        if ($data['passwordUpdatedAt'] ?? null) {
            $metadata->passwordUpdatedAt = DT::toUTCDateTimeImmutable($data['passwordUpdatedAt']);
        }

        if ($data['lastRefreshAt'] ?? null) {
            $metadata->lastRefreshAt = DT::toUTCDateTimeImmutable($data['lastRefreshAt']);
        }

        return $metadata;
    }

    /**
     * @return array<string, mixed>
     */
    public function jsonSerialize(): array
    {
        $data = \get_object_vars($this);

        $data['createdAt'] = $this->createdAt ? $this->createdAt->format(\DATE_ATOM) : null;
        $data['lastLoginAt'] = $this->lastLoginAt ? $this->lastLoginAt->format(\DATE_ATOM) : null;

        return $data;
    }
}
